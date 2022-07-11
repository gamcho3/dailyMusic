import 'dart:io';

import 'package:daliy_music/db/database.dart';
import 'package:flutter/material.dart';

import '../model/music_files.dart';
import '../model/playList.dart';

class PlayListProvider with ChangeNotifier {
  late List<PlayList> _cards = [];
  List<MusicFiles> _playList = [];
  List<PlayList> get cards => _cards;
  List<MusicFiles> get playList => _playList;

  PlayListProvider() {
    getAllLists();
  }

  void getAllLists() async {
    var result = await PlayListDatabase.instance.readAllLists();
    _cards = result;
    notifyListeners();
  }

  void readPlayList(cardNum) async {
    var result = await PlayListDatabase.instance.readFiles(cardNum);
    _playList = result;
    notifyListeners();
  }

  void createCard({
    required String imgUrl,
    required String title,
    required List musicFiles,
    required String content,
  }) async {
    final list = PlayList(imgUrl: imgUrl, title: title, content: content);
    var result = await PlayListDatabase.instance.create(list);
    print(result);
    final playList = musicFiles.map((e) async {
      var music = MusicFiles(
          cardNum: result.id!,
          musicFilePath: e['musicPath'],
          imgUrl: e['imageUrl'],
          title: e['title']);
      await PlayListDatabase.instance.insertMusicFile(music);
    }).toList();

    getAllLists();
  }

  void deleteCard(id, List<MusicFiles> playList) async {
    await PlayListDatabase.instance.delete(id);
    await PlayListDatabase.instance.deleteMusics(id);
    for (var i = 0; i < playList.length; i++) {
      var file = File(playList[i].musicFilePath);
      await file.delete();
    }
    getAllLists();
  }
}
