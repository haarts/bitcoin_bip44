import 'dart:collection';

import 'package:bitcoin_bip32/bitcoin_bip32.dart';

import 'bip44.dart';
import 'coins.dart';
import 'addresses.dart';

class Account {
  final Coin coin;
  final int index;
  final int change;

  Account(Coin coin, int index, int change)
      : coin = coin,
        index = index,
        change = change;

  String get path => "${coin.path}/$index/$change";

  Address nextUnusedAddress() {}

  Iterator<Address> usedAddresses() {}

  Account next() {
    return Account(coin, index + 1, changeExternal);
  }
}

class AccountIterator implements Iterator<Account> {
  Account _current;
  final Coin _coin;

  AccountIterator(Coin coin) : _coin = coin;

  @override
  Account get current => _current;

  @override
  bool moveNext() {
    Account account = _current.next();

    Address nextUnusedAddress = account.nextUnusedAddress();

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
