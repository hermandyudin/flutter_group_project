import 'package:flutter/material.dart';
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

  LyricsPage(this.id);

  @override
  void initState() {
    super.initState();
    checkConnection(downloadData, context);
  }

  void downloadData() {
    Future<List<String>> list = getLyrics(id);
    list.then((value) => setState(() {
          lyrics = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          heroTag: 'songPage',
          child: const Icon(
            Icons.arrow_back,
            color: CustomColors.black,
          ),
        ),
        body: Material(
            type: MaterialType.transparency,
            child: RefreshIndicator(
                backgroundColor: CustomColors.black,
                color: CustomColors.green,
                onRefresh: () {
                  checkConnection(downloadData, context);
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 60, left: 8, right: 8, bottom: 40),
                    itemCount: lyrics.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Text(
                            lyrics[index].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: CustomColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                fontFamily: "montserrat"),
                          ));
                    }))));
  }
}
