import 'dart:async';
import 'package:http/http.dart' as http;

import '../discover.dart';

class Blockstream implements Scanner {
  static const String defaultUrl = "https://blockstream.info/api";
  static const Map<String, String> defaultHeaders = {
    'User-Agent': "Dart bitcoin_bip44 library"
  };

  final String url;

  Blockstream.withDefaultUrl() : url = Blockstream.defaultUrl;

  Blockstream(this.url);

  Future<bool> present(String address) async {
    var response =
        await http.get("$url/address/$address", headers: defaultHeaders);
    return response.statusCode == 200;
  }
}
