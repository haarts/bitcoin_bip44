import 'dart:collection';

import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'coins.dart';

/// Start indeces
const int purpose = firstHardenedChild + 44;
const int coinType = firstHardenedChild;
const int account = firstHardenedChild;
const int changeExternal = 0;
const int changeInternal = 1;
const int addressIndex = 0;

String forHumans(int index) {
  if (index < firstHardenedChild) {
    return index.toString();
  }

  return "${index - firstHardenedChild}'";
}

class Bip44 {
  final Chain chain;

  Bip44(String seed) : chain = Chain.seed(seed);

  List<Coin> coins() {
    return Coins.coins(chain);
  }
}
