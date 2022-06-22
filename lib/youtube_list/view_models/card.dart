import 'dart:convert';

import 'package:daliy_music/youtube_list/models/test_card.dart';
import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  List _cards = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List get cards => _cards;

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
}
