import 'package:daliy_music/ui/search/music_search_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class MusicSearchView extends StatelessWidget {
  const MusicSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicSearchViewModel>(builder: (context, provider, child) {
      var result = provider.searchResult;

      return Scaffold(
        appBar: AppBar(
          title: Text("검색결과"),
          leading: IconButton(
            icon: Icon(LineAwesomeIcons.arrow_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Builder(builder: (context) {
          if (result != null) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Container(
                      width: 388,
                      height: 53,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x29000000).withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 6,
                                spreadRadius: 0)
                          ],
                          color: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.network(
                              result.items[index].snippet.thumbnails.high.url,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('images/unsplash.jpg');
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                result.items[index].snippet.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  );
                  // return ListTile(
                  //   leading: Image.network(
                  //     result.items[index].snippet.thumbnails.high.url,
                  //     errorBuilder: (context, error, stackTrace) {
                  //       return Image.asset('images/unsplash.jpg');
                  //     },
                  //   ),
                  //   title: Text(result.items[index].snippet.title),
                  // );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: result.items.length);
          } else {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(10, (index) => shimmerBox()),
              ),
            );
          }
        }),
      );
    });
  }

  Shimmer shimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
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
