import 'package:bitcoin_bip44/bitcoin_bip44.dart';

void main() {
  var bip44 = Bip44(toHexString('some seed'));
  var bitcoin = bip44.coins[0];
  var account = Account(bitcoin, 0, changeExternal);
  account.nextUnusedAddress().then((address) => print(address));

  // Add a scanner of your own:
  scanners = [MyOwnScanner()];
}

class MyOwnScanner extends Scanner {
  @override
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
