import 'package:test/test.dart';

import "package:bitcoin_bip44/bitcoin_bip44.dart";

void main() {
  Account account;

  setUp(() {
    Bip44 bip44 = Bip44(toHexString("some seed"));
    Coin bitcoin = bip44.coins[0];
    account = Account(bitcoin, 0, changeExternal);
  });

  test("list used addresses", () async {
    scanners = [MockScanner()];
    expect(await account.usedAddresses(), hasLength(10));
  });

  test("return next unused address", () async {
    scanners = [MockScanner()];

    Address next = await account.nextUnusedAddress();

    expect(next, isNotNull);

    expect(next.index, 10);
  });
}

String toHexString(String original) {
  return original.codeUnits
      .map((c) => c.toRadixString(16).padLeft(2, "0"))
      .toList()
      .join("");
}

class MockScanner implements Scanner {
  int counter = 0;

  Future<bool> present(String address) {
    if (counter < 10) {
      counter++;
      return Future.value(true);
    }
    return Future.value(false);
  }
}
