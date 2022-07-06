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
  List filteredList = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: CustomColors.black,
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));

    filteredList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
              style: TextStyle(color: CustomColors.green),
              decoration: InputDecoration(
                hintText: 'Search ',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: CustomColors.green,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.green, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.white, width: 1.0),
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
                              left: 10, top: 15, bottom: 15, right: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                                            style:
                                                const TextStyle(fontSize: 17))),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _removeItem(index),
                                ),
                              ])))));
        },
      ))
    ]);
  }

  void filter(String inputString) {
    filteredList =
        saved.where((i) => i.name.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  void initState() {
    super.initState();
    filteredList = saved;
  }
}
