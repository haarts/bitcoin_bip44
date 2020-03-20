import 'package:bitcoin_bip44/bitcoin_bip44.dart';

void main() {
  Bip44 bip44 = Bip44(toHexString('some seed'));
  Coin bitcoin = bip44.coins[0];
  var account = Account(bitcoin, 0, changeExternal);
  account.nextUnusedAddress().then((address) => print(address));

  // Add a scanner of your own:
  scanners = [MyOwnScanner()];
}

class MyOwnScanner extends Scanner {
  Future<bool> present(String address) {
    // Total nonsense!
    if (address.endsWith('b')) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}

String toHexString(String original) {
  return original.codeUnits
      .map((c) => c.toRadixString(16).padLeft(2, '0'))
      .toList()
      .join('');
}
