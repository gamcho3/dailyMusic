import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path/path.dart' as path;
void main(){

  test("유튜브 다운로드 테스트", () async{

    var yt = YoutubeExplode();

    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest('Dpp1sIL1m5Q');
    final streamInfo =
    manifest.audioOnly.withHighestBitrate();
    // Get the actual stream
     final audioStream = yt.videos.streamsClient.get(streamInfo);


    var file = File('output');
    var fileStream = file.openWrite();
    await for (final data in audioStream) {
      // Write to file.
      fileStream.add(data);
    }
    // await audioStream.pipe(fileStream);
    // await fileStream.flush();
    // await fileStream.close();
    print(fileStream);
    FFmpegKit.execute("-i ${FILE} -vn -ab 128k -ar 44100 -y ${FILE%.webm}.mp3").then((session) async{

    });

    });
}