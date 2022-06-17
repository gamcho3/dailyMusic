import 'package:daliy_music/youtube_list/models/youtube_list_models.dart';
import 'package:daliy_music/youtube_list/models/youtube_popular_model.dart';
import 'package:daliy_music/youtube_list/repo/api_status.dart';
import 'package:daliy_music/youtube_list/repo/youtube_services.dart';
import 'package:flutter/material.dart';

class YoutubeProvider with ChangeNotifier {
  bool _loading = false;

  List<Item> _musicList = [];
  List<PopularItems> _popularList = [];
  //MARK: - getter

  List<Item> get musicList => _musicList;
  List<PopularItems> get popularList => _popularList;
  bool get loading => _loading;
  //MARK: - setter

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
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

  void clearMusicList() {
    _musicList.clear();
    notifyListeners();
  }
}
