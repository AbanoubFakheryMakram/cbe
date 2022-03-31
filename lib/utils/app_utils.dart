
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/error/failure.dart';
import 'dart:math' as math;

class AppUtils {
  static String buildErrorMsg(Failure failure) {
    log('failure: $failure');
    if(failure is CustomFailure) return failure.data;
    if(failure is NoInternetConnectionFailure) {
      return 'no_internet_connection';
    } else if(failure is InternalServerErrorFailure) {
      return 'internal_server_error';
    } else if(failure is UnauthorizedFailure) {
      return 'not_authorized';
    } else if(failure is NotFoundFailure) {
      return 'not_found';
    } else if(failure is MethodNotAllowedFailure) {
      return 'method_not_allowed';
    } else if(failure is ConnectionTimeoutFailure) {
      return 'connection_timeout';
    } else if(failure is BadRequestFailure) {
      return 'bad_request';
    } else if(failure is HttpFailure) {
      return 'http_exception';
    } else if(failure is FormatFailure) {
      return 'format_exception';
    } else {
      return 'unknown_error';
    }
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showSnakeBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontSize: 14), textDirection: TextDirection.rtl,),
      ),
    );
  }

  static List<List> chunkList(List l, {int chunkSize = 3}) {
    List<List> chunks = [];
    for (var i = 0; i < l.length; i += chunkSize) {
      chunks.add(l.sublist(i, i+chunkSize > l.length ? l.length : i + chunkSize));
    }
    return chunks;
  }

  static Future<bool> requestPermission(Permission permission) async {
    if(await permission.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static String generateGuid() {
    math.Random random = math.Random(DateTime.now().millisecond);

    const String hexDigits = "0123456789abcdef";
    final List<String> uuid = List.filled(36, '0');

    for (int i = 0; i < 36; i++) {
      final int hexPos = random.nextInt(16);
      uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
    }

    int pos = (int.parse(uuid[19], radix: 16) & 0x3) | 0x8; // bits 6-7 of the clock_seq_hi_and_reserved to 01

    uuid[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    uuid[19] = hexDigits.substring(pos, pos + 1);

    uuid[8] = uuid[13] = uuid[18] = uuid[23] = "-";

    final StringBuffer buffer = StringBuffer();
    buffer.writeAll(uuid);
    return buffer.toString();
  }
}