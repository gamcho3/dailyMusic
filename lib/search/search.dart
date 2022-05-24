import 'package:daliy_music/bloc/youtubeBloc/youtube_bloc.dart';
import 'package:daliy_music/services/youtube.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../services/connectivityService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  String keyword = '';

  @override
  void initState() {
    super.initState();
    // asyncMethod();
  }

  void asyncMethod() async {
    var _youtubeList = YoutubeServices();
    var value = await _youtubeList.getYoutubeData(keyword: 'bts');
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YoutubeBloc(
          RepositoryProvider.of<YoutubeServices>(context),
          RepositoryProvider.of<ConnectivityService>(context))
        ..add(const LoadApiEvent('bts')),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextField(
            controller: _textController,
            onSubmitted: (value) {
              setState(() {
                keyword = value;
              });
            },
            // onChanged: (value) {
            //   setState(() {
            //     keyword = value;
            //   });
            // },
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixIcon: keyword.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() {
                          _textController.clear();
                          setState(() {
                            keyword = '';
                          });
                        }),
                        icon: Icon(LineAwesomeIcons.times)),
                hintText: "노래,아티스트 검색"),
            maxLines: 1,
          ),
        ),
        body: BlocBuilder<YoutubeBloc, YoutubeState>(
          builder: (context, state) {
            if (state is YoutubeLoadingState) {
              return const CircularProgressIndicator();
            }

            if (state is YoutubeLoadedState) {
              print(state);
              return Center(
                  child: Column(
                children: [],
              ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
