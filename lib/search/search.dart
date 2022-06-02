import 'package:daliy_music/bloc/youtubeBloc/youtube_bloc.dart';
import 'package:daliy_music/services/youtube.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
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

  // void asyncMethod() async {
  //   var _youtubeList = YoutubeServices();
  //   var value = await _youtubeList.getYoutubeData(keyword: 'bts');
  //   print(value);
  // }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => YoutubeBloc(
        RepositoryProvider.of<YoutubeServices>(context),
      )..add(LoadYoutubeEvent(keyword)),
      child: BlocListener<YoutubeBloc, YoutubeState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _textController,
              onSubmitted: (value) {
                print(value);
                context.read<YoutubeBloc>().add(LoadYoutubeEvent(value));
                // RepositoryProvider.of<YoutubeBloc>(context)
                //     .add(LoadYoutubeEvent(value));
              },
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: keyword.isEmpty
                      ? null
                      : IconButton(
                          onPressed: (() {
                            _textController.clear();
                            setState(() {
                              keyword = '';
                            });
                          }),
                          icon: const Icon(LineAwesomeIcons.times)),
                  hintText: "노래,아티스트 검색"),
              maxLines: 1,
            ),
          ),
          body: BlocBuilder<YoutubeBloc, YoutubeState>(
            builder: (context, state) {
              // if (state is YoutubeLoadingState) {
              //   return const Center(child: CircularProgressIndicator());
              // }

              if (state is YoutubeLoadedState) {
                print(state.items.length);
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      //MARK: 앱바
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //         flex: 1,
                      //         child: IconButton(
                      //             onPressed: () {
                      //               Navigator.pop(context);
                      //             },
                      //             icon: const Icon(
                      //                 LineAwesomeIcons.angle_left))),
                      //     Expanded(
                      //       flex: 6,
                      //       child: TextField(
                      //         controller: _textController,
                      //         onSubmitted: (value) {
                      //           print(value);
                      //           BlocProvider.of<YoutubeBloc>(context)
                      //               .add(LoadYoutubeEvent(value));
                      //         },
                      //         onChanged: (value) {
                      //           setState(() {
                      //             keyword = value;
                      //           });
                      //         },
                      //         decoration: InputDecoration(
                      //             contentPadding:
                      //                 const EdgeInsets.symmetric(
                      //                     vertical: 0, horizontal: 12),
                      //             border: OutlineInputBorder(
                      //                 borderRadius:
                      //                     BorderRadius.circular(20)),
                      //             suffixIcon: keyword.isEmpty
                      //                 ? null
                      //                 : IconButton(
                      //                     onPressed: (() {
                      //                       _textController.clear();
                      //                       setState(() {
                      //                         keyword = '';
                      //                       });
                      //                     }),
                      //                     icon: const Icon(
                      //                         LineAwesomeIcons.times)),
                      //             hintText: "노래,아티스트 검색"),
                      //         maxLines: 1,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: ((context, index) {
                              return MusicList(
                                item: state.items[index],
                              );
                            })),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class MusicList extends StatelessWidget {
  final Item item;
  const MusicList({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
            item.snippet.thumbnails.medium.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.snippet.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              item.snippet.channelTitle,
              maxLines: 2,
            ),
            //Text(state.items[1].snippet.description)
          ],
        ),
      )
    ]);
  }
}
