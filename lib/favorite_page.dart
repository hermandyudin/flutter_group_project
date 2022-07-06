import 'package:flutter/material.dart';
import 'package:flutter_group_project/favorite_artists_page.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';

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
    return Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 15),
        child: Column(children: <Widget>[
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoriteArtistsStateful())),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: CustomColors.green,
                  elevation: 10,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 15, bottom: 15, right: 15),
                      child: Row(children: const [
                        Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(Icons.person)),
                        Flexible(
                          child: Text("FAV Artists",
                              style: TextStyle(fontSize: 17)),
                        )
                      ])))),
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoriteSongsStateful())),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: CustomColors.green,
                  elevation: 10,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 15, bottom: 15, right: 15),
                      child: Row(children: const [
                        Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(Icons.music_note)),
                        Flexible(
                            child: Text("FAV Songs",
                                style: TextStyle(fontSize: 17))),
                      ])))),
        ]));
  }
}
