import 'dart:io';

import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;

/// 공통 메서드 관리
class CustomMethod {
  /// 음악 다운로드후 Mp3 변환
  static Future<void> downloadMusic() async {
    final yt = YoutubeExplode();
    //Directory('downloads').createSync();
    // Get video metadata.
    final video = await yt.videos.get('H5v3kku4y6Q');
    // Get the video manifest.
    final manifest = await yt.videos.streamsClient.getManifest('H5v3kku4y6Q');
    final streamInfo = manifest.audioOnly.withHighestBitrate();

    final audioStream = yt.videos.streamsClient.get(streamInfo);
    // Build the directory.
    final dir = await getApplicationDocumentsDirectory();
    final filePath = path.join(
        dir.uri.toFilePath(), '${video.id}.${streamInfo.container.name}');

    //Open the file to write.
    final file = File(filePath);
    final fileStream = file.openWrite();

    await for (final data in audioStream) {
      fileStream.add(data);
    }
    await yt.videos.streamsClient.get(streamInfo).pipe(fileStream);
    // Create the message and set the cursor position.

    await fileStream.flush();
    await fileStream.close();

    await FFmpegKit.executeAsync(
      "-i ${file.path} -vn -ab 192k -y ${file.path.split('.')[0]}.mp3",
      (session) async {
        FFmpegKitConfig.sessionStateToString(await session.getState());
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          print("Encode completed successfully");
        } else {
          print("fail");
        }
      },
      (log) => print(log.getMessage()),
    );
  }
}
