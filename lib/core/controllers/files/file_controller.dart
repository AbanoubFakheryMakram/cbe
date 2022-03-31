
abstract class FilesController {

  Future<bool> deleteFile(String path, {bool absolutePath = false});

  /// is this file existed in this path
  Future<bool> isFileExisted(String path, {bool absolutePath = false});

  /// is this directory existed in this path
  Future<bool> isDirectoryExisted(String path, {bool absolutePath = false});

  /// is this path contained file or directory
  Future<bool> isPathExisted(String path, {bool absolutePath = false});

  Future<String> readFileData(String path, {bool absolutePath = false});

  Future<bool> appendFileContent(String path, String data, {bool absolutePath = false});

  Future<bool> overrideFileContent(String path, String data, {bool absolutePath = false});

}
