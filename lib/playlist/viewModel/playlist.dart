import 'dart:io';

import 'package:daliy_music/db/database.dart';
import 'package:flutter/material.dart';

import '../model/music_files.dart';
import '../model/playList.dart';

class PlayListProvider with ChangeNotifier {
  late List<PlayList> _lists = [];
  List<PlayList> get lists => _lists;

  PlayListProvider() {
    getAllLists();
  }

  void getAllLists() async {
    var result = await PlayListDatabase.instance.readAllLists();
    _lists = result;
    notifyListeners();
  }

  void createCard(
      {required String imgUrl,
      required String title,
      List<MusicFiles>? musicFiles,
      required String content}) async {
    final list = PlayList(imgUrl: imgUrl, title: title, content: content);
    var result = await PlayListDatabase.instance.create(list);
    print(result);
    getAllLists();
  }
}
