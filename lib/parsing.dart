// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'classes/artist.dart';
import 'classes/song.dart';

const access = "3NDj9WukN3qLUw1m7nC-LpDiCA7zcXklqBVjUvGlIg1Ceqla3zySO2mlPgwYEj__";

Future<Artist> getArtist(int id) async {
  final response = await http.get(Uri.parse('https://api.genius.com/artists/$id?access_token=$access'));
  var data = jsonDecode(response.body);
  var required = data['response']['artist'];
  return Artist.fromJson(required);
}

Future<Song> getSong(int id) async {
  final response = await http.get(Uri.parse('https://api.genius.com/songs/$id?access_token=$access'));
  var data = jsonDecode(response.body);
  var required = data['response']['song'];
  return Song.fromJson(required);
}