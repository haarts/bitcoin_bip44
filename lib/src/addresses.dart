import 'accounts.dart';

class Address {
  final Account account;
  final int index;

  Address(Account account, int index)
      : account = account,
        index = index;

  String get path => "${account.path}/$index";
}
