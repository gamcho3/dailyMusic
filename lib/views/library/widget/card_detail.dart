import 'dart:io';

import 'package:daliy_music/models/music_files.dart';
import 'package:daliy_music/models/playList.dart';
import 'package:daliy_music/views/library/widget/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../view_models/playlist.dart';
import '../../player/player.dart';
import '../../playlist/playlist_detail_page.dart';

class CardDetail extends StatefulWidget {
  final PlayList item;
  const CardDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  bool isEdit = false;
  late TextEditingController titleEditController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PlayListProvider>().loadPlayList(widget.item.id);
    });
    titleEditController = TextEditingController(text: widget.item.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = context.watch<PlayListProvider>().playList;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            if (isEdit)
              TextButton(
                  onPressed: () {
                    isEdit = false;
                    setState(() {});
                  },
                  child: Text("완료")),
            if (!isEdit)
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == 1) {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                                message:
                                    const Text("삭제하면 플레이리스트의 모는노래가 삭제됩니다."),
                                cancelButton: CupertinoActionSheetAction(
                                  /// This parameter indicates the action would perform
                                  /// a destructive action such as delete or exit and turns
                                  /// the action's text color to red.
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('취소'),
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      context
                                          .read<PlayListProvider>()
                                          .deleteCard(widget.item.id, list);

                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    },
                                    child: const Text('플레이리스트 삭제'),
                                  )
                                ],
                              ));
                    } else if (value == 0) {
                      isEdit = true;
                      setState(() {});
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: const [
                              Text("펀집"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                LineAwesomeIcons.edit,
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Text(
                                "목록에서 삭제",
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                LineAwesomeIcons.trash,
                                color: Colors.red,
                              )
                            ],
                          ),
                        )
                      ],
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      LineAwesomeIcons.horizontal_ellipsis,
                      color: Colors.white,
                    ),
                  ))
          ]),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: NetworkingPageHeader(
                  controller: titleEditController,
                  onChanged: (value) {
                    print(value);
                  },
                  edit: isEdit,
                  maxExtent: 300.0,
                  minExtent: 150.0,
                  image: widget.item.imgUrl,
                  title: widget.item.title)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          // ignore: use_build_context_synchronously
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return PlayerPage(
                              items: list,
                            );
                          })));
                        },
                        child: SizedBox(
                          width: 100,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "재생",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: isEdit
                          ? TextField(
                              style: TextStyle(fontSize: 20),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            )
                          : Text(
                              widget.item.content,
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    if (list.isNotEmpty)
                      for (var i = 0; i < list.length; i++)
                        MusicTile(
                          item: list[i],
                          index: i,
                        ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class MusicTile extends StatelessWidget {
  const MusicTile({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  final int index;
  final MusicFiles item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 60,
        height: 50,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            item.imgUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(item.title),
    );
  }
}
