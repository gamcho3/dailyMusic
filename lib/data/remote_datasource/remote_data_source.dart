import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:io';

import 'package:daliy_music/key/constants_key.dart';

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
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }

  static Future getWeather<WeatherModel>(double lat, double lon) async {
    const appId = '8db55fc21a695d9d1bc4a050faaa8af9';
    final response = await http
        .get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appId&units=metric&lang=kr'))
        .timeout(const Duration(seconds: 3));
    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);

      final weatherData = weatherModelFromJson(responseBody);
      return weatherData;
    }
  }

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

  Future addTempMusicList() async {}
}
