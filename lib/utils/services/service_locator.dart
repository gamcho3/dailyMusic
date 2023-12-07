import 'package:audio_service/audio_service.dart';
import 'package:daily_music/utils/services/page_manager.dart';
import 'package:daily_music/utils/services/playlist_repository.dart';

import 'audio_handler.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
