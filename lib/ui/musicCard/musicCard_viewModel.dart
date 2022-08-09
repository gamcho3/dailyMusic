import 'dart:io';

import 'package:daliy_music/data/models/music_files.dart';
import 'package:daliy_music/data/repository/musicCard_repository.dart';
import 'package:daliy_music/data/repository/playList_repository.dart';
import 'package:flutter/material.dart';

import '../../data/models/playList.dart';

class MusicCardViewModel with ChangeNotifier {
  late final PlayListRepository _playListRepository;
  late final MusicCardRepository _musicCardRepository;
  List<MusicFiles> _playList = [];
  List<MusicFiles> get playList => _playList;

  MusicCardViewModel(int cardNum) {
    _playListRepository = PlayListRepository();
    _musicCardRepository = MusicCardRepository();
    getPlayList(cardNum);
  }

  Future getPlayList(int cardNum) async {
    _playList = await _playListRepository.loadPlayList(cardNum);
    notifyListeners();
  }

  void updateMusicCard(PlayList list) {
    _musicCardRepository.updateCard(list);
  }

  Future<void> deleteCard(int id, List<MusicFiles> playList) async {
    _musicCardRepository.deleteCard(id, playList);
    for (var i = 0; i < playList.length; i++) {
      var file = File(playList[i].musicFilePath);
      await file.delete();
    }
  }

  void deleteMusic(int id) {
    _playListRepository.deleteMusicFile(id);
  }
}
