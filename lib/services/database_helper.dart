import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/bookmarks_module.dart';
import '../models/home_manga_module.dart';

class DatabaseHelper {
  DatabaseHelper();
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
    var databasePath = await getDatabasesPath();
    return openDatabase(
      // Set  path to the database. Note: Using the `join` function from the
      // `path`  is best practice to ensure the path is correctly
      // constructed  each platform.
      join(databasePath, 'manga_database.db'),
      // When  database is first created, create a table to store data.
      onCreate: (db, version) async {
        // Run  CREATE TABLE statement on the database.
        await db.execute(
            "CREATE TABLE IF NOT EXISTS manga_info(id INTEGER PRIMARY KEY, title INTEGER, synopsis TEXT, alt TEXT, status TEXT, lastUpdated TEXT, rating TEXT, totalVoted TEXT , genres TEXT, authors TEXT, img TEXT, views TEXT, src TEXT, chapters TEXT, mangaLink Text)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS recent_manga(idx INTEGER PRIMARY KEY, title TEXT, chapter TEXT, img TEXT, synopsis TEXT, views TEXT, src TEXT , uploadedDate TEXT, author TEXT, rating TEXT, timeStamp INTEGER)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS popular_manga(idx INTEGER PRIMARY KEY, title TEXT, chapter TEXT, img TEXT, synopsis TEXT, views TEXT, src TEXT , uploadedDate TEXT, author TEXT, rating TEXT, timeStamp INTEGER)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS manga(id INTEGER PRIMARY KEY, title TEXT,chapter TEXT ,img TEXT, src TEXT, synopsis TEXT, views TEXT, uploadedDate TEXT, author TEXT, rating TEXT)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS chapters(id INTEGER PRIMARY KEY, title TEXT, alt Text, img TEXT, chapterTitle TEXT, chapterViews TEXT, chapterLink TEXT)");
      },
      // Set  version. This executes the onCreate function and provides a
      // path  perform database upgrades and downgrades.
      version: 1,
    );
  }

  clearTable(String table) async {
    final db = await database;
    await db!.execute("DELETE FROM $table");
  }

  insertManga(FavoriteManga manga) async {
    final db = await database;
    await db!.insert(
      'manga',
      manga.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  insertChapter(FavoriteChapters chapter) async {
    // Get  reference to the database.
    final db = await database;

    // Insert  Chapter into the correct table. You might also specify the
    // `conflictAlgorithm`  use in case the same chapter is inserted twice.
    //
    //   case, replace any previous data.
    var res = await db!.insert(
      'chapters',
      chapter.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<List<FavoriteManga>> queryAllManga() async {
    final db = await database;

    final List<Map<String, Object?>> maps = await db!.query('manga');

    List<FavoriteManga> mangas = [];
    maps.map((e) {
      FavoriteManga manga = FavoriteManga(
        id: int.parse(e['id'].toString()),
        title: e['title'].toString(),
        img: e['img'].toString(),
        mangaLink: e['mangaLink'].toString(),
        synopsis: e['synopsis'].toString(),
        views: e['views'].toString(),
        isFavorite: e['isFavorite'].toString() == 'true',
      );
      mangas.add(manga);
    });
    return mangas;
  }

  //   that retrieves all the chapters from the chapters table.
  Future<List<FavoriteChapters>> queryAllChapters() async {
    //   reference to the database.
    final db = await database;

    //   table for all The Chapters.
    final List<Map<String, Object?>> maps = await db!.query('chapters');

    //   List<Map<String, Object?>> into a List<FavoriteChapters>.
    List<FavoriteChapters> chapters = [];
    maps.map((e) {
      FavoriteChapters chapter = FavoriteChapters(
        id: int.parse(e['id'].toString()),
        title: e['title'].toString(),
        alt: e['alt'].toString(),
        img: e['img'].toString(),
        chapterTitle: e['chapterTitle'].toString(),
        chapterViews: e['chapterViews'].toString(),
        chapterLink: e['chapterLink'].toString(),
        isFavorite: e['isFavorite'].toString() == 'true',
      );
      chapters.add(chapter);
    });
    return chapters;
  }

  updateManga(FavoriteManga manga) async {
    final db = await database;

    await db!.update(
      'manga',
      manga.toMap(),
      where: 'title = ?',
      whereArgs: [manga.title],
    );
  }

  updateChapter(FavoriteChapters chapter) async {
    final db = await database;

    await db!.update(
      'chapters',
      chapter.toMap(),
      where: 'title = ? AND chapterTitle = ?',
      whereArgs: [chapter.title, chapter.chapterTitle],
    );
  }

  deleteManga(String title) async {
    final db = await database;

    await db!.delete(
      'manga',
      where: 'title = ?',
      whereArgs: [title],
    );
    return false;
  }

  deleteChapter(String title, String chapterTitle) async {
    // Get  reference to the database.
    final db = await database;

    await db!.delete(
      'chapters',
      // Use  `where` clause to delete a specific chapter.
      where: 'title = ? AND chapterTitle = ?',
      // Pass chapter's title and manga title as a whereArg to prevent SQL injection.
      whereArgs: [title, chapterTitle],
    );
  }

  Future<dynamic> getMangas() async {
    final db = await database;

    var res = await db!.query(
      "manga",
    );
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? resMap : Null;
    }
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

  Future<dynamic> getMangaByTitle(String title) async {
    final db = await database;

    var res = await db!.query(
      'manga',
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

  Future<dynamic> getChaptersByMangaTitle(String title) async {
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

  //TODO: offline feature
  insertHomeManga(MangaModule manga, String table) async {
    final db = await database;
    var res = await db!.insert(
      table,
      manga.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<dynamic>? getManga(String table) async {
    final db = await database;
    List<MangaModule> mangas = [];
    var res = await db!.query(table);
    for (var e in res) {
      mangas.add(MangaModule(
        idx: int.parse(e['idx'].toString()),
        title: e['title'].toString(),
        img: e['img'].toString(),
        src: e['src'].toString(),
        views: e['views'].toString(),
        synopsis: e['synopsis'].toString(),
        author: e['author'].toString(),
        chapter: e['chapter'].toString(),
        rating: e['rating'].toString(),
        uploadedDate: e['uploadedDate'].toString(),
        timeStamp: int.parse(e['timeStamp'].toString()),
      ));
    }
    if (res.isEmpty) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? mangas : Null;
    }
  }
}
