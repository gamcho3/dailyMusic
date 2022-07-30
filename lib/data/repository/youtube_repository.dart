import 'package:daliy_music/data/remote_datasource/remote_data_source.dart';

class YoutubeRepository {
  late final RemoteDataSource _remoteDataSource;

  Future searchYoutube({required String keyword}) {
    return _remoteDataSource.getYoutubeList(keyword: keyword);
  }
}
