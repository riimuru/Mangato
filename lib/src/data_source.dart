import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/home_manga_module.dart';
import '../models/manga_info_module.dart';
import '../models/manga_search_module.dart';
import '../utils/constants.dart';

class DataSource {
  static Future<List<MangaModule>> getLatestManga() async {
    var url = Uri.parse(Constant.mainUrl + Constant.mangaListPath);
    var data = await http.get(url);

    var jsonData = json.decode(data.body)[0]["data"];

    List<MangaModule> mangas = [];
    for (var item in jsonData) {
      MangaModule manga = MangaModule(
        idx: item["index"],
        title: item["title"],
        chapter: item["chapter"],
        synopsis: item["synopsis"],
        src: item["src"],
        img: item["img"],
        views: item["views"],
        author: item["authors"],
        rating: item["rating"],
        uploadedDate: item["uploadedDate"],
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      );

      mangas.add(manga);
    }
    return mangas;
  }

  static Future<List<MangaModule>> getPopularManga() async {
    try {
      var url = Uri.parse(Constant.mainUrl +
          Constant.mangaListPath +
          Constant.popularMangaQuery);
      var data = await http.get(url);

      var jsonData = json.decode(data.body)[0]["data"];

      List<MangaModule> mangas = [];
      for (var item in jsonData) {
        MangaModule manga = MangaModule(
          idx: item["index"],
          title: item["title"],
          chapter: item["chapter"],
          synopsis: item["synopsis"],
          src: item["src"],
          img: item["img"],
          views: item["views"],
          author: item["authors"],
          rating: item["rating"],
          uploadedDate: item["uploadedDate"],
          timeStamp: DateTime.now().millisecondsSinceEpoch,
        );

        mangas.add(manga);
      }
      return mangas;
    } catch (err) {
      List<MangaModule> mangas = [
        MangaModule(
          idx: 1,
          title: "some error occured.",
          chapter: "some error occured.",
          synopsis: "some error occured.",
          src: "some error occured.",
          img: "some error occured.",
          views: "some error occured.",
          timeStamp: DateTime.now().millisecondsSinceEpoch,
        ),
      ];
      return mangas;
    }
  }

  static Future<MangaInfoModule> getMangaInfo(String src) async {
    var headers = {
      "url": src,
    };

    var url = Uri.parse(Constant.mainUrl + Constant.mangaInfoPath);
    var data = await http.get(url, headers: headers);

    var jsonData = json.decode(data.body)[0];

    final title = jsonData["title"];
    final img = jsonData["img"];
    final alt = jsonData["alt"];
    final status = jsonData["status"];
    final lastUpdated = jsonData["lastUpdated"];
    final views = jsonData["views"];
    final synopsis = jsonData["synopsis"];
    final rating = jsonData["rating"];
    final totalVotes = jsonData["totalVotes"];
    List<Authors> authors = [];
    for (var data in jsonData["authors"]) {
      Authors author = Authors(
        authorName: data["authorName"],
        authorLink: data["authorLink"],
      );
      authors.add(author);
    }

    List<Genres> genres = [];
    for (var data in jsonData["genres"]) {
      Genres genre = Genres(
        genre: data["genre"],
        genreLink: data["genreLink"],
      );
      genres.add(genre);
    }

    List<Chapters> chapters = [];
    for (var data in jsonData["chapters"]) {
      Chapters chapter = Chapters(
        chapterTitle: data["chapterTitle"],
        chapterViews: data["chapterViews"],
        uploadedDate: data["uploadedDate"],
        chapterLink: data["chapterLink"],
      );
      chapters.add(chapter);
    }

    MangaInfoModule manga = MangaInfoModule(
      title: title,
      synopsis: synopsis,
      alt: alt,
      lastUpdated: lastUpdated,
      rating: rating,
      totalVoted: totalVotes,
      status: status,
      genres: genres,
      authors: authors,
      img: img,
      src: src,
      views: views,
      chapters: chapters,
      mangaLink: src,
    );

    return manga;
  }

  static Future<SearchModule> getResults(String query) async {
    var url = Uri.parse('${Constant.mainUrl}${Constant.searchPath}$query');

    var data = await http.get(url);

    var jsonData = json.decode(data.body)[0];

    var totalStoriesFound = jsonData["totalStoriesFound"].toString();
    var totalPages = jsonData["totalPages"].toString();

    List<SearchedChapters> results = [];
    for (var data in jsonData["data"]) {
      SearchedChapters result = SearchedChapters(
        title: data["title"],
        chapterTitle: data["chapter"],
        authors: data["authors"],
        updatedDate: data["uploadedDate"],
        views: data["views"],
        img: data["img"],
        src: data["src"],
        rating: data["rating"],
        synopsis: data["synopsis"],
      );
      results.add(result);
    }
    SearchModule searchResult = SearchModule(
      query: query,
      mangas: results,
    );
    return searchResult;
  }

  static Future<List<ChapterPages>> getChapterPages(String chapterUrl) async {
    var headers = {
      "url": chapterUrl,
    };
    var url = Uri.parse(Constant.mainUrl + Constant.chaptersPath);

    var data = await http.get(url, headers: headers);

    var jsonData = json.decode(data.body);

    List<ChapterPages> pages = [];

    for (var data in jsonData) {
      ChapterPages page = ChapterPages(
        chapterPageTitle: data["pageTitle"],
        img: data["img"],
      );
      pages.add(page);
    }

    return pages;
  }

  static Future<bool> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
