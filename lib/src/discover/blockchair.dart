import 'dart:convert';

import 'package:http/http.dart' as http;

import '../discover.dart';

class Blockchair implements Scanner {
  static const String defaultUrl = "https://api.blockchair.com";
  static const Map<String, String> defaultHeaders = {
    'User-Agent': "Dart bitcoin_bip44 library"
  };

  final String url;

  Blockchair.withDefaultUrl() : url = Blockchair.defaultUrl;

  Blockchair(this.url);

  Future<bool> present(String address) async {
    var response = await http.get("$url/bitcoin/dashboards/address/$address",
        headers: defaultHeaders);
    Map<String, dynamic> payload = json.decode(response.body);
    return payload["data"][address]["transactions"].length != 0;
  }
}
