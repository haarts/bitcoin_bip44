# BIP44

[![pub package](https://img.shields.io/pub/v/bitcoin_bip44.svg)](https://pub.dartlang.org/packages/bitcoin_bip44)

An implementation of the [BIP44 spec] for organizing Hierarchical Deterministic Bitcoin
addresses. Based on the BIP32 spec.

## Examples

```
var bip44 = Bip44("<some hex seed>");
List<Account> accounts = bip44.coins[0].accounts // coin 0 is bitcoin
```

## Discovery

The specification mandates that accounts, and ultimately addressess, are 
discoverable. Currently only two remote sources can be queried: Blockchair and 
Blockstream. The `Scanner` interface should make it easier to add sources.

## Supported coins

It is trivial to add more iff the coin appears in [SLIP44](https://github.com/satoshilabs/slips/blob/master/slip-0044.md).

- Bitcoin
- Testnets
- Litecoin

## Installing

Add it to your `pubspec.yaml`:

```
dependencies:
  bitcoin_bip44: ^0.1.0
```

## TODO

- Make the scanners robust versus exceptions thrown by the remotes
- Add Scanner for locally run Bitcoin node
- Only the first scanner is ever used
- Only traditional Bitcoin addresses (starting with a '1') are scanned for, 
  add segwit
- Add 'Address gap limit'

## Licence overview

All files in this repository fall under the license specified in 
[COPYING](COPYING). The project is licensed as [AGPL with a lesser 
clause](https://www.gnu.org/licenses/agpl-3.0.en.html). It may be used within a 
proprietary project, but the core library and any changes to it must be 
published online. Source code for this library must always remain free for 
everybody to access.

[BIP44 spec]: https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki
