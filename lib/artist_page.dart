import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'check_connection_methods.dart';
import 'classes/artist.dart';
import 'main.dart';

class ArtistStateful extends StatefulWidget {
  const ArtistStateful({Key? key}) : super(key: key);

  @override
  State<ArtistStateful> createState() => ArtistPage();
}

class ArtistPage extends State<ArtistStateful> {
  List filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'artistPage',
        child: RefreshIndicator(
            backgroundColor: CustomColors.black,
            color: CustomColors.green,
            onRefresh: () {
              checkConnection(downloadData, context);
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search ',
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (text) {
                        text = text.toLowerCase();
                        filter(text);
                      })),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final alreadySaved =
                            saved.contains(filteredList[index]);
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SongStateful(
                                        id: filteredList[index].id))),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: CustomColors.green,
                                elevation: 10,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 15,
                                        bottom: 15,
                                        right: 15),
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: IconButton(
                                              icon: Icon(
                                                alreadySaved
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: alreadySaved
                                                    ? Colors.red
                                                    : null,
                                                semanticLabel: alreadySaved
                                                    ? 'Remove from saved'
                                                    : 'Save',
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (alreadySaved) {
                                                    saved.remove(
                                                        filteredList[index]);
                                                  } else {
                                                    saved.add(
                                                        filteredList[index]);
                                                  }
                                                });
                                              })),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: CircleAvatar(
                                            radius: 20, // Image radius
                                            backgroundImage: NetworkImage(
                                                filteredList[index].imageUrl),
                                          )),
                                      Flexible(
                                          child: Text(filteredList[index].name,
                                              style: const TextStyle(
                                                  fontSize: 17))),
                                    ]))));
                      }))
            ])));
  }

  @override
  void initState() {
    super.initState();
    checkConnection(downloadData, context);
  }

  void downloadData() {
    artists.clear();
    for (int id = 16775; id <= 17000; ++id) {
      Future<Artist> art = getArtist(id);
      art.then((value) => setState(() {
            artists.add(value);
          }));
    }
    filteredList = artists;
  }

  void filter(String inputString) {
    filteredList = artists
        .where((i) => i.name.toLowerCase().contains(inputString))
        .toList();
    setState(() {});
  }
}
