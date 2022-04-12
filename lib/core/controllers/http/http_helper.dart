
import 'dart:io';

import 'package:dio/dio.dart';
import '/core/base/service_locator.dart';
import '/core/controllers/cache/cache_controller.dart';
import 'http_controller.dart';
import '../settings/settings_controller.dart';
import '/l10n/app_localization.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../error/failure.dart';
import '../../base/api_routes.dart';
import '../../../utils/extensions/strings.dart';

class HttpHelper {
  static const int connectTimeout = 40000, receiveTimeout = 40000, sendTimeout = 40000;

  static final _cacheController = serviceLocator<CacheController>();
  static final _settingsController = serviceLocator<SettingsController>();
  static final _httpController = serviceLocator<HttpController>();

  static BaseOptions options() {
    return BaseOptions(
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      connectTimeout: connectTimeout,
      baseUrl: ApiRoutes.baseUrl,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
      headers: {
        'Authorization': 'Bearer ${_getToken()}',
        'content-type': 'application/json',
        'Accept': "application/json",
      },
    );
  }

  static InterceptorsWrapper buildInterceptor() {
    return InterceptorsWrapper(
      onRequest: onRequest,
      onResponse: onResponse,
      onError: onError,
    );
  }

  static void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
      try {
        var token = _cacheController.getToken();
        if (token != null && !token.accessToken.isNullOrEmpty() && options.path != ApiRoutes.refreshToken()) {
          if (token.shouldRefreshTokenAt(DateTime.now().add(const Duration(minutes: 2)).toUtc())) {
            // refresh access token action
            await refreshToken();
          }
          options.headers['Authorization'] = 'Bearer ${token.accessToken!}';
        }
        options.headers.addAll({
          'operating-system': Platform.operatingSystem,
          'accept-language': _settingsController.locale.toLowerCase(),
        });
      } finally {
        // must call it to continue request
        handler.next(options);
      }
    }

  // review the new token
  static void onError(DioError error, ErrorInterceptorHandler handler) async {
    // Assume 401 stands for token expired
    if (error.response?.statusCode == 401 && error.requestOptions.path != ApiRoutes.refreshToken()) {
      var success = await refreshToken();
      if (success) {
        // retry old action
        handler.resolve(
          await _httpController.retry(
            error.requestOptions,
          ),
        );
      }
    } else {
      handler.next(error);
    }
  }

  static void onResponse(Response response, ResponseInterceptorHandler handler) {
    // add custom validation on response
    handler.next(response); //continue
  }

  static PrettyDioLogger getPrettyDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      request: true,
    );
  }

  static String _getToken() {
    return '';
  }

  static Failure handleDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return RequestCanceledFailure(msg: AppLocalization.translation.requestHasCancelledErrorMessage);
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
        return ConnectionTimeoutFailure(msg: AppLocalization.translation.requestTimeoutErrorMessage);
      case DioErrorType.response:
      case DioErrorType.other:
      return handleStatuesCodeResponse(dioError.response);
    }
  }

  static dynamic handleStatuesCodeResponse(Response? response) {
    if(response == null) {
      return UnknownFailure(msg: AppLocalization.translation.genericError);
    } else {
      switch (response.statusCode) {
        case 200:
          return response;
        case 500:
          return InternalServerErrorFailure(msg: AppLocalization.translation.genericError);
        case 400:
          return BadRequestFailure(msg: AppLocalization.translation.badRequestMsg);
        case 401:
          return UnauthorizedFailure(msg: AppLocalization.translation.unAuthorizedError);
        case 404:
          return NotFoundFailure(msg: AppLocalization.translation.notFound);
        case 405:
          return MethodNotAllowedFailure(msg: AppLocalization.translation.methodNotAllowed);
        case 408:
          return ConnectionTimeoutFailure(msg: AppLocalization.translation.requestTimeoutErrorMessage);
        default:
          return NoInternetConnectionFailure(msg: AppLocalization.translation.noInternetConnection);
      }
    }
  }

  static Future<bool> refreshToken() {
    return Future.value(true);
  }
}