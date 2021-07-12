import 'dart:convert';
import 'package:crypto/crypto.dart';

final String marvelUrl = 'https://gateway.marvel.com/v1/';
final String marvelPublicKey = '6d22b113889a9272a3bd35911100725c';
final String marvelPrivateKey = '289d659bb26d0d573abe1677408d812238831f73';
final String ts = '1';
final String hash = generateMd5(ts + marvelPrivateKey + marvelPublicKey);

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
