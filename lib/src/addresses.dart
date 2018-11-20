import 'package:bech32/bech32.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:base58check/base58check.dart';

import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'accounts.dart';

final sha256 = SHA256Digest();
final ripemd160 = RIPEMD160Digest();

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

class Address {
  final Account account;
  final int index;

  Address(Account account, int index)
      : account = account,
        index = index;

  String get path => "${account.path}/$index";
  Chain get chain => account.chain;
  ECPoint get publicKey => chain.forPath(path).publicKey().q;

  String get P2PKH => toP2PKH(chain.forPath(path).publicKey().q);
  String get P2WPKH => toP2WPKH(chain.forPath(path).publicKey().q);
}
