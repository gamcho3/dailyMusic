import 'dart:io';

import 'package:daily_music/data/repository/musicCard_repository.dart';
import 'package:daily_music/data/repository/playList_repository.dart';
import 'package:daily_music/data/repository/youtube_repository.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;
import '../../data/models/playList.dart';
import '../../data/models/temp_musicList.dart';
import '../../data/models/youtube_list_models.dart';

class MakePlayListViewModel with ChangeNotifier {
  late final PlayListRepository _playListRepository;
  late final MusicCardRepository _musicCardRepository;
  late final YoutubeRepository _youtubeRepository;
  List<TempMusicList> _tempMusicList = [];
  bool _isLoading = false;
  int _progress = 0;
  int get progress => _progress;
  List<Item> _musicList = [];
  List<Item> get musicList => _musicList;
  List<TempMusicList> get tempMusicList => _tempMusicList;
  bool get isLoading => _isLoading;
  MakePlayListViewModel() {
    _playListRepository = PlayListRepository();
    _musicCardRepository = MusicCardRepository();
    _youtubeRepository = YoutubeRepository();
    // deleteTempListAll();
  }

  Future<PlayList> makeCard(
      {required String imgUrl,
      required String title,
      required String content}) async {
    return await _musicCardRepository.createCard(
        imgUrl: imgUrl, title: title, content: content);
  }

  Future<void> makePlayList(PlayList result, List<Map> musicFiles) async {
    _playListRepository.addMusicFile(result: result, musicFiles: musicFiles);
  }

  Future<File> downloadYoutube(link) async {
    var yt = YoutubeExplode();
    //Directory('downloads').createSync();
    // Get video metadata.
    var video = await yt.videos.get(link);
    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(link);
    final List<AudioOnlyStreamInfo> sortedStreamInfo =
        manifest.audioOnly.sortByBitrate();
    print(sortedStreamInfo.first);
    var audio = manifest.audio[1];
    var audioStream = yt.videos.streamsClient.get(audio);
    // Build the directory.
    var dir = await getApplicationDocumentsDirectory();
    var filePath =
        path.join(dir.uri.toFilePath(), '${video.id}.${audio.container.name}');

    //Open the file to write.
    var file = File(filePath);
    var fileStream = file.openWrite();

    // Track the file download status.
    var len = audio.size.totalBytes;
    var count = 0;
    await for (final data in audioStream) {
      // Keep track of the current downloaded data.
      count += data.length;

      // Calculate the current progress.
      var progress = ((count / len) * 100).ceil();
      updateProgressBar(progress);
      print(progress);
      // Update the progressbar.
      // progressBar.update(progress);

      // Write to file.
      fileStream.add(data);
    }
    await yt.videos.streamsClient.get(audio).pipe(fileStream);
    // Create the message and set the cursor position.

    await fileStream.flush();
    await fileStream.close();

    return file;
  }

  void updateProgressBar(int progressNum) {
    _progress = progressNum;
    notifyListeners();
  }

  void updateLoading(bool loading) {
    _isLoading = loading;
    _musicCardRepository.getMusicCards();
    notifyListeners();
  }

  Future<void> addTempPlayList(TempMusicList tempList) async {
    await _playListRepository.addTempList(tempList);
    getTempList();
  }

  Future<void> getTempList() async {
    _tempMusicList = await _playListRepository.getTempList();
    print(_tempMusicList.length);
    notifyListeners();
  }

  Future<void> deleteTempList(TempMusicList musicList) async {
    await _playListRepository.deleteTempList(musicList);
    getTempList();
  }

  Future<void> deleteTempListAll() async {
    await _playListRepository.deleteTempListAll();
    _tempMusicList.clear();
    notifyListeners();
  }

  Future<void> getYoutubeList(keyword) async {
    clearMusicList();
    var result = await _youtubeRepository.searchYoutube(keyword: keyword);
    print(result);
    _musicList = result.items;
    notifyListeners();
  }

  void clearMusicList() {
    _musicList.clear();
    notifyListeners();
  }
}
