import 'dart:convert';

import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  List _cards = [];
  List<Map> _playList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List get cards => _cards;
  List<Map> get playList => _playList;

  set setCards(List value) {
    _cards = value;
    notifyListeners();
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
