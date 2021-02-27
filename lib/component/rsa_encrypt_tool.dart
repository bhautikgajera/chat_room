import 'package:flutter/cupertino.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:rsa_encrypt/rsa_encrypt.dart';

class EncryptAndDecrypt {
  static Future<String> encryptMessage(
      {String plainText,
      String encryptedText,
      @required bool doEncrypt}) async {
    Future<crypto.AsymmetricKeyPair> futureKeyPair;

//to store the KeyPair once we get data from our future
    crypto.AsymmetricKeyPair keyPair;

    Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
        getKeyPair() {
      var helper = RsaKeyHelper();
      return helper.computeRSAKeyPair(helper.getSecureRandom());
    }

    futureKeyPair = getKeyPair();
    keyPair = await futureKeyPair;
    var encryptedMessage = encrypt(plainText, keyPair.publicKey);
    var decryptedMessage = decrypt(encryptedText, keyPair.privateKey);
    if (doEncrypt) {
      return encryptedMessage;
    }
    if (!doEncrypt) {
      return decryptedMessage;
    }
    return 'Somthing Went Wrong with encryption';
  }

  static Future<String> decryptMessage(String message) async {
    Future<crypto.AsymmetricKeyPair> futureKeyPair;

//to store the KeyPair once we get data from our future
    crypto.AsymmetricKeyPair keyPair;

    Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
        getKeyPair() {
      var helper = RsaKeyHelper();
      return helper.computeRSAKeyPair(helper.getSecureRandom());
    }

    futureKeyPair = getKeyPair();
    keyPair = await futureKeyPair;
    String decryptedMessage = decrypt(message, keyPair.privateKey);

    return decryptedMessage;
  }
}
