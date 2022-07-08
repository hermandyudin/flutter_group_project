import 'package:flutter/material.dart';
import 'package:flutter_group_project/lyrics_page.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/slide_right_route.dart';
import 'package:flutter_group_project/theme/colors.dart';
import 'package:get/get.dart';

import 'check_connection_methods.dart';
import 'classes/song.dart';
import 'main.dart';

class SongStateful extends StatefulWidget {
  final int id;

  const SongStateful({Key? key, required this.id}) : super(key: key);

  @override
  State<SongStateful> createState() => SongPage(id);
}

late Future<List<Song>> list;

class SongPage extends State<SongStateful> with TickerProviderStateMixin {
  int id;
  List filteredList = [];
  late AnimationController controller;
  late Animation<Offset> offset;

  SongPage(this.id);

  String searchText = "";

  @override
  void initState() {
    super.initState();
    list = getSongs(id);
    searchText = "";
    checkConnection(() {}, context);

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Genius App"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          heroTag: 'artistPage',
          child: const Icon(
            Icons.arrow_back,
            color: CustomColors.green,
          ),
        ),
        body: FutureBuilder(
          future: list,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _filter(searchText, snapshot.data);
              return Hero(
                  tag: 'songPage',
                  child: RefreshIndicator(
                      backgroundColor: CustomColors.green,
                      color: CustomColors.lightBlack,
                      onRefresh: () {
                        checkConnection(() {}, context);
                        return Future<void>.delayed(const Duration(seconds: 1));
                      },
                      child: Column(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextFormField(
                                initialValue: searchText,
                                style:
                                    const TextStyle(color: CustomColors.green),
                                decoration: InputDecoration(
                                  hintText: 'Search '.tr,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.green,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CustomColors.green, width: 3.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CustomColors.white, width: 1.0),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: CustomColors.green,
                                  ),
                                ),
                                onChanged: (text) {
                                  searchText = text.toLowerCase();
                                  _onChanged(searchText, snapshot.data);
                                })),
                        Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 8, right: 8),
                                itemCount: filteredList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final alreadySaved =
                                      savedSongs.contains(filteredList[index]);
                                  return GestureDetector(
                                      onTap: () {
                                        int songId = filteredList[index].id;
                                        Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                widget: LyricsStateful(
                                                    id: songId)));
                                      },
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: IconButton(
                                                        icon: Icon(
                                                          alreadySaved
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color: alreadySaved
                                                              ? CustomColors
                                                                  .white
                                                              : null,
                                                          semanticLabel:
                                                              alreadySaved
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: CircleAvatar(
                                                      radius:
                                                          20, // Image radius
                                                      backgroundImage:
                                                          NetworkImage(
                                                              filteredList[
                                                                      index]
                                                                  .imageUrl),
                                                    )),
                                                Flexible(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 5),
                                                          child: Text(
                                                              filteredList[
                                                                      index]
                                                                  .title,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          17))),
                                                      Text(
                                                        filteredList[index]
                                                            .artistNames,
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      )
                                                    ])),
                                              ]))));
                                })),
                      ])));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void _filter(String inputString, List<Song> songs) {
    filteredList = songs
        .where((i) => i.title.toLowerCase().contains(inputString))
        .toList();
  }

  void _onChanged(String inputString, List<Song> songs) {
    _filter(inputString, songs);
    setState(() {});
  }
}
