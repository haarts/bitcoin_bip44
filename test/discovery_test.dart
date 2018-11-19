import 'dart:io';

import 'package:hex/hex.dart';
import 'package:mock_web_server/mock_web_server.dart';
import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/curves/secp256k1.dart";
import 'package:test/test.dart';

import '../lib/src/discover.dart';
import '../lib/src/discover/blockchair.dart';

void main() {
  group("address genenration with given public key", () {
    var publicKey = HEX.decode(
        "0279BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798");
    ECPoint point;

    setUp(() {
      var curve = ECCurve_secp256k1().curve;
      point = curve.decodePoint(publicKey);
    });

    test("generate P2PKH", () {
      var expectedAddress = "1BgGZ9tcN4rm9KBzDn7KprQz87SZ26SAMH";

      expect(toP2PKH(point), expectedAddress);
    });

    test("generate P2WPKH", () {
      // Public key -> address is taken from BIP173 examples: https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki#Examples
      var expectedSegwitAddress = "bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4";

      expect(toP2WPKH(point), expectedSegwitAddress);
    });
  });

  group("address scanning", () {
    MockWebServer server;

    setUp(() async {
      server = MockWebServer();
      await server.start();
    });

    tearDown(() async {
      server.shutdown();
    });

    group("on Blockchair", () {
      test("found", () async {
        var responseFromFile =
            await File('test/files/blockchair_address_found.json')
                .readAsString();
        server.enqueue(body: responseFromFile);
        Scanner scanner = Blockchair(server.url);

        expect(
            await scanner.present("33fyxZPikQcoejqW1YvJecjCNawYKcKE8m"), true);
      });

      test("not found", () async {
        var responseFromFile =
            await File('test/files/blockchair_address_not_found.json')
                .readAsString();
        server.enqueue(body: responseFromFile);
        Scanner scanner = Blockchair(server.url);

        expect(await scanner.present("33fyxZPikQcoejqW1YvJecjCNawYK"), false);
      });
    });
  });
}
