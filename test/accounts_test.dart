import 'package:hex/hex.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:test/test.dart';

import 'package:bitcoin_bip44/bitcoin_bip44.dart';

void main() {
  Account account;

  setUp(() {
    var bip44 = Bip44(toHexString('some seed'));
    var bitcoin = bip44.coins[0];
    account = Account(bitcoin, 0, changeExternal);
  });

  test('list used addresses', () async {
    scanners = [MockScanner()];
    expect(await account.usedAddresses(), hasLength(10));
  });

  test('return next unused address', () async {
    scanners = [MockScanner()];

    var next = await account.nextUnusedAddress();

    expect(next, isNotNull);

    expect(next.index, 10);
  });

  group('address genenration with given public key', () {
    var publicKey = HEX.decode(
        '0279BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798');
    ECPoint point;

    setUp(() {
      var curve = ECCurve_secp256k1().curve;
      point = curve.decodePoint(publicKey);
    });

    test('generate P2PKH', () {
      var expectedAddress = '1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH';

      expect(toP2PKH(point), expectedAddress);
    });

    test('generate P2WPKH', () {
      // Public key -> address is taken from BIP173 examples: https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki#Examples
      var expectedSegwitAddress = 'bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4';

      expect(toP2WPKH(point), expectedSegwitAddress);
    });
  });
}

String toHexString(String original) {
  return original.codeUnits
      .map((c) => c.toRadixString(16).padLeft(2, '0'))
      .toList()
      .join('');
}

class MockScanner implements Scanner {
  int counter = 0;

  @override
  Future<bool> present(String address) {
    if (counter < 10) {
      counter++;
      return Future.value(true);
    }
    return Future.value(false);
  }
}
