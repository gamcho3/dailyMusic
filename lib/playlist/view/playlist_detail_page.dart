import 'package:daliy_music/db/database.dart';
import 'package:daliy_music/playlist/viewModel/playlist.dart';
import 'package:daliy_music/youtube_list/view/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../model/playList.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              if (image == null && title == null && content == null) {
                print("no");
                return;
              } else {
                context.read<PlayListProvider>().createCard(
                    imgUrl: image!.path, title: title!, content: content!);
                Navigator.pop(context);
              }
            },
            child: Text('저장'))
      ]),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: Text('이미지 추가')),
              Expanded(
                child: Text(
                  image?.path ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          TextFormField(
            initialValue: '제목',
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          TextFormField(
            initialValue: '내용',
            onChanged: (value) {
              setState(() {
                content = value;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return SearchPage();
                })));
              },
              child: Text('노래 추가'))
        ],
      ),
    );
  }
}
