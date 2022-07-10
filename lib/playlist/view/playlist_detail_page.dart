import 'dart:io';
import 'package:daliy_music/playlist/viewModel/playlist.dart';
import 'package:daliy_music/youtube_list/view/search.dart';
import 'package:daliy_music/youtube_list/view_models/card.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;

class PlayListDetailPage extends StatefulWidget {
  const PlayListDetailPage({Key? key}) : super(key: key);

  @override
  State<PlayListDetailPage> createState() => _PlayListDetailPageState();
}

class _PlayListDetailPageState extends State<PlayListDetailPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? title;
  String? content;

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
    List playList = context.watch<CardProvider>().playList;
    bool loading = context.watch<CardProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () async {
              if (image == null && title == null && content == null) {
                print("no");
                return;
              } else {
                context.read<CardProvider>().updateLoading(true);
                for (var i = 0; i < playList.length; i++) {
                  var result = await downloadYoutube(playList[i]['videoId']);
                  playList[i]['musicPath'] = result.path;
                }

                context.read<PlayListProvider>().createCard(
                    imgUrl: image!.path,
                    title: title!,
                    content: content!,
                    musicFiles: playList);
                context.read<CardProvider>().updateLoading(false);
                Navigator.pop(context);
              }
            },
            child: Text('완료'))
      ]),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        image: image != null
                            ? DecorationImage(
                                image: FileImage(File(image!.path)),
                                fit: BoxFit.fill)
                            : null,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: PopupMenuButton(
                        onSelected: (value) async {
                          if (value == 1) {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                          } else {
                            image = await _picker.pickImage(
                                source: ImageSource.camera);
                          }

                          setState(() {});
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("사진 찍기"),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text("사진 선택"),
                            value: 1,
                          )
                        ],
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Icon(
                            LineAwesomeIcons.camera,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  MusicTextField(
                    hintText: "플레이리스트 이름",
                    alignCenter: true,
                    onChange: (value) {
                      title = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MusicTextField(
                    hintText: "설명",
                    alignCenter: false,
                    onChange: (value) {
                      content = value;
                    },
                  ),
                  InkWell(
                      onTap: () {
                        showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => SearchPage());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    LineAwesomeIcons.plus,
                                    color: Colors.green,
                                  ),
                                  const Text(
                                    '노래 추가',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 3,
                              ),
                            ],
                          ))),
                  if (playList.isNotEmpty)
                    for (var i = 0; i < playList.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          dense: true,
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<CardProvider>()
                                      .deletePlayList(i);
                                },
                                child: Icon(
                                  LineAwesomeIcons.minus,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.network(
                                playList[i]['imageUrl'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                          title: Text(playList[i]['title']),
                        ),
                      )
                ],
              ),
            ),
          ),
          if (loading)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "노래 준비중...",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class MusicTextField extends StatelessWidget {
  final String hintText;
  final bool alignCenter;
  final Function(String) onChange;
  const MusicTextField({
    Key? key,
    required this.onChange,
    required this.hintText,
    required this.alignCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 2,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5))),
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      onChanged: onChange,
    );
  }
}
