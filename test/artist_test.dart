import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_group_project/classes/artist.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test 1', () {
    const artist = Artist(
      1,
      'name',
      'image url',
    );

    expect(artist.id, 1);
    expect(artist.name, 'name');
    expect(artist.imageUrl, 'image url');
  });

  test('test 2', () {
    final file =
        File('test/test_resources/random_artist.json').readAsStringSync();
    final artist = Artist.fromJson(jsonDecode(file) as Map<String, dynamic>);

    expect(artist.id, 1);
    expect(artist.name, 'NAME');
    expect(
      artist.imageUrl,
      'URL OF IMAGE',
    );
  });

  test('test 3', () async {
    final artist = await getArtist(16774);

    expect(artist.id, -1);
    expect(artist.name, "a");
    expect(artist.imageUrl, 'a');
  });

  var numberBiggerThan16775 = 16775 + Random().nextInt(1300);

  test('test 4', () async {
    final artist = await getArtist(numberBiggerThan16775);

    expect(artist.id, numberBiggerThan16775);
  });
}
