import 'package:flutter/material.dart';

import '../../data/models/playList.dart';
import '../../data/repository/musicCard_repository.dart';

class PlayListViewModel with ChangeNotifier {
  late final MusicCardRepository _musicCardRepository;
  List<PlayList> _cards = [];
  List<PlayList> get cards => _cards;

  PlayListViewModel() {
    _musicCardRepository = MusicCardRepository();
    getCards();
  }

  Future getCards() async {
    _cards = await _musicCardRepository.getMusicCards();
    notifyListeners();
  }
}
