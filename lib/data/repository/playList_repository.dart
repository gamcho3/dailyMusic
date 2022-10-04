import 'package:daily_music/data/models/temp_musicList.dart';
import 'package:hive/hive.dart';

import '../../config/di.dart';
import '../local_datasource/local_data_source.dart';
import '../models/music_files.dart';
import '../models/playList.dart';
import '../remote_datasource/remote_data_source.dart';

class PlayListRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  PlayListRepository(
      {RemoteDataSource? remoteDataSource, LocalDataSource? localDataSource})
      : _remoteDataSource = remoteDataSource ?? getit.get<RemoteDataSource>(),
        _localDataSource = localDataSource ?? getit.get<LocalDataSource>();

  Future addMusicFile(
      {required PlayList result, required List<Map> musicFiles}) async {
    for (var item in musicFiles) {
      var music = MusicFiles(
          cardNum: result.id!,
          musicFilePath: item['musicPath'],
          imgUrl: item['imageUrl'],
          title: item['title']);
      await _localDataSource.insertMusicFile(music);
    }
  }

  Future<List<MusicFiles>> loadPlayList(int? cardNum) async {
    return await _localDataSource.readFiles(cardNum);
  }

  Future<dynamic> deleteMusicFile(int id) async {
    return await _localDataSource.deleteMusic(id);
  }

  Future<List<TempMusicList>> getTempList() async {
    return await _localDataSource.getTempMusicList();
  }

  Future<void> addTempList(TempMusicList musicList) async {
    await _localDataSource.addTempPlayList(musicList);
  }

  Future<void> deleteTempList(TempMusicList musicList) async {
    await _localDataSource.deleteTempMusicList(musicList);
  }

  Future<void> deleteTempListAll() async {
    await _localDataSource.deleteTempMusicListAll();
  }
}
