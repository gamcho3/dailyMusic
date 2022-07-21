const String tableMusicFiles = 'musicFiles';

class MusicFilesFields {
  static final List<String> values = [id, title, imgUrl, filePath, cardNum];
  static const String id = 'id';
  static const String title = 'title';
  static const String imgUrl = 'imgUrl';
  static const String filePath = 'filePath';
  static const String cardNum = 'cardNum';
}

class MusicFiles {
  final int? id;
  final String title;
  final String musicFilePath;
  final String imgUrl;
  final int cardNum;

  const MusicFiles(
      {this.id,
      required this.cardNum,
      required this.musicFilePath,
      required this.imgUrl,
      required this.title});

  static MusicFiles fromJson(Map<String, Object?> json) => MusicFiles(
      id: json[MusicFilesFields.id] as int,
      musicFilePath: json[MusicFilesFields.filePath] as String,
      imgUrl: json[MusicFilesFields.imgUrl] as String,
      title: json[MusicFilesFields.title] as String,
      cardNum: json[MusicFilesFields.cardNum] as int);

  Map<String, Object?> toJson() => {
        MusicFilesFields.imgUrl: imgUrl,
        MusicFilesFields.title: title,
        MusicFilesFields.filePath: musicFilePath,
        MusicFilesFields.cardNum: cardNum
      };

  MusicFiles copy({
    int? id,
    String? title,
    String? musicFilePath,
    String? imgUrl,
    int? cardNum,
  }) =>
      MusicFiles(
          musicFilePath: musicFilePath ?? this.musicFilePath,
          imgUrl: imgUrl ?? this.imgUrl,
          title: title ?? this.title,
          cardNum: cardNum ?? this.cardNum);
}
