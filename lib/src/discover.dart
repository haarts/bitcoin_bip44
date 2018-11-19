import 'package:bech32/bech32.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:base58check/base58check.dart';

final sha256 = SHA256Digest();
final ripemd160 = RIPEMD160Digest();

abstract class Scanner {
  Future<bool> present(String address);
}

String toP2WPKH(ECPoint publicKey) {
  var bytes = publicKey.getEncoded(true);
  var hashed = ripemd160.process(sha256.process(bytes));
  return segwit.encode(Segwit('bc', 0, hashed));
}

String toP2PKH(ECPoint publicKey) {
  var bytes = publicKey.getEncoded(true);
  var hashed = ripemd160.process(sha256.process(bytes));
  return Base58CheckCodec.bitcoin().encode(Base58CheckPayload(0, hashed));
}
