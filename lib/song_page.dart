import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_project/lyrics_page.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'check_connection_methods.dart';
import 'classes/song.dart';

List<Song> songs = [];

class SongStateful extends StatefulWidget {
  int id;

  SongStateful({Key? key, required this.id}) : super(key: key);

  @override
  State<SongStateful> createState() => SongPage(id);
}

class SongPage extends State<SongStateful> {
  int id;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
          backgroundColor: CustomColors.black,
          color: CustomColors.green,
          onRefresh: () {
            checkConnection(downloadData, context);
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
              itemCount: songs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LyricsStateful(id: songs[index].id))),
                        },
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: CustomColors.green,
                        elevation: 10,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 15, bottom: 15, right: 15),
                            child: Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: CircleAvatar(
                                    radius: 20, // Image radius
                                    backgroundImage:
                                        NetworkImage(songs[index].imageUrl),
                                  )),
                              Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(songs[index].title,
                                            style:
                                                const TextStyle(fontSize: 17))),
                                    Text(
                                      songs[index].artistNames,
                                      style: const TextStyle(fontSize: 10),
                                    )
                                  ])),
                            ]))));
              })),
    );
  }
}
