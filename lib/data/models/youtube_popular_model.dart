// To parse this JSON data, do
//
//     final popularList = popularListFromJson(jsonString);

import 'dart:convert';

PopularList popularListFromJson(String str) =>
    PopularList.fromJson(json.decode(str));

String popularListToJson(PopularList data) => json.encode(data.toJson());

class PopularList {
  PopularList({
    required this.items,
  });

  List<PopularItems> items;

  factory PopularList.fromJson(Map<String, dynamic> json) => PopularList(
        items: List<PopularItems>.from(
            json["items"].map((x) => PopularItems.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class PopularItems {
  PopularItems({
    required this.id,
    required this.snippet,
  });

  String id;
  Snippet snippet;

  factory PopularItems.fromJson(Map<String, dynamic> json) => PopularItems(
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "snippet": snippet.toJson(),
      };
}

class Snippet {
  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.thumbnails,
  });

  DateTime publishedAt;
  String channelId;
  String title;
  Thumbnails thumbnails;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "thumbnails": thumbnails.toJson(),
      };
}

class Thumbnails {
  Thumbnails({
    required this.thumbnailsDefault,
    required this.medium,
    required this.high,
  });

  Default thumbnailsDefault;
  Default medium;
  Default high;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]),
      );

  Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
      };
}

class Default {
  Default({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
