import 'dart:convert';

import 'package:daliy_music/youtube_list/models/test_card.dart';
import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  List _cards = [];
  List _playList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List get cards => _cards;
  List get playList => _playList;

  CardProvider() {
    getCards();
  }

  set setCards(List value) {
    _cards = value;
    notifyListeners();
  }

  void getCards() {
    setCards = TestCard.items;
  }

  void updateLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void addPlayList(image, title, videoId) {
    Map music = {"imageUrl": image, "title": title, "videoId": videoId};
    _playList.add(music);
    notifyListeners();
  }

  void deletePlayList(int index) {
    _playList.removeAt(index);
    notifyListeners();
  }

  void deletePlayListAll() {
    _playList.clear();
    notifyListeners();
  }
}
