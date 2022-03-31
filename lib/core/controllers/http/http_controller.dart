
import 'package:dio/dio.dart';
import '../../models/requests/request_data.dart';

abstract class HttpController {

  Future<Response> get(String url, {RequestData? requestData});

  Future<Response> post(String url, request, {RequestData? requestData});

  Future<Response> postWithFile(String url, request, {RequestData? requestData});

  Future<Response> delete(String url, {RequestData? requestData});

  Future<Response> put(String url, Map<String, dynamic> request, {RequestData? requestData});

  Future<Response> patch(String url, Map<String, dynamic> request, {RequestData? requestData});

  Future<Response> retry(RequestOptions requestOptions);
}