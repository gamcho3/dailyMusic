import 'dart:async';
import 'dart:io';
import 'package:daliy_music/ui/makeCard/make_playlist_viewModel.dart';
import 'package:daliy_music/ui/makeCard/search_youtube/widgets/music_list.dart';
import 'package:daliy_music/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:shimmer/shimmer.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;
  final _textController = TextEditingController();
  FocusNode _focus = FocusNode();
  bool isFocus = true;
  bool isLoading = false;
  final BannerAd _banner = BannerAd(
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        print(error);
      },
      onAdLoaded: (_) {},
    ),
    size: AdSize.banner,
    adUnitId: UNIT_ID[Platform.isIOS ? 'ios' : 'android']!,
    request: const AdRequest(),
  )..load();

  @override
  void initState() {
    super.initState();
  }

  // _onsearchChanged(String query, YoutubeProvider provider) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   print(query);
  //   _debounce = Timer(Duration(milliseconds: 500), () {
  //     provider.getYoutubeList(query);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<MakePlayListViewModel>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(LineAwesomeIcons.arrow_left)),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          autofocus: true,
                          focusNode: _focus,
                          controller: _textController,
                          onSubmitted: (value) async {
                            isLoading = true;
                            provider.getYoutubeList(value).then((value) {
                              isFocus = false;
                              isLoading = false;
                            });

                            setState(() {});
                          },
                          onChanged: (value) {
                            // _onsearchChanged(value, provider);
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffixIcon: _textController.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: (() {
                                        _textController.clear();
                                      }),
                                      icon: const Icon(LineAwesomeIcons.times)),
                              hintText: "노래,아티스트 검색"),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // if (isFocus)
                  //   Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [Text("최근 검색어")]),
                  if (isLoading)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              10,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: shimmerBox(),
                                  )),
                        ),
                      ),
                    ),
                  if (provider.musicList.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: ((context, index) {
                            return const SizedBox(
                              height: 13,
                            );
                          }),
                          itemCount: provider.musicList.length,
                          itemBuilder: ((context, index) {
                            if (index == 0) {
                              return Container(
                                  height: 53, child: AdWidget(ad: _banner));
                            }
                            return MusicList(item: provider.musicList[index]);
                          })),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Shimmer shimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.black12.withOpacity(0.1),
      highlightColor: Colors.white,
      loop: 3,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: 388,
            height: 53,
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
          ),
        ),
      ),
    );
  }
}
