const String tablePlayLists = 'playLists';

class PlayListFields {
  static final List<String> values = [id, title, imgUrl, content];

  static const String id = '_id';
  static const String title = 'title';
  static const String imgUrl = 'imgUrl';
  static const String content = 'content';
}

class PlayList {
  final int? id;
  final String title;
  final String content;
  final String imgUrl;

  const PlayList(
      {this.id,
      required this.title,
      required this.imgUrl,
      required this.content});

  static PlayList fromJson(Map<String, Object?> json) => PlayList(
      id: json[PlayListFields.id] as int?,
      imgUrl: json[PlayListFields.imgUrl] as String,
      title: json[PlayListFields.title] as String,
      content: json[PlayListFields.content] as String);

  Map<String, Object?> toJson() => {
        PlayListFields.id: id,
        PlayListFields.imgUrl: imgUrl,
        PlayListFields.title: title,
        PlayListFields.content: content
      };

  PlayList copy({
    int? id,
    String? title,
    String? content,
    String? imgUrl,
  }) =>
      PlayList(
          title: title ?? this.title,
          content: content ?? this.content,
          imgUrl: imgUrl ?? this.imgUrl,
          id: id ?? this.id);
}
