import 'package:flutter/services.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class YoutubeServices {
  static Future getYoutubeData() async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: <String>[YouTubeApi.youtubeReadonlyScope],
      );
      print(googleSignIn.currentUser);
      var httpClient = (await googleSignIn.authenticatedClient())!;

      var youTubeApi = YouTubeApi(httpClient);
      var favorites = await youTubeApi.playlistItems
          .list(['snippet'], playlistId: 'LL', $fields: "bts" // Liked List
              );
      //print(favorites);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
