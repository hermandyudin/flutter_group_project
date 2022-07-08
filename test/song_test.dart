import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_group_project/classes/song.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test 1', () {
    const song =
        Song(1, 16800, 'title', 'names of artists', 'url of image', 'url');

    expect(song.id, 1);
    expect(song.ownerId, 16800);
    expect(song.title, 'title');
    expect(song.artistNames, 'names of artists');
    expect(song.imageUrl, 'url of image');
    expect(song.url, 'url');
  });

  test('test 2', () {
    final file =
        File('test/test_resources/random_song.json').readAsStringSync();
    final song = Song.fromJson(jsonDecode(file) as Map<String, dynamic>);

    expect(song.id, 1);
    expect(song.ownerId, 16800);
    expect(song.title, 'TITLE');
    expect(song.artistNames, 'NAMES OF ARTISTS');
    expect(song.imageUrl, 'URL OF IMAGE');
    expect(song.url, 'URL');
  });

  var numberBiggerThan16775 = 16775 + Random().nextInt(1300);
  test('test 3', () async {
    while ((await getArtist(numberBiggerThan16775)).id == -1) {
      numberBiggerThan16775 = 16755 + Random().nextInt(1300);
    }

    final songs = await getSongs(numberBiggerThan16775);
    expect(songs.length, isNotNaN);
  });

  test('test 4', () async {
    while ((await getArtist(numberBiggerThan16775)).id == -1) {
      numberBiggerThan16775 = 16755 + Random().nextInt(1300);
    }
    final songs = await getSongs(numberBiggerThan16775);
    var songInList = songs[0];
    var songFromGetter = await getSong(songs[0].id);
    expect(songInList, songFromGetter);
  });

  test('test 5', () async {
    while ((await getArtist(numberBiggerThan16775)).id == -1) {
      numberBiggerThan16775 = 16755 + Random().nextInt(1300);
    }

    final songs = await getSongs(numberBiggerThan16775);
    var songInList = songs[0];
    var lyrics = getLyrics(songInList.id);

    expect((await lyrics)[0], '[Verse 1]');
  });
}
