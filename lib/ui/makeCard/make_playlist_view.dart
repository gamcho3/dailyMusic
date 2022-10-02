import 'dart:io';

import 'package:daliy_music/data/models/temp_musicList.dart';
import 'package:daliy_music/ui/makeCard/make_playlist_viewModel.dart';
import 'package:daliy_music/ui/makeCard/search_youtube/search_pages.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constants/constants.dart';

class MakePlayListView extends StatefulWidget {
  const MakePlayListView({
    Key? key,
  }) : super(key: key);

  @override
  State<MakePlayListView> createState() => _MakePlayListViewState();
}

class _MakePlayListViewState extends State<MakePlayListView> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? title;
  String? content;

  @override
  Widget build(BuildContext context) {
    List<TempMusicList> playList =
        context.watch<MakePlayListViewModel>().tempMusicList;
    bool loading = context.watch<MakePlayListViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () async {
              if (image == null || title == null || content == null) {
                //공백전달시 스낵바 출력
                Constants.showActionSnackbar(context, "정보를 정확히 입력해주세요");
              } else {
                //로딩 함수
                context.read<MakePlayListViewModel>().updateLoading(true);
                List<Map> musicListPath = [];
                //이미지 따로 저장
                var file = File(image!.path);

                // var filePath = path.join(dir.uri.toFilePath(),
                //     '$title.${image!.path.substring(image!.path.length - 3)}');

                if (Platform.isAndroid) {
                  final androidDir = await getExternalStorageDirectory();
                  print('andorid');
                  file = await file.copy(
                      '${androidDir?.path}/$title.${image!.path.substring(image!.path.length - 3)}');
                } else {
                  final dir = await getApplicationDocumentsDirectory();
                  print('ios');
                  file = await file.copy(
                      '${dir.path}/$title.${image!.path.substring(image!.path.length - 3)}');
                }
                print(file.path);
                //유튜브 음악 다운로드
                for (var i = 0; i < playList.length; i++) {
                  if (!mounted) return;
                  var result = await context
                      .read<MakePlayListViewModel>()
                      .downloadYoutube(playList[i].videoId);
                  musicListPath.add({
                    "musicPath": result.path,
                    "imageUrl": playList[i].imageurl,
                    "title": playList[i].title
                  });
                }
                //리스트카드 만들기
                if (!mounted) return;
                var result = await context
                    .read<MakePlayListViewModel>()
                    .makeCard(
                        imgUrl: file.path, title: title!, content: content!);
                //플레이리스트 만들기
                if (!mounted) return;
                await context
                    .read<MakePlayListViewModel>()
                    .makePlayList(result, musicListPath);
                //로딩 멈춤
                if (!mounted) return;
                context.read<MakePlayListViewModel>().updateLoading(false);
                GoRouter.of(context).go('/playList');
                Navigator.pop(context);
              }
            },
            child: Text('완료'))
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Stack(
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
                            const PopupMenuItem(
                              child: Text("사진 찍기"),
                              value: 0,
                            ),
                            const PopupMenuItem(
                              child: Text("사진 선택"),
                              value: 1,
                            )
                          ],
                          child: Container(
                            padding: const EdgeInsets.all(7),
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
                    const SizedBox(
                      height: 30,
                    ),
                    MusicTextField(
                      hintText: "플레이리스트 이름",
                      alignCenter: true,
                      onChange: (value) {
                        title = value;
                      },
                    ),
                    const SizedBox(
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
                                  builder: (context) => const SearchPage())
                              .then((value) {
                            context.read<MakePlayListViewModel>().getTempList();
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      LineAwesomeIcons.plus,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      '노래 추가',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 3,
                                ),
                              ],
                            ))),
                    if (playList.isNotEmpty)
                      for (var i = 0; i < playList.length; i++)
                        ListTile(
                          dense: true,
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<MakePlayListViewModel>()
                                      .deleteTempList(playList[i]);
                                },
                                child: const Icon(
                                  LineAwesomeIcons.minus,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.network(
                                playList[i].imageurl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                          title: Text(playList[i].title),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
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
