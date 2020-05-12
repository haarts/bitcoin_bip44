import 'dart:async';
import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'accounts.dart';
import 'bip44.dart';

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
  Coin(this.chain, this.index);

  final Chain chain;
  final int index;

  String get path => 'm/${forHumans(purpose)}/${forHumans(index)}';

  Future<List<Account>> accounts() async {
    var accounts = <Account>[];

    var next = Account(this, 0, changeExternal);
    while (await next.isUsed) {
      accounts.add(next);
      next = next.next();
    }

    return accounts;
  }
}
