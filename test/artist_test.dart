import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_group_project/classes/artist.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test constructor of artist model', () {
    const artist = Artist(
      1,
      'name',
      'image url',
    );

    expect(artist.id, 1);
    expect(artist.name, 'name');
    expect(artist.imageUrl, 'image url');
  });

  test('test getting from json', () {
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

  var numberBiggerThan16774 = 16775 + Random().nextInt(1300);

  test('test getting the artist by using id', () async {
    final artist = await getArtist(numberBiggerThan16774);
    var idOfArtist = -1;
    if (artist.name != "a") {
      idOfArtist = numberBiggerThan16774;
    }
    expect(artist.id, idOfArtist);
  });
}
