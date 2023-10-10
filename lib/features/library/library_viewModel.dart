import 'package:daily_music/data/models/playList.dart';
import 'package:daily_music/data/models/weather.dart';
import 'package:daily_music/data/repository/musicCard_repository.dart';
import 'package:daily_music/data/repository/playList_repository.dart';
import 'package:daily_music/data/repository/weather_repository.dart';
import 'package:flutter/material.dart';

class LibraryViewModel with ChangeNotifier {
  bool _disposed = false;

  // dispose 할 때 _disposed -> true
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  // _disposed == false 일 때만, super.notifyListeners() 호출!
  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  late MusicCardRepository _musicCardRepository;
  late PlayListRepository _playListRepository;
  List<PlayList>? _cards;
  WeatherModel? _weatherData;
  WeatherModel? get weatherData => _weatherData;
  List<PlayList>? get cards => _cards;

  LibraryViewModel() {
    _musicCardRepository = MusicCardRepository();
    _playListRepository = PlayListRepository();
    getCards();
    // getWeather();
  }

  Future<void> getCards() async {
    print('load getcards');
    _cards = await _musicCardRepository.getMusicCards();
    notifyListeners();
  }

  Future<void> clearTempList() async {
    await _playListRepository.deleteTempListAll();
    notifyListeners();
  }
}
