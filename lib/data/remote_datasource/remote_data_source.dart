
import 'dart:convert';
import 'dart:io';

import 'package:daily_music/key/constants_key.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/weather.dart';
import '../models/youtube_list_models.dart';
import '../models/youtube_popular_model.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

class RemoteDataSource {


  Future<YoutubeModel> getYoutubeList({required String keyword}) async {
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
        return youtubeList;
      } else {
        throw Exception("Error on server");
      }
    } on HttpException {
      throw Exception("Error on server");
    } on FormatException {
      throw Exception("Error on format");
    } catch (e) {
      throw Exception("Error on unknown");
    }
  }
}
