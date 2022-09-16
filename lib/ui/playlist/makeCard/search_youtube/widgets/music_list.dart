import 'dart:io';

import 'package:daliy_music/ui/playlist/makeCard/make_playlist_viewModel.dart';
import 'package:daliy_music/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../data/models/youtube_list_models.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388,
      height: 53,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x29000000).withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: Colors.white),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.item.snippet.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.item.snippet.channelTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                //Text(state.items[1].snippet.description)
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                if (isCheck) {
                  return;
                } else {
                  if (widget.item.id.videoId == null) {
                    Constants.showActionSnackbar(context, "id가 존재하지 않습니다.");
                  } else {
                    context.read<MakePlayListViewModel>().addTempPlayList(
                        widget.item.snippet.thumbnails.medium.url,
                        widget.item.snippet.title,
                        widget.item.id.videoId!);

                    setState(() {
                      isCheck = true;
                    });
                  }
                }
              },
              icon: isCheck
                  ? const Icon(LineAwesomeIcons.check)
                  : const Icon(LineAwesomeIcons.plus))
        ],
      ),
    );
  }
}
