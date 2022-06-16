import 'package:flutter/cupertino.dart';

class ArtistStateful extends StatefulWidget {
  const ArtistStateful({Key? key}) : super(key: key);

  @override
  State<ArtistStateful> createState() => ArtistPage();
}

class ArtistPage extends State<ArtistStateful> {
  @override
  Widget build(BuildContext context) {
    return Column(children: const [Text("Artist Page")]);
  }
}
