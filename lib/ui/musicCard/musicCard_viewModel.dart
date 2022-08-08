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
    getPlayList(cardNum);
  }

  Future getPlayList(int cardNum) async {
    _playList = await _playListRepository.loadPlayList(cardNum);
    notifyListeners();
  }

  void updateMusicCard(PlayList list) {
    _musicCardRepository.updateCard(list);
  }

  void deleteCard(int id, List<MusicFiles> playList) {
    _musicCardRepository.deleteCard(id, playList);
  }

  void deleteMusic(int id) {
    _playListRepository.deleteMusicFile(id);
  }
}
