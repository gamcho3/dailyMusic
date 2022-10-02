import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/music_files.dart';
import '../models/playList.dart';
import '../models/temp_musicList.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('musicList.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('sqflite path : $path');
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
}

class LocalDataSource {
  //음악 db에 넣기
  Future<MusicFiles> insertMusicFile(MusicFiles file) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert(tableMusicFiles, file.toJson());
    return file.copy(id: id);
  }

  //음악 리스트 불러오기
  Future<List<MusicFiles>> readFiles(int? cardNum) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(tableMusicFiles,
        columns: MusicFilesFields.values,
        where: '${MusicFilesFields.cardNum} = ?',
        whereArgs: [cardNum]);

    if (maps.isNotEmpty) {
      List<MusicFiles> result = maps.map((e) {
        return MusicFiles.fromJson(e);
      }).toList();
      return result;
    } else {
      throw Exception('ID $cardNum not found');
    }
  }

  //플레이 리스트 만들기
  Future<PlayList> create(PlayList list) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert(tablePlayLists, list.toJson());
    return list.copy(id: id);
  }

  //플레이리스트 읽기
  Future<PlayList> readPlayList(int id) async {
    final db = await DatabaseHelper.instance.database;
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

  //모든 플레이리스트 불러오기
  Future<List<PlayList>> readAllLists() async {
    final db = await DatabaseHelper.instance.database;
    const orderBy = '${PlayListFields.id} ASC';
    // final result =
    //     await db.query('SELECT * FROM $tablePlayLists ODER BY $orderBy');
    final result = await db.query(tablePlayLists, orderBy: orderBy);
    // final result = await db.query(tablePlayLists, orderBy: oerderBy);
    return result.map((json) => PlayList.fromJson(json)).toList();
  }

  Future<int> updateCard(PlayList list) async {
    final db = await DatabaseHelper.instance.database;
    return db.update(tablePlayLists, list.toJson(),
        where: '${PlayListFields.id} = ?', whereArgs: [list.id]);
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(tablePlayLists,
        where: '${PlayListFields.id} = ?', whereArgs: [id]);
  }

  Future deleteAllMusics(int musicNum) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(tableMusicFiles,
        where: '${MusicFilesFields.cardNum} = ?', whereArgs: [musicNum]);
  }

  Future deleteMusic(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(tableMusicFiles,
        where: '${MusicFilesFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await DatabaseHelper.instance.database;
    db.close();
  }

  Future<List<TempMusicList>> getTempMusicList() async {
    var postBox = Hive.box<TempMusicList>('tempMusicList');
    return postBox.values.toList();
  }

  Future<void> addTempPlayList(TempMusicList musicList) async {
    final box = Hive.box<TempMusicList>('tempMusicList');
    box.add(musicList);
  }

  Future deleteTempMusicList(TempMusicList musicList) async {
    var postBox = Hive.box<TempMusicList>('tempMusicList');
    postBox.delete(musicList.key);
  }

  Future deleteTempMusicListAll() async {
    var postBox = Hive.box<TempMusicList>('tempMusicList');
    postBox.clear();
  }
}
