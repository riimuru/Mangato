import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/bookmarks_module.dart';

import '../services/database_helper.dart';

class DataProvider with ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper.db;
  FavoriteManga? manga;

  DataProvider() {
    if (db != null) {
      fetchAndSetData();
    }
  }

  FavoriteManga? get mangaM => manga;

  getMangaBytitle() async {
    final _mangaData = await DatabaseHelper.db.getMangaByTitle(manga!.title);
    return _mangaData;
  }

  addMangaToDatabase(
    String title,
    String latestChapter,
    String img,
    String mangaLink,
    String synopsis,
    String views,
    String uploadedDate,
    String authors,
    String rating,
  ) {
    int timeStmap = DateTime.now().millisecondsSinceEpoch;
    var addManga = FavoriteManga(
      id: timeStmap,
      title: title,
      chapter: latestChapter,
      img: img,
      mangaLink: mangaLink,
      synopsis: synopsis,
      views: views,
      author: authors,
      rating: rating,
      uploadedDate: uploadedDate,
      isFavorite: true,
    );
    DatabaseHelper.db.insertManga(addManga);
  }

  Future<void> fetchAndSetData() async {
    if (db != null) {
      final data = Map<String, Object?>.from(
          (await db.getMangaByTitle(manga!.title))[0]);
      manga = FavoriteManga(
        id: int.parse(data.values.first.toString()),
        title: data.values.elementAt(1).toString(),
        img: data.values.elementAt(3).toString(),
        mangaLink: data.values.elementAt(4).toString(),
        synopsis: data.values.elementAt(5).toString(),
        views: data.values.elementAt(6).toString(),
        isFavorite: true,
      );
    }
  }
}
