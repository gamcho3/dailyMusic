import 'dart:io';

import 'package:daliy_music/ui/playlist/makeCard/make_playlist_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            width: 70,
            height: 70,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 1.0)
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
            onPressed: () {
              if (isCheck) {
                return;
              } else {
                context.read<MakePlayListViewModel>().addTempPlayList(
                    widget.item.snippet.thumbnails.medium.url,
                    widget.item.snippet.title,
                    widget.item.id.videoId!);

                setState(() {
                  isCheck = true;
                });
              }
            },
            icon: isCheck
                ? const Icon(LineAwesomeIcons.check)
                : const Icon(LineAwesomeIcons.plus))
      ],
    );
  }
}
