import 'package:flutter/material.dart';
import 'package:flutter_group_project/main.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/colors.dart';

import 'check_connection_methods.dart';

List<String> lyrics = [];

class LyricsStateful extends StatefulWidget {
  int id;

  LyricsStateful({Key? key, required this.id}) : super(key: key);

  @override
  State<LyricsStateful> createState() => LyricsPage(id);
}

class LyricsPage extends State<LyricsStateful> {
  int id;
  late Future<List<String>> list;

  LyricsPage(this.id);

  @override
  void initState() {
    super.initState();
    list = getLyrics(id);
    checkConnection(() {}, context);
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
          heroTag: 'songPage',
          child: const Icon(
            Icons.arrow_back,
            color: CustomColors.green,
          ),
        ),
        body: Material(
            type: MaterialType.transparency,
            child: RefreshIndicator(
                backgroundColor: CustomColors.green,
                color: CustomColors.lightBlack,
                onRefresh: () {
                  checkConnection(() {}, context);
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: FutureBuilder(
                  future: list,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      lyrics = snapshot.data;
                      return ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 60, left: 8, right: 8, bottom: 40),
                          itemCount: lyrics.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: isDark
                                    ? Text(
                                        lyrics[index].toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: CustomColors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "montserrat"),
                                      )
                                    : Text(
                                        lyrics[index].toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: CustomColors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "montserrat"),
                                      ));
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))));
  }
}
