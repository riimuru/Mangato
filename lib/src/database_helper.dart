import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/bookmarks_module.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  _initDb() async {
    return openDatabase(
      // Set  path to the database. Note: Using the `join` function from the
      // `path`  is best practice to ensure the path is correctly
      // constructed  each platform.
      join(await getDatabasesPath(), 'manga_database.db'),
      // When  database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run  CREATE TABLE statement on the database.
        return db.execute(
          '''
          CREATE TABLE chapters(
            id INTEGER PRIMARY KEY, title TEXT, alt Text, img TEXT, chapterTitle TEXT, chapterViews TEXT, chapterLink TEXT)
            
            ''',
        );
      },
      // Set  version. This executes the onCreate function and provides a
      // path  perform database upgrades and downgrades.
      version: 1,
    );
  }

  insertChapter(FavoriteChapters chapter) async {
    // Get  reference to the database.
    final db = await database;

    // Insert  Dog into the correct table. You might also specify the
    // `conflictAlgorithm`  use in case the same dog is inserted twice.
    //
    //   case, replace any previous data.
    var res = await db!.insert(
      'chapters',
      chapter.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  // //   that retrieves all the dogs from the dogs table.
  // Future<<FavoriteChapters>> queryAll() async {
  //   //   reference to the database.
  //   final  = await database;

  //   //   table for all The Dogs.
  //   final <Map<String, dynamic>> maps = await db.query('dogs');

  //   //   List<Map<String, dynamic> into a List<Dog>.
  //   return .generate(maps.length, (i) {
  //     return (
  //       id: [i]['id'],
  //       name: [i]['name'],
  //       age: [i]['age'],
  //     );
  //   });
  // }
  updateChapter(FavoriteChapters chapter) async {
    // Get  reference to the database.
    final db = await database;

    // Update  given Dog.
    await db!.update(
      'chapters',
      chapter.toMap(),
      // Ensure  the Dog has a matching id.
      where: 'id = ?',
      // Pass  Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [chapter.id],
    );
  }

  deleteChapter(String title, String chapterTitle) async {
    // Get  reference to the database.
    final db = await database;

    // Remove  Dog from the database.
    await db!.delete(
      'chapters',
      // Use  `where` clause to delete a specific dog.
      where: 'title = ? AND chapterTitle = ?',
      // Pass  Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [title, chapterTitle],
    );
  }

  Future<dynamic> getChapters() async {
    final db = await database;

    var res = await db!.query(
      "chapters",
    );
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? resMap : Null;
    }
  }

  Future<dynamic> getChaptersByTitle(String title) async {
    final db = await database;

    var res = await db!.query(
      "chapters",
      where: "title = ?",
      whereArgs: [title],
    );
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}
