import 'package:flutter/material.dart';
import 'package:flutter_group_project/favorite_artists_page.dart';
import 'package:flutter_group_project/slide_right_route.dart';
import 'package:flutter_group_project/theme/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'favorite_songs_page.dart';

class FavoriteNewStateful extends StatefulWidget {
  const FavoriteNewStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteNewStateful> createState() => FavoriteNew();
}

class FavoriteNew extends State<FavoriteNewStateful>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Hero(
        tag: 'favoritePage',
        child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size((width - 30) / 2, 800),
                      maximumSize: Size((width - 30) / 2, 800),
                      primary: CustomColors.green),
                  onPressed: () => Navigator.push(context,
                      SlideRightRoute(widget: const FavoriteArtistsStateful())),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 40,
                        ),
                        Text("Artists".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black)),
                      ])),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size((width - 30) / 2, 800),
                      maximumSize: Size((width - 30) / 2, 800),
                      primary: CustomColors.green),
                  onPressed: () => Navigator.push(context,
                      SlideRightRoute(widget: const FavoriteSongsStateful())),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.music_note,
                          color: Colors.black,
                          size: 40,
                        ),
                        Text("Songs".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black)),
                      ])),
            ])));
  }
}
