
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../http/http_helper.dart';
import '../../../l10n/app_localization.dart';
import '../../../widgets/info_doalog.dart';
import '/features/no_internet_connection/presentation/pages/no_internet_connection_page.dart';
import '/core/controllers/dialogs/dialog_controller.dart';
import '/core/controllers/network/network_info.dart';

import '../../error/failure.dart';
import '../navigation/navigation_controller.dart';
import 'executor.dart';

class ActionExecutorImpl extends ActionExecutor {
  final NetworkInfoController connectivityService;
  final DialogController dialogService;
  final NavigationController navigationService;

  ActionExecutorImpl({required this.connectivityService, required this.dialogService, required this.navigationService});

  @override
  Future<Either<Failure, T>> execute<T>(EitherResultCallBack<T> action, {bool checkInternet = true, bool showLoading = true, HandelErrorCallBack? handleError}) async {
    try {
      if (checkInternet) {
        await _checkInternetConnection(callBack: () => execute<T>(action, checkInternet: checkInternet, showLoading: showLoading, handleError: handleError));
      }
      if (showLoading) _showLoading();
      var result = await action.call();
      if (result is Left) {
        _handleError((result as Left).value);
      }
      return result;
    } on DioError catch (error) {
      var failure = HttpHelper.handleDioError(error);
      _handleError(failure);
      return Left(failure);
    } catch (error, st) {
      var handled = await handleError?.call(failure: CustomFailure(data: error.toString()));
      if (handled != true) {
        _handleError(CustomFailure(data: AppLocalization.translation.genericError));
      }
      return Left(UnknownFailure());
    }
    finally {
      if (showLoading) {
        _hideLoading();
      }
    }
  }

  Future<bool> _checkInternetConnection({VoidCallback? callBack}) async {
    var connected = await connectivityService.isConnected;
    if (!connected) {
      await navigationService.push(NoInternetConnectionPage(afterNetworkBackCallback: callBack));
    }

    return connected;
  }

  Future<void> _handleError(Failure failure) async {
    print('Failure Type: $failure');
    await dialogService.showCustomDialog(bodyWidget: InfoDialog(body: failure.msg ?? '', title: AppLocalization.translation.errorTitle));
  }

   _showLoading() {
    // show loader
  }

  _hideLoading() {
    // hide loader
  }
}