import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_project/lyrics_page.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'check_connection_methods.dart';
import 'classes/song.dart';
import 'main.dart';

List<Song> songs = [];

class SongStateful extends StatefulWidget {
  int id;

  SongStateful({Key? key, required this.id}) : super(key: key);

  @override
  State<SongStateful> createState() => SongPage(id);
}

class SongPage extends State<SongStateful> {
  int id;
  List filteredList = [];
  SongPage(this.id);

  @override
  void initState() {
    super.initState();
    checkConnection(downloadData, context);
  }

  void downloadData() {
    Future<List<Song>> list = getSongs(id);
    list.then((value) => setState(() {
          songs = value;
        }));
    filteredList = songs;
  }

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
          heroTag: 'artistPage',
        ),
        body: Hero(
            tag: 'songPage',
            child: RefreshIndicator(
                backgroundColor: CustomColors.black,
                color: CustomColors.green,
                onRefresh: () {
                  checkConnection(downloadData, context);
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: Column(children: <Widget>[
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
                              borderSide: BorderSide(
                                  color: CustomColors.green, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomColors.white, width: 1.0),
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
                          padding:
                              const EdgeInsets.only(top: 40, left: 8, right: 8),
                          itemCount: filteredList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final alreadySaved =
                                savedSongs.contains(filteredList[index]);
                            return GestureDetector(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LyricsStateful(
                                                      id: filteredList[index]
                                                          .id))),
                                    },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: CustomColors.green,
                                    elevation: 10,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 15,
                                            bottom: 15,
                                            right: 15),
                                        child: Row(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
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
                                                        savedSongs.remove(
                                                            filteredList[
                                                                index]);
                                                      } else {
                                                        savedSongs.add(
                                                            filteredList[
                                                                index]);
                                                      }
                                                    });
                                                  })),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: CircleAvatar(
                                                radius: 20, // Image radius
                                                backgroundImage: NetworkImage(
                                                    filteredList[index]
                                                        .imageUrl),
                                              )),
                                          Flexible(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: Text(
                                                        filteredList[index]
                                                            .title,
                                                        style: const TextStyle(
                                                            fontSize: 17))),
                                                Text(
                                                  filteredList[index]
                                                      .artistNames,
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                )
                                              ])),
                                        ]))));
                          })),
                ]))));
  }

  void filter(String inputString) {
    filteredList = songs
        .where((i) => i.title.toLowerCase().contains(inputString))
        .toList();
    setState(() {});
  }
}
