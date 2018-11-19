import 'package:test/test.dart';

import "package:bitcoin_bip44/bitcoin_bip44.dart";

void main() {
  Bip44 bip44;

  setUp(() {
    bip44 = Bip44(toHexString("some seed"));
  });

  test("initialize", () {
    expect(bip44, isNotNull);
  });

  group("coins", () {
    test("list all coins", () {
      expect(bip44.coins(), hasLength(3));
    });

    test("for bitcoin", () {
      expect(bip44.coins()[0].path, "m/44'/0'");
    });

    test("for testnets", () {
      expect(bip44.coins()[1].path, "m/44'/1'");
    });

    test("for litecoin", () {
      expect(bip44.coins()[2].path, "m/44'/2'");
    });

    test("list accounts for coin", () {});
  });

  test("list addresses for account", () {
    var bitcoin = bip44.coins()[0];
    var addresses = bitcoin.accounts().first.usedAddresses();
  });

  test("return next unused account", () {});
}

String toHexString(String original) {
  return original.codeUnits
      .map((c) => c.toRadixString(16).padLeft(2, "0"))
      .toList()
      .join("");
}
