
import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';

abstract class EncryptionController {
  Future<void> init(String password);

  // Specifies the overwrite mode for write file operations
  Future<void> setFileOverwriteMode(AesCryptOwMode mode);

  // Encrypts the file test.txt and saves encrypted file under the name test.txt.aes
  Future<void> encryptFile(String filePath, String outputFileNameWithExtension, {String? password});

  // Decrypts the file test.txt.aes and saves decrypted file under the name test.txt
  Future<String?> decryptFile(String encryptedFilePath, String outputFileNameWithExtension, {String? password});

  // Encrypts the text as UTF8 string and saves it into 'mytext.txt.aes' file.
  Future<void> encryptTextToFile(String text, String outputFilePath);

  Future<String?> decryptTextFromFile(String filePath);

  // Specifies the mode of operation of the AES algorithm.
  // It can be one of the next values:
  //    AesMode.ecb - ECB (Electronic Code Book)
  //    AesMode.cbc - CBC (Cipher Block Chaining)
  //    AesMode.cfb - CFB (Cipher Feedback)
  //    AesMode.ofb - OFB (Output Feedback)
  // By default the mode is AesMode.cbc
  Future<void> setAesMode(AesMode mode);
}