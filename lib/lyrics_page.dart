import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/colors.dart';

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
    Future<List<String>> list = getLyrics(id);
    list.then((value) => setState(() {
          lyrics = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: ListView.builder(
            padding:
                const EdgeInsets.only(top: 60, left: 8, right: 8, bottom: 40),
            itemCount: lyrics.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0){
                return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back, color: Colors.white)));
              }
              return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    lyrics[index - 1].toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        fontFamily: "montserrat"),
                  ));
            }));
  }
}
