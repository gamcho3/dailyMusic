import 'dart:io';

import 'package:daliy_music/ui/library/library_viewModel.dart';
import 'package:daliy_music/ui/musicCard/musicCard_viewModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import '../../data/models/music_files.dart';
import '../../data/models/playList.dart';
import '../../utils/constants/constants.dart';
import '../library/widget/page_header.dart';
import '../player/player.dart';

class MusicCardView extends StatefulWidget {
  final PlayList item;
  const MusicCardView({Key? key, required this.item}) : super(key: key);

  @override
  State<MusicCardView> createState() => _MusicCardViewState();
}

class _MusicCardViewState extends State<MusicCardView> {
  bool isEdit = false;
  late TextEditingController titleEditController;
  late TextEditingController contentEditController;
  late String title;
  late String content;
  @override
  void initState() {
    title = widget.item.title;
    content = widget.item.content;
    titleEditController = TextEditingController(text: title);
    contentEditController = TextEditingController(text: content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = context.watch<MusicCardViewModel>().playList;
    // List<MusicFiles>? curFiles = list;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                color: Colors.white,
              ),
              onPressed: () => context.pop()),
          backgroundColor: Colors.transparent,
          actions: [
            if (isEdit)
              TextButton(
                  onPressed: () {
                    isEdit = false;

                    if (title.isNotEmpty && content.isNotEmpty) {
                      PlayList newCard = PlayList(
                          id: widget.item.id,
                          title: title,
                          imgUrl: widget.item.imgUrl,
                          content: content);
                      context
                          .read<MusicCardViewModel>()
                          .updateMusicCard(newCard);
                      context
                          .read<MusicCardViewModel>()
                          .getPlayList(newCard.id!);
                    }
                    setState(() {});
                  },
                  child: Text("완료")),
            if (!isEdit)
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == 1) {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (buildContext) => CupertinoActionSheet(
                                message:
                                    const Text("삭제하면 플레이리스트의 모는노래가 삭제됩니다."),
                                cancelButton: CupertinoActionSheetAction(
                                  /// This parameter indicates the action would perform
                                  /// a destructive action such as delete or exit and turns
                                  /// the action's text color to red.
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('취소'),
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () async {
                                      await context
                                          .read<MusicCardViewModel>()
                                          .deleteCard(widget.item.id!, list);
                                      if (!mounted) return;
                                      await context
                                          .read<LibraryViewModel>()
                                          .getCards();
                                      if (!mounted) return;
                                      GoRouter.of(context).pushNamed('library');

                                      Navigator.pop(buildContext);
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
                    title = value;
                  },
                  edit: isEdit,
                  maxExtent: 300.0,
                  minExtent: 150.0,
                  image: widget.item.imgUrl,
                  title: title)),
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
                              onChanged: (value) {
                                content = value;
                              },
                              controller: contentEditController,
                              style: const TextStyle(fontSize: 20),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            )
                          : Text(
                              content,
                              style: const TextStyle(fontSize: 20),
                            ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ]),
            ),
          ),
          if (list.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text("노래가 없습니다.")),
            ),
          if (list.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  ((context, index) => MusicTile(
                        refresh: () {
                          setState(() {});
                        },
                        isEdit: isEdit,
                        items: list,
                        index: index,
                      )),
                  childCount: list.length),
            )
        ],
      ),
    );
  }
}

class MusicTile extends StatefulWidget {
  const MusicTile(
      {Key? key,
      required this.index,
      required this.items,
      required this.isEdit,
      required this.refresh})
      : super(key: key);

  final int index;
  final bool isEdit;
  final Function() refresh;
  final List<MusicFiles> items;

  @override
  State<MusicTile> createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {
  @override
  Widget build(BuildContext buildContext) {
    return Slidable(
      enabled: widget.isEdit,
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context) async {
              context
                  .read<MusicCardViewModel>()
                  .deleteMusic(widget.items[widget.index].id!);
              widget.items.removeAt(widget.index);
              Constants.showActionSnackbar(buildContext, "노래가 삭제되었습니다.");

              setState(() {});
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: LineAwesomeIcons.trash,
            label: '삭제',
          ),
        ],
      ),
      child: Builder(builder: (ctx) {
        if (widget.items.isEmpty) {
          return const Align(
              alignment: Alignment.bottomCenter, child: Text("노래가 없습니다."));
        }
        return ListTile(
          trailing: widget.isEdit
              ? IconButton(
                  onPressed: () async {
                    Slidable.of(ctx)?.openEndActionPane();
                  },
                  icon: const Icon(
                    LineAwesomeIcons.minus_circle,
                    color: Colors.red,
                  ))
              : null,
          leading: SizedBox(
            width: 60,
            height: 50,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                widget.items[widget.index].imgUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(widget.items[widget.index].title),
        );
      }),
    );
  }
}
