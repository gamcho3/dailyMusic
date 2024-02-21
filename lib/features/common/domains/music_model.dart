import 'package:isar/isar.dart';
part 'music_model.g.dart';

sealed class MusicsInitial {}

class MusicsSuccess extends MusicsInitial {
  MusicsSuccess({this.list});
  final List<MusicModel>? list;
}

class MusicsLoading extends MusicsInitial {}

class MusicsError extends MusicsInitial {}

@collection
class MusicModel {
  Id id = Isar.autoIncrement;
  late String albumArt;
  @Index(type: IndexType.value)
  late String title;
  late String subtitle;
  late String route;
}
