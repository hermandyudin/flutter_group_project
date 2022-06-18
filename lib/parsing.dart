// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:html/parser.dart';
import 'dart:async';
import 'dart:convert';
import 'classes/artist.dart';
import 'classes/song.dart';

const access =
    "3NDj9WukN3qLUw1m7nC-LpDiCA7zcXklqBVjUvGlIg1Ceqla3zySO2mlPgwYEj__";

Future<Artist> getArtist(int id) async {
  final response = await http.get(
      Uri.parse('https://api.genius.com/artists/$id?access_token=$access'));
  var data = jsonDecode(response.body);
  var required = data['response']['artist'];
  return Artist.fromJson(required);
}

Future<Song> getSong(int id) async {
  final response = await http
      .get(Uri.parse('https://api.genius.com/songs/$id?access_token=$access'));
  var data = jsonDecode(response.body);
  var required = data['response']['song'];
  return Song.fromJson(required);
}

Future<List<String>> getLyrics(int songId) async {
  Song toGet = await getSong(songId);
  String url = toGet.url;

  var response = await http.Client()
      .get(Uri.parse(url));
  var document = parse(response.body);
  var elements = document
      .getElementsByClassName("SongPage__LyricsWrapper-sc-19xhmoi-5 UKjRP");

  List<String> lyrics = [];
  lyrics.add("[Verse 1]");
  for (var e in elements) {
    var p = parse(e.outerHtml.replaceAll('<br>', '</p><p>')).querySelectorAll('p');
    if (p.isNotEmpty) {
      for (var f in p) {
        if (f.text != '') {
          lyrics.add(f.text);
        }
      }
    }
  }
  return lyrics;
}
