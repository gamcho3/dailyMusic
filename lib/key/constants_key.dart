import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  static String youtubeKey = dotenv.env['YOUTUBE_KEY']!;
  static var kakaoAppKey = dotenv.env['KAKAO_KEY'];
}
