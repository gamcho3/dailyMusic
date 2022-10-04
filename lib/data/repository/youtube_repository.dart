import 'package:daily_music/data/remote_datasource/remote_data_source.dart';

import '../models/youtube_list_models.dart';

class YoutubeRepository {
  late final RemoteDataSource _remoteDataSource;

  YoutubeRepository() {
    _remoteDataSource = RemoteDataSource();
  }

  Future<YoutubeModel> searchYoutube({required String keyword}) async {
    return await _remoteDataSource.getYoutubeList(keyword: keyword);
  }
}
