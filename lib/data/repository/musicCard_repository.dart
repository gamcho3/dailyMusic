import 'dart:io';
import 'package:daily_music/data/local_datasource/local_data_source.dart';
import 'package:daily_music/data/models/playList.dart';
import '../../config/di.dart';
import '../models/music_files.dart';
import '../remote_datasource/remote_data_source.dart';

class MusicCardRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  MusicCardRepository(
      {RemoteDataSource? remoteDataSource, LocalDataSource? localDataSource})
      : _remoteDataSource = remoteDataSource ?? getit.get<RemoteDataSource>(),
        _localDataSource = localDataSource ?? getit.get<LocalDataSource>();
  Future<List<PlayList>> getMusicCards() async {
    return await _localDataSource.readAllLists();
  }

  Future<PlayList> createCard({
    required String imgUrl,
    required String title,
    required String content,
  }) async {
    final list = PlayList(imgUrl: imgUrl, title: title, content: content);
    return await _localDataSource.create(list);
  }

  void deleteCard(id, List<MusicFiles> playList) async {
    await _localDataSource.delete(id);
    await _localDataSource.deleteAllMusics(id);
  }

  Future<int> updateCard(PlayList list) async {
    return await _localDataSource.updateCard(list);
  }
}
