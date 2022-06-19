import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'classes/artist.dart';

List<Artist> artists = [];

class ArtistStateful extends StatefulWidget {
  const ArtistStateful({Key? key}) : super(key: key);

  @override
  State<ArtistStateful> createState() => ArtistPage();
}

class ArtistPage extends State<ArtistStateful> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: artists.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: CustomColors.green,
              elevation: 10,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          radius: 20, // Image radius
                          backgroundImage:
                              NetworkImage(artists[index].imageUrl),
                        )),
                    Flexible(
                        child: Text(artists[index].name,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 17))),
                  ])));
        });
  }

  @override
  void initState() {
    super.initState();
    for (int id = 16775; id <= 17000; ++id) {
      Future<Artist> art = getArtist(id);
      art.then((value) => setState(() {
            artists.add(value);
          }));
    }
  }
}
