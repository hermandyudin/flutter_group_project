import 'package:flutter/material.dart';
import 'package:flutter_group_project/favorite_artists_page.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';
import 'package:get/get.dart';


import 'favorite_songs_page.dart';
import 'main.dart';

class FavoriteNewStateful extends StatefulWidget {
  const FavoriteNewStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteNewStateful> createState() => FavoriteNew();
}

class FavoriteNew extends State<FavoriteNewStateful> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Hero(
        tag: 'favoritePage',
        child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size((width-30) / 2, 800),
                  maximumSize: Size((width-30) / 2, 800),
                  primary: CustomColors.green),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoriteArtistsStateful())),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 40,
                    ),
                    Text("FAV Artists".tr, textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 17, color: Colors.black)),
                  ])),
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size((width-30) / 2, 800),
                  maximumSize: Size((width-30) / 2, 800),
                  primary: CustomColors.green),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoriteSongsStateful())),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Icon(
                      Icons.music_note,
                      color: Colors.black,
                      size: 40,
                    ),
                    Text("FAV Songs".tr, textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 17, color: Colors.black)),
                  ])),
        ])));
  }
}
