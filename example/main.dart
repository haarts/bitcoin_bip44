import "package:bitcoin_bip44/bitcoin_bip44.dart";

void main() {
  Bip44 bip44 = Bip44(toHexString("some seed"));
  Coin bitcoin = bip44.coins[0];
  account = Account(bitcoin, 0, changeExternal);
  Address unUsed = account.nextUnusedAddress();

  // Add a scanner of your own:
  scanners = [MyOwnScanner()];
}

class MyOwnScanner {
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
      .map((c) => c.toRadixString(16).padLeft(2, "0"))
      .toList()
      .join("");
}
