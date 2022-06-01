import 'package:http/http.dart' as http;

class YoutubeServices {
  static Future getYoutubeData() async {
    var response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?key=AIzaSyBOABnW6QiU6KRfD3BtmnF-iSJAEyyzS0Q'));
  }
}
