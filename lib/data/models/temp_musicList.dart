import 'package:hive/hive.dart';
part 'temp_musicList.g.dart';

@HiveType(typeId: 0)
class TempMusicList extends HiveObject {
  @HiveField(0)
  late String imageurl;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String videoId;
}
