import 'package:daliy_music/ui/search/music_search_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
                  return ListTile(
                    leading: Image.network(
                      result.items[index].snippet.thumbnails.high.url,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('images/unsplash.jpg');
                      },
                    ),
                    title: Text(result.items[index].snippet.title),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: result.items.length);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      );
    });
  }
}
