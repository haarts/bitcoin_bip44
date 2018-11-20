import 'dart:collection';

import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'bip44.dart';
import 'coins.dart';
import 'addresses.dart';
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

  Future<Address> nextUnusedAddress() async {
    var usedAddresses = await usedAddresses();
    return Address(this, usedAddresses.last.index + 1);
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

class AccountIterator implements Iterator<Account> {
  Account _current;
  final Coin _coin;

  AccountIterator(Coin coin) : _coin = coin {
    _current = Account(_coin, 0, changeExternal);
  }

  @override
  Account get current => _current;

  @override
  bool moveNext() {
    Account account = _current.next();

    Address nextUnusedAddress = null; //account.nextUnusedAddress();

    if (nextUnusedAddress.index == 0) {
      return false;
    }

    _current = account;

    return true;
  }
}

class Accounts extends Object with IterableMixin<Account> {
  final Coin _coin;

  Accounts(Coin coin) : _coin = coin;

  Iterator<Account> get iterator => AccountIterator(_coin);
}
