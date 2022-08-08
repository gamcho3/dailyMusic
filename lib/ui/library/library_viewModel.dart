import 'package:daliy_music/data/models/playList.dart';
import 'package:daliy_music/data/repository/musicCard_repository.dart';
import 'package:daliy_music/data/repository/playList_repository.dart';
import 'package:flutter/material.dart';

class LibraryViewModel with ChangeNotifier {
  late MusicCardRepository _musicCardRepository;
  List<PlayList>? _cards;
  List<PlayList>? get cards => _cards;

  LibraryViewModel() {
    _musicCardRepository = MusicCardRepository();
    getCards();
  }

  Future<void> getCards() async {
    _cards = await _musicCardRepository.getMusicCards();
    notifyListeners();
  }
}
