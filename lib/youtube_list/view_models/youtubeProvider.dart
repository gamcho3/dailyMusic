import 'package:daliy_music/youtube_list/models/youtube_list_models.dart';
import 'package:daliy_music/youtube_list/models/youtube_popular_model.dart';
import 'package:daliy_music/youtube_list/repo/api_status.dart';
import 'package:daliy_music/youtube_list/repo/youtube_services.dart';
import 'package:flutter/material.dart';

class YoutubeProvider with ChangeNotifier {
  bool _loading = false;

  List<Item> _musicList = [];
  List<PopularItems> _popularList = [];
  List<PopularItems> _popularListUs = [];
  //MARK: - getter

  List<Item> get musicList => _musicList;
  List<PopularItems> get popularList => _popularList;
  List<PopularItems> get popularListUs => _popularListUs;
  bool get loading => _loading;
  //MARK: - setter

  YoutubeProvider() {
    popularYoutubeList();
    popularYoutubeListUs();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future loadMainPage() async {
    popularYoutubeList();
    popularYoutubeListUs();
  }

  setYoutubeListModel(YoutubeModel youtubeListModel) {
    print('search');
    _musicList = youtubeListModel.items;
    notifyListeners();
  }

  setPopularList(PopularList list) {
    _popularList = list.items;
    notifyListeners();
  }

  setPopularListUs(PopularList list) {
    _popularListUs = list.items;
  }

  getYoutubeList(keyword) async {
    clearMusicList();
    setLoading(true);
    var response = await YoutubeServices.getYoutubeList(keyword: keyword);
    if (response is Success) {
      setYoutubeListModel(response.response as YoutubeModel);
      setLoading(false);
    }
  }

  popularYoutubeList() async {
    var response = await YoutubeServices.popularYoutubeList();
    if (response is Success) {
      setPopularList(response.response as PopularList);
    }
  }

  popularYoutubeListUs() async {
    var response = await YoutubeServices.popularYoutubeList(region: "US");
    if (response is Success) {
      setPopularListUs(response.response as PopularList);
    }
  }

  void clearMusicList() {
    _musicList.clear();
    notifyListeners();
  }
}
