import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/slide_right_route.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'check_connection_methods.dart';
import 'classes/artist.dart';
import 'main.dart';

class ArtistStateful extends StatefulWidget {
  const ArtistStateful({Key? key}) : super(key: key);

  @override
  State<ArtistStateful> createState() => ArtistPage();
}

class ArtistPage extends State<ArtistStateful> with TickerProviderStateMixin {
  List filteredList = [];
  String searchString = "";

  late AnimationController controller;
  late Animation<Offset> offset;

  bool alreadySaved(Artist artist) {
    if (savedArtists.contains(artist)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection(downloadData, context);

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'artistPage',
        child: RefreshIndicator(
            backgroundColor: CustomColors.green,
            color: CustomColors.lightBlack,
            onRefresh: () {
              checkConnection(downloadData, context);
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: Card(
                color: isDark ? CustomColors.black : CustomColors.white,
                child: Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                          initialValue: searchString,
                          style: const TextStyle(color: CustomColors.green),
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
                            searchString = text.toLowerCase();
                            filter(searchString);
                          })),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: filteredList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final isAlreadySaved =
                                alreadySaved(filteredList[index]);
                            return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    SlideRightRoute(
                                        widget: SongStateful(
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
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: IconButton(
                                                  icon: Icon(
                                                    isAlreadySaved
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: isAlreadySaved
                                                        ? CustomColors.white
                                                        : null,
                                                    semanticLabel: isAlreadySaved
                                                        ? 'Remove from saved'
                                                        : 'Save',
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isAlreadySaved) {
                                                        savedArtists.remove(
                                                            filteredList[
                                                                index]);
                                                      } else {
                                                        savedArtists.add(
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
                                              child: Text(
                                                  filteredList[index].name,
                                                  style: const TextStyle(
                                                      fontSize: 17))),
                                        ]))));
                          }))
                ]))));
  }

  void downloadData() {
    artists.clear();
    for (int id = 16775; id <= 17000; ++id) {
      Future<Artist> art = getArtist(id);
      art.then((value) => setState(() {
            if (value.id != -1) {
              artists.add(value);
            }
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
