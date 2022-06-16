import 'package:flutter/material.dart';

class FavoriteStateful extends StatefulWidget {
  const FavoriteStateful({Key? key}) : super(key: key);

  @override
  State<FavoriteStateful> createState() => Favorite();
}

List<String> saved = [];

class Favorite extends State<FavoriteStateful> {
  @override
  Widget build(BuildContext context) {
    void _delete(int index) {
      setState(() {
        saved.remove(index);
      });
    }

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: saved.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(saved[index],
                                textAlign: TextAlign.justify)),
                        IconButton(
                            onPressed: () {
                              _delete(index);
                            },
                            icon: const Icon(Icons.delete))
                      ])));
        });
  }
}
