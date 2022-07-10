import 'dart:io';
import 'package:daliy_music/youtube_list/models/youtube_list_models.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicList extends StatefulWidget {
  final Item item;

  const MusicList({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  bool isCheck = false;

  get path => null;
  @override
  void initState() {
    super.initState();
  }

  Future<File> downloadYoutube(link) async {
    var yt = YoutubeExplode();
    //Directory('downloads').createSync();
    // Get video metadata.
    var video = await yt.videos.get(link);
    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(link);

    var audio = manifest.audio[1];
    // Build the directory.
    var dir = await getApplicationDocumentsDirectory();
    var filePath =
        path.join(dir.uri.toFilePath(), '${video.id}.${audio.container.name}');

    //Open the file to write.
    var file = File(filePath);
    var fileStream = file.openWrite();

    await yt.videos.streamsClient.get(audio).pipe(fileStream);
    // Create the message and set the cursor position.

    await fileStream.flush();
    await fileStream.close();

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // downloadYoutube(widget.item.id.videoId).then((value) {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return PlayerPage(
        //       videoFile: value,
        //       videoFiles: [],
        //     );
        //   }));
        // });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              width: 70,
              height: 70,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 1.0, spreadRadius: 1.0)
              ], borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                widget.item.snippet.thumbnails.medium.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.item.snippet.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.item.snippet.channelTitle,
                  maxLines: 2,
                ),
                //Text(state.items[1].snippet.description)
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                if (isCheck) {
                  return;
                } else {
                  var result = await downloadYoutube(widget.item.id.videoId);
                  setState(() {
                    isCheck = true;
                  });
                }
              },
              icon: isCheck
                  ? Icon(LineAwesomeIcons.check)
                  : Icon(LineAwesomeIcons.plus))
        ],
      ),
    );
  }
}
