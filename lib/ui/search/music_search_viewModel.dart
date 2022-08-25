import 'package:daliy_music/data/models/youtube_list_models.dart';
import 'package:daliy_music/data/repository/youtube_repository.dart';
import 'package:flutter/material.dart';

class MusicSearchViewModel with ChangeNotifier {
  late YoutubeRepository _youtubeRepository;
  YoutubeModel? _searchResult;
  YoutubeModel? get searchResult => _searchResult;
  MusicSearchViewModel(String keyword) {
    _youtubeRepository = YoutubeRepository();
    getList(keyword);
  }

  Future<void> getList(String keyword) async {
    _searchResult = await _youtubeRepository.searchYoutube(keyword: keyword);

    notifyListeners();
  }
}
