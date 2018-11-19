import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'bip44.dart';
import 'accounts.dart';

/// Here are defined the different crypto currencies as per https://github.com/satoshilabs/slips/blob/master/slip-0044.md
/// This list is incomplete.

const int bitcoin = coinType;
const int testnets = coinType + 1;
const int litecoin = coinType + 2;

class Coins {
  static List<Coin> coins(Chain chain) => [
        Coin(chain, bitcoin),
        Coin(chain, testnets),
        Coin(chain, litecoin),
      ];
}

class Coin {
  final Chain _chain;
  final int _index;

  Coin(Chain chain, int index)
      : _chain = chain,
        _index = index;

  String get path => "m/${forHumans(purpose)}/${forHumans(_index)}";

  Iterator<Account> accounts() {
    return Accounts(this).iterator;
  }
}
