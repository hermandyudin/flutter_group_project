// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:html/parser.dart';
import 'dart:async';
import 'dart:convert';
import 'classes/artist.dart';
import 'classes/song.dart';

const access =
    "dZF71iZC3WocTvpWzLjFvriT7Qoll2qDMDNzt-qHCqIfchyVQIIVh6RehRyruGU6";

Future<Artist> getArtist(int id) async {
  final response = await http.get(Uri.parse('https://api.genius.com/artists/$id?access_token=$access'));
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

Future<List<Song>> getSongs(int artistId) async{

  final response1 = await http.get(
      Uri.parse('https://api.genius.com/artists/$artistId/songs?per_page=50&sort=popularity&page=1&access_token=$access'));
  final response2 = await http.get(
      Uri.parse('https://api.genius.com/artists/$artistId/songs?per_page=50&sort=popularity&page=2&access_token=$access'));

  var data1 = jsonDecode(response1.body);
  var data2 = jsonDecode(response2.body);

  var songs1 = data1['response']['songs'] as List;
  var songs2 = data2['response']['songs'] as List;

  List<Song> songs = [];
  for(var json in songs1){
    songs.add(Song.fromJson(json));
  }
  for(var json in songs2){
    songs.add(Song.fromJson(json));
  }

  return songs;
}
