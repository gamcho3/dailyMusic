import 'dart:convert';
import 'dart:io';

import 'package:daliy_music/key/constants_key.dart';
import 'package:daliy_music/youtube_list/models/youtube_popular_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/youtube_list_models.dart';
import 'api_status.dart';

class YoutubeServices {
  static Future getYoutubeList<YoutubeListModel>(
      {required String keyword}) async {
    try {
      var response = await http
          .get(
            Uri.parse(
                'https://www.googleapis.com/youtube/v3/search?key=AIzaSyBOABnW6QiU6KRfD3BtmnF-iSJAEyyzS0Q&part=snippet&q=$keyword&maxResults=10'),
          )
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        final youtubeList = youtubeModelFromJson(responseBody);
        return Success(response: youtubeList);
      }
      return Failure(code: 100, errResponse: "Inavalid Response");
    } on HttpException {
      return Failure(code: 101, errResponse: "No internet");
    } on FormatException {
      return Failure(code: 102, errResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: 103, errResponse: "Unknown Error");
    }
  }

  static Future popularYoutubeList<YoutubeListModel>(
      {String region = "KR"}) async {
    try {
      String videoCategoryId = "10";

      String regionCode = "KR";

      String url =
          'https://www.googleapis.com/youtube/v3/videos?key=${ApiKey.youtubeKey}&part=snippet&chart=mostPopular&videoCategoryId=$videoCategoryId&regionCode=$regionCode';

      var response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        final youtubeList = popularListFromJson(responseBody);
        return Success(response: youtubeList);
      }
      return Failure(code: 100, errResponse: "Inavalid Response");
    } on HttpException {
      return Failure(code: 101, errResponse: "No internet");
    } on FormatException {
      return Failure(code: 102, errResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: 103, errResponse: "Unknown Error");
    }
  }
}
