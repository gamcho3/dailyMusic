import 'package:daliy_music/data/models/playList.dart';
import 'package:daliy_music/data/models/weather.dart';
import 'package:daliy_music/data/repository/musicCard_repository.dart';
import 'package:daliy_music/data/repository/playList_repository.dart';
import 'package:daliy_music/data/repository/weather_repository.dart';
import 'package:flutter/material.dart';

class LibraryViewModel with ChangeNotifier {
  late MusicCardRepository _musicCardRepository;
  late WeatherRepository _weatherRepository;
  List<PlayList>? _cards;
  WeatherModel? _weatherData;
  WeatherModel? get weatherData => _weatherData;
  List<PlayList>? get cards => _cards;

  LibraryViewModel() {
    _musicCardRepository = MusicCardRepository();
    _weatherRepository = WeatherRepository();
    getCards();
    getWeather();
  }

  Future<void> getCards() async {
    _cards = await _musicCardRepository.getMusicCards();
    notifyListeners();
  }

  Future<void> getWeather() async {
    _weatherData = await _weatherRepository.obtainWeather();
    notifyListeners();
  }
}
