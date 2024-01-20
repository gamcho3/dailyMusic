import 'package:daily_music/features/common/domains/music_model.dart';
import 'package:daily_music/utils/services/isar_helper.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_list_provider.g.dart';

@riverpod
class Musics extends _$Musics {
  @override
  MusicsInitial build() {
    loadMusic();
    return MusicsLoading();
  }

  Future<void> loadMusic() async {
    final isarInstance = await IsarSingleton.instance.isar;
    final musics = await isarInstance.musicModels.where().findAll();
    state = MusicsSuccess(list: musics);
  }
}
