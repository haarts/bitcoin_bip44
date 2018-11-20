import 'package:test/test.dart';

import "package:bitcoin_bip44/bitcoin_bip44.dart";

void main() {
  Address address;

  setUp(() {
    Bip44 bip44 = Bip44("00");
    Coin bitcoin = bip44.coins[0];
    Account account = Account(bitcoin, 0, changeExternal);
    address = Address(account, 0);
  });

  test("toP2PKH", () {
    expect(address.P2PKH, startsWith("1"));
  });

  test("toP2WPKH", () {
    expect(address.P2WPKH, startsWith("bc"));
  });
}
