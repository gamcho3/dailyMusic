import 'dart:io';
import 'package:daliy_music/library/widget/page_header.dart';
import 'package:daliy_music/player/player.dart';
import 'package:daliy_music/playlist/model/music_files.dart';
import 'package:daliy_music/playlist/model/playList.dart';
import 'package:daliy_music/playlist/viewModel/playlist.dart';
import 'package:daliy_music/youtube_list/view_models/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class CardDetail extends StatefulWidget {
  final PlayList item;
  const CardDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PlayListProvider>().readPlayList(widget.item.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = context.watch<PlayListProvider>().playList;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // SliverPersistentHeader(
              //     delegate: NetworkingPageHeader(
              //         maxExtent: 250.0,
              //         minExtent: 150.0,
              //         image: widget.item.imgUrl)),
              SliverAppBar(
                pinned: true,
                actions: [
                  PopupMenuButton(
                      onSelected: (value) {
                        print(value);
                        if (value == 1) {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                    message: Text("???????????? ????????????????????? ??????????????? ???????????????."),
                                    cancelButton: CupertinoActionSheetAction(
                                      /// This parameter indicates the action would perform
                                      /// a destructive action such as delete or exit and turns
                                      /// the action's text color to red.
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('??????'),
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          context
                                              .read<PlayListProvider>()
                                              .deleteCard(widget.item.id, list);

                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        },
                                        child: const Text('?????????????????? ??????'),
                                      )
                                    ],
                                  ));
                        }
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 0,
                              child: Row(
                                children: const [
                                  Text("??????"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    LineAwesomeIcons.edit,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: const [
                                  Text(
                                    "???????????? ??????",
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(LineAwesomeIcons.horizontal_ellipsis),
                      ))
                ],
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Image.asset(
                      widget.item.imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(70.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () async {
                              // ignore: use_build_context_synchronously
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return PlayerPage(
                                  items: list,
                                );
                              })));
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    )),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
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
