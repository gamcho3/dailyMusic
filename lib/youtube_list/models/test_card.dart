// To parse this JSON data, do
//
//     final CardList = CardListFromJson(jsonString);

import 'dart:convert';

List<CardList> cardListFromJson(String str) =>
    List<CardList>.from(json.decode(str).map((x) => CardList.fromJson(x)));

String cardListToJson(List<CardList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardList {
  CardList({
    required this.title,
    required this.image,
    required this.musicList,
  });

  String title;
  Image image;
  List<String> musicList;

  factory CardList.fromJson(Map<String, dynamic> json) => CardList(
        title: json["title"],
        image: Image.fromJson(json["image"]),
        musicList: List<String>.from(json["musicList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image.toJson(),
        "musicList": List<dynamic>.from(musicList.map((x) => x)),
      };
}

class Image {
  Image({
    required this.hot,
    required this.cool,
  });

  String hot;
  String cool;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        hot: json["hot"],
        cool: json["cool"],
      );

  Map<String, dynamic> toJson() => {
        "hot": hot,
        "cool": cool,
      };
}

class TestCard {
  static List items = [
    {
      "title": "날씨에 맞는 추천 음악",
      "image": {
        "hot":
            "https://images.unsplash.com/photo-1498036882173-b41c28a8ba34?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
        "cool":
            "https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      },
      "musicList": [
        {
          "thumbnail":
              "https://images.unsplash.com/photo-1503301346056-7681a7bcd413?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          "title": "Wet Dream",
          "singer": "Wet Leg",
          "musicCode": "tjpgJjdk52c"
        },
        {
          "thumbnail":
              "https://images.unsplash.com/photo-1636337897543-83b55150608f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
          "title": "Late Night Talking",
          "singer": "Harry Styles",
          "musicCode": "RwT77rlp2CE"
        },
        {
          "thumbnail":
              "https://images.unsplash.com/photo-1550859492-d5da9d8e45f3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          "title": "New Light",
          "singer": "John Mayer",
          "musicCode": "2PH7dK6SLC8"
        },
        {
          "thumbnail":
              "https://images.unsplash.com/photo-1550859492-d5da9d8e45f3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          "title": "Edge Of Desire",
          "singer": "John Mayer",
          "musicCode": "5GTbM5-ku-M"
        },
        {
          "thumbnail":
              "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1473&q=80",
          "title": "Feels",
          "singer": "Calvin Harris",
          "musicCode": "ozv4q2ov3Mk"
        },
      ]
    }
  ];
}
