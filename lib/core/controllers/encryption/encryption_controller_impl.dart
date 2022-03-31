
import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';

import '/core/error/failure.dart';

import 'encryption_controller.dart';

class EncryptionControllerImpl implements EncryptionController {

  late final AesCrypt crypt;

  @override
  Future<String?> decryptFile(String encryptedFilePath, String outputFileNameWithExtension, {String? password}) async {
    if(password != null) {
      crypt.setPassword(password);
    }
    String? decFilepath;
    try {
      decFilepath = crypt.decryptFileSync(encryptedFilePath, outputFileNameWithExtension);
    } on AesCryptException catch (e) {
      print(e.message);
      if (e.type == AesCryptExceptionType.destFileExists) {
      }
    }
    return decFilepath;
  }

  @override
  Future<String?> decryptTextFromFile(String filePath) async {
    return await crypt.decryptTextFromFile(filePath);
  }

  @override
  Future<void> encryptFile(String filePath, String outputFileNameWithExtension, {String? password}) async {
    if(password != null) {
      crypt.setPassword(password);
    }
    try {
      crypt.encryptFileSync(filePath, outputFileNameWithExtension);
    } on AesCryptException catch (e) {
      print(e.message);
      if (e.type == AesCryptExceptionType.destFileExists) {
        throw EncryptionFailure(data: e.message);
      }
    }
  }

  @override
  Future<void> encryptTextToFile(String text, String outputFilePath) async {
    await crypt.encryptTextToFile(text, outputFilePath);
  }

  @override
  Future<void> init(String password) async {
    crypt = AesCrypt(password);
  }

  @override
  Future<void> setAesMode(AesMode mode) async {
    crypt.aesSetMode(mode);
  }

  @override
  Future<void> setFileOverwriteMode(AesCryptOwMode mode) async {
    crypt.setOverwriteMode(mode);
  }
}