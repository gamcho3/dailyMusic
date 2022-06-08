import 'package:daliy_music/search/search.dart';
import 'package:daliy_music/services/youtube.dart';
import 'package:flutter/material.dart';

class YoutubeProvider with ChangeNotifier {
  String _keyword = '';
  List _musicList = [];
  //MARK: - getter
  String get keyword => _keyword;
  List get musicList => _musicList;
  //MARK: - setter

  void getList() async {
    clearMusicList();
    YoutubeListModel list =
        await YoutubeServices.getYoutubeList(keyword: _keyword);
    _musicList = list.items;
    notifyListeners();
  }

  void getKeyword(value) {
    _keyword = value;
    notifyListeners();
  }

  void clearKeyword() {
    _keyword = '';
    notifyListeners();
  }

  void clearMusicList() {
    _musicList.clear();
    notifyListeners();
  }
}
