import 'dart:io';

import 'package:daily_music/features/common/domains/music_model.dart';
import 'package:daily_music/features/create_music/presentation/view/create_music_screen.dart';
import 'package:daily_music/features/home/views/home_screen.dart';
import 'package:daily_music/routes/routes.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_audio/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;
import '../services/isar_helper.dart';

/// 공통 메서드 관리
class CustomMethod {
  /// 음악 다운로드후 Mp3 변환
  static Future<void> downloadMusic(
      String code, WidgetRef ref, BuildContext context) async {
    var logger = Logger();

    final yt = YoutubeExplode();
    //Directory('downloads').createSync();
    // Get video metadata.
    final video = await yt.videos.get(code);

    // 노래 제목
    final title = video.title;

    // 썸네일
    final image = video.thumbnails.highResUrl;

    // 이름
    final author = video.author;

    // Get the video manifest.
    final manifest = await yt.videos.streamsClient.getManifest(code);
    final streamInfo = manifest.audioOnly.withHighestBitrate();

    final audioStream = yt.videos.streamsClient.get(streamInfo);

    // Build the directory.
    final dir = await getApplicationDocumentsDirectory();
    final filePath = path.join(
      dir.uri.toFilePath(),
      '${video.id}.${streamInfo.container.name}',
    );

    //Open the file to write.
    final file = File(filePath);
    final fileStream = file.openWrite();

    //count progress
    final audio = manifest.audio[1];
    final len = audio.size.totalBytes;
    int count = 0;
    await for (final data in audioStream) {
      count += data.length;

      // Calculate the current progress.
      var progress = ((count / len) * 100).ceil();
      ref.read(countProvider.notifier).update((state) => progress);
      fileStream.add(data);
    }
    await yt.videos.streamsClient.get(streamInfo).pipe(fileStream);

    // webm downlaod 완료
    await fileStream.flush();
    await fileStream.close();
    // count 초기화
    ref.read(countProvider.notifier).state = 0;

    //mp3 변환 시작
    final info = await FFprobeKit.getMediaInformation(file.path);
    final durationString = info.getMediaInformation()?.getDuration();
    final duration = double.tryParse(durationString!) ?? 0.0;
    //변환 -> webm to mp3
    await FFmpegKit.executeAsync(
        '-i ${file.path} -vn -ab 192k -y ${path.withoutExtension(file.path)}.mp3',
        (session) async {
          FFmpegKitConfig.sessionStateToString(await session.getState());
          final returnCode = await session.getReturnCode();
          // print(session.getFailStackTrace());
          if (ReturnCode.isSuccess(returnCode)) {
            print("Encode completed successfully");

            //DB 저장
            final newMusic = MusicModel()
              ..title = title
              ..subtitle = author
              ..albumArt = image
              ..route = '${path.withoutExtension(file.path)}.mp3';
            final isarInstance = await IsarSingleton.instance.isar;

            await isarInstance.writeTxn(() async {
              await isarInstance.musicModels.put(newMusic);
            });

            HomeRoute().go(context);
          } else if (ReturnCode.isCancel(returnCode)) {
            print("cancel");
          } else {
            print("error and fail");
          }
        },
        (log) => print(log.getMessage()),
        (statistics) {
          int progress = ((statistics.getTime() / duration) * 100).ceil();
          ref.read(countProvider.notifier).update((state) => progress);
        });
  }
}
