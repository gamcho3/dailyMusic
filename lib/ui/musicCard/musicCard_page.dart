import 'package:daliy_music/ui/library/library_viewModel.dart';
import 'package:daliy_music/ui/musicCard/musicCard_view.dart';
import 'package:daliy_music/ui/musicCard/musicCard_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/playList.dart';

class MusicCardPage extends StatelessWidget {
  final int index;
  final PlayList item;
  const MusicCardPage({Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicCardViewModel(item.id!),
      child: MusicCardView(
        item: item,
      ),
    );
  }
}
