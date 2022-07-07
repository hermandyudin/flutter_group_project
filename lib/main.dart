import 'package:flutter/material.dart';
import 'package:flutter_group_project/parsing.dart';
import 'package:flutter_group_project/theme/colors.dart';
import 'package:flutter_group_project/theme/dark_green_theme.dart';
import 'package:get/get.dart';
import 'artist_page.dart';
import 'classes/artist.dart';
import 'classes/song.dart';
import 'favorite_artists_page.dart';
import 'favorite_songs_page.dart';
import 'favorite_page.dart';
import 'localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Genius App',
      theme: CustomTheme.darkTheme,
      locale: Locale('en', 'US'),
      translations: Messages(),
      debugShowCheckedModeBanner: false,
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

List<Artist> savedArtists = [];
List<Song> savedSongs = [];
List<Artist> artists = [];
bool isEnglish = true;
bool isDark = true;

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

  void _changeLanguage(){
    if(isEnglish){
      var locale = Locale('ru', 'Ru');
      Get.updateLocale(locale);
      isEnglish = false;
    }
    else{
      var locale = Locale('en', 'US');
      Get.updateLocale(locale);
      isEnglish = true;
    }
  }

  void _changeTheme(){
    if(isDark){
      isDark = false;
      Get.changeTheme(CustomTheme.lightTheme);
    }
    else{
      isDark = true;
      Get.changeTheme(CustomTheme.darkTheme);
    }
  }

  void _showSettings() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Settings'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: CustomColors.green)),
            children: [
              Padding(padding: const EdgeInsets.only(left: 10, right: 10), child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: CustomColors.green),
                  onPressed: _changeLanguage,
                  child: Text("Change Language".tr, style: const TextStyle(color: Colors.black)))),
              Padding(padding: const EdgeInsets.only(left: 10, right: 10), child:
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: CustomColors.green),
                  onPressed: _changeTheme,
                  child: Text("Change Theme".tr, style: const TextStyle(color: Colors.black))))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _artist = const ArtistStateful();
    _favorite = const FavoriteNewStateful();
    _pages = [_artist, _favorite];
    _currentPage = _artist;
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Genius App"),
        actions: [
          IconButton(
              onPressed: _showSettings,
              icon: const Icon(Icons.settings, color: CustomColors.green))
        ],
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favorite'.tr,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
