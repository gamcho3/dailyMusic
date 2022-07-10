const String tableMusicFiles = 'musicFiles';

class MusicFilesFields {
  static final List<String> values = [id, title, imgUrl, name, filePath];
  static const String id = 'id';
  static const String title = 'title';
  static const String imgUrl = 'imgUrl';
  static const String name = 'name';
  static const String filePath = 'filePath';
}

class MusicFiles {
  final int? id;
  final String title;
  final String name;
  final String musicFilePath;
  final String imgUrl;

  const MusicFiles(
      {this.id,
      required this.name,
      required this.musicFilePath,
      required this.imgUrl,
      required this.title});

  static MusicFiles fromJson(Map<String, Object?> json) => MusicFiles(
      id: json[MusicFilesFields.id] as int,
      name: json[MusicFilesFields.name] as String,
      musicFilePath: json[MusicFilesFields.filePath] as String,
      imgUrl: json[MusicFilesFields.imgUrl] as String,
      title: json[MusicFilesFields.title] as String);

  Map<String, Object?> toJson() => {
        MusicFilesFields.id: id,
        MusicFilesFields.name: name,
        MusicFilesFields.imgUrl: imgUrl,
        MusicFilesFields.title: title,
        MusicFilesFields.filePath: musicFilePath
      };

  MusicFiles copy({
    int? id,
    String? title,
    String? name,
    String? musicFilePath,
    String? imgUrl,
  }) =>
      MusicFiles(
          name: name ?? this.name,
          musicFilePath: musicFilePath ?? this.musicFilePath,
          imgUrl: imgUrl ?? this.imgUrl,
          title: title ?? this.title);
}
