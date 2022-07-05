import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/song_page.dart';
import 'package:flutter_group_project/theme/colors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'classes/artist.dart';
import 'main.dart';

class ArtistStateful extends StatefulWidget {
  const ArtistStateful({Key? key}) : super(key: key);

  @override
  State<ArtistStateful> createState() => ArtistPage();
}

class ArtistPage extends State<ArtistStateful> {
  final _suggestions = <Artist>[];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: CustomColors.black,
        color: CustomColors.green,
        onRefresh: () {
          checkConnection();
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: artists.length,
            itemBuilder: (BuildContext context, int index) {
              final alreadySaved = saved.contains(artists[index]);
              return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SongStateful(id: artists[index].id))),
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
                                      color: alreadySaved ? Colors.red : null,
                                      semanticLabel: alreadySaved
                                          ? 'Remove from saved'
                                          : 'Save',
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (alreadySaved) {
                                          saved.remove(artists[index]);
                                        } else {
                                          saved.add(artists[index]);
                                        }
                                      });
                                    })),
                            Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: CircleAvatar(
                                  radius: 20, // Image radius
                                  backgroundImage:
                                      NetworkImage(artists[index].imageUrl),
                                )),
                            Flexible(
                                child: Text(artists[index].name,
                                    style: const TextStyle(fontSize: 17))),
                          ]))));
            }));
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No internet connection'),
          content: const Text(
              'Please, check your internet connection, and refresh the page'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text(
                'OK',
                style: TextStyle(color: CustomColors.green),
              ),
            ),
          ],
        ),
      );
    } else {
      downloadData();
    }
  }

  void downloadData() {
    artists.clear();
    for (int id = 16775; id <= 17000; ++id) {
      Future<Artist> art = getArtist(id);
      art.then((value) => setState(() {
            artists.add(value);
          }));
    }
  }
}
