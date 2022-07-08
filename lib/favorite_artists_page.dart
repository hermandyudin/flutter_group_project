import 'package:flutter/material.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';
import 'package:get/get.dart';

import 'main.dart';

class FavoriteArtistsStateful extends StatefulWidget {
  const FavoriteArtistsStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteArtistsStateful> createState() => FavoriteArtists();
}

class FavoriteArtists extends State<FavoriteArtistsStateful> {
  List filteredList = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.transparent,
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            tileColor: Colors.transparent,
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));

    filteredList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Genius App"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          heroTag: 'favoritePage',
          child: const Icon(
            Icons.arrow_back,
            color: CustomColors.green,
          ),
        ),
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  style: const TextStyle(color: CustomColors.green),
                  decoration: InputDecoration(
                    hintText: 'Search '.tr,
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.green,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors.green, width: 3.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors.white, width: 1.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: CustomColors.green,
                    ),
                  ),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    filter(text);
                  })),
          Expanded(
              child: AnimatedList(
            key: _key,
            initialItemCount: filteredList.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (_, index, animation) {
              return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  child: GestureDetector(
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
                                  left: 20, top: 15, bottom: 15, right: 15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: CircleAvatar(
                                              radius: 20, // Image radius
                                              backgroundImage: NetworkImage(
                                                  filteredList[index].imageUrl),
                                            )),
                                        SizedBox(
                                          width: 200,
                                          child: Flexible(
                                              child: Text(
                                                  filteredList[index].name,
                                                  style: const TextStyle(
                                                      fontSize: 17))),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _removeItem(index),
                                    ),
                                  ])))));
            },
          ))
        ]));
  }

  void filter(String inputString) {
    filteredList = savedArtists
        .where((i) => i.name.toLowerCase().contains(inputString))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    filteredList = savedArtists;
  }
}
