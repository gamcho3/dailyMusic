import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/common/domains/music_model.dart';

class IsarSingleton {
  static final IsarSingleton _instance = IsarSingleton._internal();
  late final Future<Isar> _isarInstanceFuture;

  IsarSingleton._internal() {
    _isarInstanceFuture = _initIsar();
  }

  static IsarSingleton get instance => _instance;

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [MusicModelSchema],
      directory: dir.path,
    );
    return isar;
  }

  Future<Isar> get isar => _isarInstanceFuture;
}
