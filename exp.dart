import 'package:pointycastle/api.dart' as crypto;
import 'package:rsa_encrypt/rsa_encrypt.dart';

void main() async {
  //Future to hold our KeyPair
  Future<crypto.AsymmetricKeyPair> futureKeyPair;

//to store the KeyPair once we get data from our future
  crypto.AsymmetricKeyPair keyPair;

  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
      getKeyPair() {
    var helper = RsaKeyHelper();
    var a = helper.computeRSAKeyPair(helper.getSecureRandom());

    return a;
  }

  futureKeyPair = getKeyPair();
  keyPair = await futureKeyPair;
  var encryption = encrypt('bhautiik', keyPair.publicKey);
  print('<><><<<${encryption.runtimeType}');

  var decryption = decrypt(encryption, keyPair.privateKey);

  print(decryption);
}
