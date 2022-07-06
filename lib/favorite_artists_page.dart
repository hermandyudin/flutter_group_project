import 'package:flutter/material.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'main.dart';

class FavoriteArtistsStateful extends StatefulWidget {
  FavoriteArtistsStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteArtistsStateful> createState() => FavoriteArtists();
}

class FavoriteArtists extends State<FavoriteArtistsStateful> {
  List filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Genius App"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.green,
          child: const Icon(
            Icons.arrow_back,
            color: CustomColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                  style: TextStyle(color: CustomColors.green),
                  decoration: const InputDecoration(
                    hintText: 'Search ',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: CustomColors.green,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors.green, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors.white, width: 1.0),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: CustomColors.green,
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
                        savedArtists.contains(filteredList[index]);
                    return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SongStateful(id: filteredList[index].id))),
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
                                                savedArtists.remove(
                                                    filteredList[index]);
                                              } else {
                                                savedArtists
                                                    .add(filteredList[index]);
                                              }
                                            });
                                          })),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: CircleAvatar(
                                        radius: 20, // Image radius
                                        backgroundImage: NetworkImage(
                                            filteredList[index].imageUrl),
                                      )),
                                  Flexible(
                                      child: Text(filteredList[index].name,
                                          style:
                                              const TextStyle(fontSize: 17))),
                                ]))));
                  }))
        ]));
  }

  void filter(String inputString) {
    filteredList = savedArtists
        .where((i) => i.name.toLowerCase().contains(inputString))
        .toList();
    setState(() {});
  }

  void initState() {
    super.initState();
    filteredList = savedArtists;
  }
}