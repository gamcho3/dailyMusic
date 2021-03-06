import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../playlist/model/music_files.dart';
import '../playlist/model/playList.dart';

class PlayListDatabase {
  static final PlayListDatabase instance = PlayListDatabase._init();
  static Database? _database;

  PlayListDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('musicList.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(path);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = "INTEGER NOT NULL";

//table 생성
    await db.execute('''
CREATE TABLE $tablePlayLists (
  ${PlayListFields.id} $idType,
  ${PlayListFields.content} $textType,
  ${PlayListFields.title} $textType,
  ${PlayListFields.imgUrl} $textType
)
''');
    await db.execute('''
CREATE TABLE $tableMusicFiles (
  ${MusicFilesFields.id} $idType,
  ${MusicFilesFields.imgUrl} $textType,
  ${MusicFilesFields.title} $textType,
  ${MusicFilesFields.filePath} $textType,
  ${MusicFilesFields.cardNum} $intType
)
''');
  }

  Future<MusicFiles> insertMusicFile(MusicFiles file) async {
    final db = await instance.database;
    final id = await db.insert(tableMusicFiles, file.toJson());
    return file.copy(id: id);
  }

  Future<List<MusicFiles>> readFiles(int cardNum) async {
    final db = await instance.database;
    final maps = await db.query(tableMusicFiles,
        columns: MusicFilesFields.values,
        where: '${MusicFilesFields.cardNum} = ?',
        whereArgs: [cardNum]);
    print(maps);
    if (maps.isNotEmpty) {
      List<MusicFiles> result = maps.map((e) {
        return MusicFiles.fromJson(e);
      }).toList();
      return result;
    } else {
      throw Exception('ID $cardNum not found');
    }
  }

  Future<PlayList> create(PlayList list) async {
    final db = await instance.database;
    final id = await db.insert(tablePlayLists, list.toJson());
    return list.copy(id: id);
  }

  Future<PlayList> readPlayList(int id) async {
    final db = await instance.database;
    final maps = await db.query(tablePlayLists,
        columns: PlayListFields.values,
        where: '${PlayListFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return PlayList.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<PlayList>> readAllLists() async {
    final db = await instance.database;
    const orderBy = '${PlayListFields.id} ASC';
    // final result =
    //     await db.query('SELECT * FROM $tablePlayLists ODER BY $orderBy');
    final result = await db.query(tablePlayLists, orderBy: orderBy);
    // final result = await db.query(tablePlayLists, orderBy: oerderBy);
    return result.map((json) => PlayList.fromJson(json)).toList();
  }

  Future<int> update(PlayList list) async {
    final db = await instance.database;
    return db.update(tablePlayLists, list.toJson(),
        where: '${PlayListFields.id} = ?', whereArgs: [list.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tablePlayLists,
        where: '${PlayListFields.id} = ?', whereArgs: [id]);
  }

  Future deleteMusics(int musicNum) async {
    final db = await instance.database;
    return await db.delete(tableMusicFiles,
        where: '${MusicFilesFields.cardNum} = ?', whereArgs: [musicNum]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
