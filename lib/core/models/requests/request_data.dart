
import 'dart:io';

class RequestData {
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? requestParameters;
  final ContentType? contentType;

  RequestData({this.headers, this.contentType, this.requestParameters});
}