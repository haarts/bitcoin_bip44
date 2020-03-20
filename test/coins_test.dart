import 'package:test/test.dart';

import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'package:bitcoin_bip44/bitcoin_bip44.dart';

void main() {
  test('list accounts', () async {
    Coin coin = Coin(Chain.seed('00'), bitcoin);
    scanners = [MockScanner()];

    expect(await coin.accounts(), hasLength(10));
  });
}

class MockScanner implements Scanner {
  int counter = 0;

  Future<bool> present(String address) {
    if (counter > 19) {
      return Future.value(false);
    }

    counter++;
    if (counter % 2 == 1) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
