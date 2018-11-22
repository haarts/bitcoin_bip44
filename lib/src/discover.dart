import 'dart:async';

import 'discover/blockchair.dart';
import 'discover/blockstream.dart';

List<Scanner> scanners = [
  Blockchair.withDefaultUrl(),
  Blockstream.withDefaultUrl()
];

abstract class Scanner {
  Future<bool> present(String address);
}
