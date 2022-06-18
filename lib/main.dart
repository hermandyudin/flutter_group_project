import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/dark_green_theme.dart';

import 'artist_page.dart';
import 'favorite_page.dart';

void main() {
  // runApp(const MyApp());
  getLyrics(124123);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius App',
      theme: CustomTheme.darkTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const String artistPage = "Artist";
const String favouritePage = "Favorite";

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _pages;
  late Widget _artist;
  late Widget _favorite;
  late int _selectedIndex;
  late Widget _currentPage;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pages[_selectedIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    _artist = const ArtistStateful();
    _favorite = const FavoriteStateful();
    _pages = [_artist, _favorite];
    _currentPage = _artist;
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Genius App"),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
