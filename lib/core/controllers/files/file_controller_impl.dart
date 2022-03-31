import 'dart:io';

import 'file_controller.dart';
import 'package:path_provider/path_provider.dart';

class FilesControllerImpl implements FilesController {

  @override
  Future<bool> deleteFile(String path, {bool absolutePath = false}) async {
    String fullPath = await _getAbsolutePath(path, absolutePath: absolutePath);
    if (await isFileExisted(fullPath, absolutePath: true)) {
      await File(fullPath).delete();
    } else if (await isDirectoryExisted(fullPath, absolutePath: true)) {
      await Directory(fullPath).delete();
    }
    return true;
  }

  @override
  Future<bool> appendFileContent(String path, String data, {bool absolutePath = false}) async {
    var file = await _localFile(path, absolutePath: absolutePath);
    await file.writeAsString(data, mode: FileMode.append);
    return true;
  }

  @override
  Future<bool> overrideFileContent(String path, String data, {bool absolutePath = false}) async {
    var file = await _localFile(path, absolutePath: absolutePath);
    await file.writeAsString(data, mode: FileMode.append);
    return true;
  }

  @override
  Future<String> readFileData(String path, {bool absolutePath = false}) async {
    try {
      var file = await _localFile(path, absolutePath: absolutePath);
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  @override
  Future<bool> isPathExisted(String path, {bool absolutePath = false}) async {
    bool fileExists = await isFileExisted(path);
    bool directoryExists = await isDirectoryExisted(path);
    if (directoryExists || fileExists) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> isDirectoryExisted(String path, {bool absolutePath = false}) async {
    String fullPath = await _getAbsolutePath(path, absolutePath: absolutePath);
    return await Directory(fullPath).exists();
  }

  @override
  Future<bool> isFileExisted(String path, {bool absolutePath = false}) async {
    String fullPath = await _getAbsolutePath(path, absolutePath: absolutePath);
    return await File(fullPath).exists();
  }

  ///region ============= private helpers
  //return path
  Future<File> _localFile(String path, {bool absolutePath = false}) async {
    String fullPath = await _getAbsolutePath(path, absolutePath: absolutePath);

    var file = File(fullPath);
    if (!(await isPathExisted(path))) {
      file = await file.create(recursive: true);
    }
    return file;
  }

  Future<String> _getAbsolutePath(String path, {bool absolutePath = false}) async {
    var fullPath = path;
    if (!absolutePath) {
      if(Platform.isAndroid){
        fullPath = '/storage/emulated/0/linkdev/$path';
      } else{
        var result = (await getApplicationSupportDirectory()).path;
        fullPath = "$result/$path";
      }
    }
    return fullPath;
  }

  ///endregion
}
