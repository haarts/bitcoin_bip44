import 'dart:io';

import 'package:test/test.dart';
import 'package:mock_web_server/mock_web_server.dart';

import 'package:bitcoin_bip44/bitcoin_bip44.dart';
import '../lib/src/discover/blockchair.dart';
import '../lib/src/discover.dart';

void main() {
  group("address genenration with given public key", () {
    test("generate P2PKH", () {});
    test("generate P2WPKH", () {});
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
