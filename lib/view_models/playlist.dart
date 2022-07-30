import 'dart:io';

import 'package:daliy_music/db/database.dart';
import 'package:daliy_music/models/music_files.dart';
import 'package:daliy_music/models/playList.dart';
import 'package:flutter/material.dart';

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

  void loadPlayList(int? cardNum) async {
    var result = await PlayListDatabase.instance.readFiles(cardNum);
    print(result);
    _playList = result;
    notifyListeners();
  }

  void createCard({
    required String imgUrl,
    required String title,
    required List<Map> musicFiles,
    required String content,
  }) async {
    final list = PlayList(imgUrl: imgUrl, title: title, content: content);
    var result = await PlayListDatabase.instance.create(list);

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
    await PlayListDatabase.instance.deleteAllMusics(id);
    for (var i = 0; i < playList.length; i++) {
      var file = File(playList[i].musicFilePath);
      await file.delete();
    }
    getAllLists();
  }

  void updateCard(PlayList list) async {
    await PlayListDatabase.instance.updateCard(list);
    getAllLists();
  }

  void deleteMusic(int id) async {
    await PlayListDatabase.instance.deleteMusic(id);
  }
}
