// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Settings': 'Settings',
          "Change Language": "Change Language",
          "Change Theme": "Change Theme",
          'Home': 'Home',
          'Favorite': 'Favorite',
          "Artists": "Artists",
          "Songs": "Songs",
          'No internet connection': 'No internet connection',
          'Please, check your internet connection, and refresh the page':
              'Please, check your internet connection, and refresh the page',
          'Search ': 'Search ',
        },
        'ru_RU': {
          'Settings': 'Настройки',
          "Change Language": "Сменить Язык",
          "Change Theme": "Сменить Тему",
          'Home': 'Главная',
          'Favorite': 'Избранное',
          "Artists": "Артисты",
          "Songs": "Песни",
          'No internet connection': 'Нет соединения с интернетом',
          'Please, check your internet connection, and refresh the page':
              'Пожалуйста, проверьте соединение с интернетом и перезагрузите страницу',
          'Search ': 'Поиск '
        }
      };
}
