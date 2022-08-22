import 'package:daliy_music/data/models/temp_musicList.dart';
import 'package:hive/hive.dart';

import '../local_datasource/local_data_source.dart';
import '../models/music_files.dart';
import '../models/playList.dart';

class PlayListRepository {
  late HiveDataSource _hiveDataSource;

  PlayListRepository() {
    _hiveDataSource = HiveDataSource();
  }

  Future addMusicFile(
      {required PlayList result, required List<Map> musicFiles}) async {
    for (var item in musicFiles) {
      var music = MusicFiles(
          cardNum: result.id!,
          musicFilePath: item['musicPath'],
          imgUrl: item['imageUrl'],
          title: item['title']);
      await LocalDataSource.instance.insertMusicFile(music);
    }
  }

  Future<List<MusicFiles>> loadPlayList(int? cardNum) async {
    return await LocalDataSource.instance.readFiles(cardNum);
  }

  Future<dynamic> deleteMusicFile(int id) async {
    return await LocalDataSource.instance.deleteMusic(id);
  }

  Future<List<TempMusicList>> getTempList() async {
    return await _hiveDataSource.getTempMusicList();
  }

  Future<void> addTempList(
      String imageUrl, String title, String videoId) async {
    await _hiveDataSource.addTempPlayList(imageUrl, title, videoId);
  }

  Future<void> deleteTempList(TempMusicList musicList) async {
    await _hiveDataSource.deleteTempMusicList(musicList);
  }

  Future<void> deleteTempListAll() async {
    await _hiveDataSource.deleteTempMusicListAll();
  }
}
