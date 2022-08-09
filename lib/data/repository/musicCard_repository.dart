import 'dart:io';
import 'package:daliy_music/data/local_datasource/local_data_source.dart';
import 'package:daliy_music/data/models/playList.dart';
import '../models/music_files.dart';

class MusicCardRepository {
  Future<List<PlayList>> getMusicCards() async {
    return await LocalDataSource.instance.readAllLists();
  }

  Future<PlayList> createCard({
    required String imgUrl,
    required String title,
    required String content,
  }) async {
    final list = PlayList(imgUrl: imgUrl, title: title, content: content);
    return await LocalDataSource.instance.create(list);
  }

  void deleteCard(id, List<MusicFiles> playList) async {
    await LocalDataSource.instance.delete(id);
    await LocalDataSource.instance.deleteAllMusics(id);
  }

  Future<int> updateCard(PlayList list) async {
    return await LocalDataSource.instance.updateCard(list);
  }
}
