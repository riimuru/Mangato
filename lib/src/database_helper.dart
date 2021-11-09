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
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'manga_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          '''
          CREATE TABLE chapters(
            id INTEGER PRIMARY KEY, title TEXT, alt Text, img TEXT, chapterTitle TEXT, chapterViews TEXT, chapterLink TEXT)
            
            ''',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  // Define a function that inserts dogs into the database
  insertChapter(FavoriteChapters chapter) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    var res = await db!.insert(
      'chapters',
      chapter.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  // // A method that retrieves all the dogs from the dogs table.
  // Future<List<FavoriteChapters>> queryAll() async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Query the table for all The Dogs.
  //   final List<Map<String, dynamic>> maps = await db.query('dogs');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return Dog(
  //       id: maps[i]['id'],
  //       name: maps[i]['name'],
  //       age: maps[i]['age'],
  //     );
  //   });
  // }

  updateChapter(FavoriteChapters chapter) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db!.update(
      'chapters',
      chapter.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [chapter.id],
    );
  }

  deleteChapter(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db!.delete(
      'chapters',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<dynamic> getChapters() async {
    final db = await database;

    var res = await db!.query("chapters");
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}
