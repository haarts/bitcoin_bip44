import 'package:test/test.dart';

import 'package:bitcoin_bip44/bitcoin_bip44.dart';

void main() {
  Address address;

  setUp(() {
    var bip44 = Bip44('00');
    var bitcoin = bip44.coins[0];
    var account = Account(bitcoin, 0, changeExternal);
    address = Address(account, 0);
  });

  test('toP2PKH', () {
    expect(address.P2PKH, startsWith('1'));
  });

  test('toP2WPKH', () {
    expect(address.P2WPKH, startsWith('bc'));
  });
}
