import 'package:isar/isar.dart';
part 'music_model.g.dart';

sealed class MusicsInitial{}

class MusicsSuccess extends MusicsInitial{
 final List<MusicModel> list;

 MusicsSuccess({required this.list});
}

class MusicsLoading extends MusicsInitial{}

class MusicsError extends MusicsInitial{}

@collection
class MusicModel extends MusicsInitial{
 Id id = Isar.autoIncrement;
 late String albumArt;
 @Index(type: IndexType.value)
 late String title;
 late String subtitle;
 late String route;
}
