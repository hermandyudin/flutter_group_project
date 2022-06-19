import 'package:flutter/material.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'main.dart';

class FavoriteStateful extends StatefulWidget {
  const FavoriteStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteStateful> createState() => Favorite();
}

class Favorite extends State<FavoriteStateful> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: saved.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongStateful(id: saved[index].id))),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: CustomColors.green,
                  elevation: 10,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 15, bottom: 15, right: 15),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CircleAvatar(
                              radius: 20, // Image radius
                              backgroundImage:
                                  NetworkImage(saved[index].imageUrl),
                            )),
                        Flexible(
                            child: Text(saved[index].name,
                                style: const TextStyle(fontSize: 17))),
                      ]))));
        });
  }
}
