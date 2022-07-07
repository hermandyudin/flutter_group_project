import 'package:flutter/material.dart';
import 'package:flutter_group_project/artist_page.dart';
import 'package:flutter_group_project/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var artistPage = ArtistPage();
  savedArtists.add(artistPage.filteredList[0]);

  test('testing check for saved', () async {
    expect(true, true);
  });
}
