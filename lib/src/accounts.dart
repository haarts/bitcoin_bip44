import 'dart:async';
import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'addresses.dart';
import 'bip44.dart';
import 'coins.dart';
import 'discover.dart';

class Account {
  final Coin coin;
  final int index;
  final int change;

  Account(Coin coin, int index, int change)
      : coin = coin,
        index = index,
        change = change;

  String get path => "${coin.path}/$index/$change";
  Chain get chain => coin.chain;
  Future<bool> get isUsed async {
    return (await nextUnusedAddress()).index != 0;
  }

  Future<Address> nextUnusedAddress() async {
    var used = await usedAddresses();

    if (used.length == 0) {
      return Address(this, 0);
    }

    return Address(this, used.last.index + 1);
  }

  Future<List<Address>> usedAddresses() async {
    List<Address> usedAddresses = [];

    int addressIndex = 0;
    Address nextAddress = Address(this, addressIndex);

    while (await scanners[0].present(nextAddress.P2PKH)) {
      usedAddresses.add(nextAddress);
      addressIndex++;
      nextAddress = Address(this, addressIndex);
    }

    return usedAddresses;
  }

  Account next() {
    return Account(coin, index + 1, changeExternal);
  }
}
