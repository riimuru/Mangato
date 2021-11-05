import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shonen_jump/models/manga_authors_module.dart';
import 'package:shonen_jump/models/manga_chapters_module.dart';
import 'package:shonen_jump/models/manga_genres_module.dart';
import 'dart:convert';

import '../models/home_manga_module.dart';
import '../models/manga_info_module.dart';

class DataSource {
  Future<List<MangaModule>> getLatestManga() async {
    var url = Uri.parse("https://shonen-jump.herokuapp.com/manga_list");
    var data = await http.get(url);

    var jsonData = json.decode(data.body)[0]["data"];

    List<MangaModule> mangas = [];
    for (var item in jsonData) {
      MangaModule manga = MangaModule(
        index: item["index"],
        title: item["title"],
        chapter: item["chapter"],
        synopsis: item["synopsis"],
        src: item["src"],
        img: item["img"],
        views: item["views"],
      );

      mangas.add(manga);
    }
    return mangas;
  }

  Future<List<MangaModule>> getPopularManga() async {
    try {
      var url = Uri.parse(
          "https://shonen-jump.herokuapp.com/manga_list?type=topview");
      var data = await http.get(url);

      var jsonData = json.decode(data.body)[0]["data"];

      List<MangaModule> mangas = [];
      for (var item in jsonData) {
        MangaModule manga = MangaModule(
          index: item["index"],
          title: item["title"],
          chapter: item["chapter"],
          synopsis: item["synopsis"],
          src: item["src"],
          img: item["img"],
          views: item["views"],
        );

        mangas.add(manga);
      }
      return mangas;
    } catch (err) {
      List<MangaModule> mangas = [
        MangaModule(
          index: 1,
          title: "some error occured.",
          chapter: "some error occured.",
          synopsis: "some error occured.",
          src: "some error occured.",
          img: "some error occured.",
          views: "some error occured.",
        ),
      ];
      return mangas;
    }
  }

  Future<MangaInfoModule> getMangaInfo(String src) async {
    var headers = {
      "url": src,
    };

    var url = Uri.parse("https://shonen-jump.herokuapp.com/manga_info");
    var data = await http.get(url, headers: headers);

    var jsonData = json.decode(data.body)[0];

    final String title = jsonData["title"];
    final String img = jsonData["img"];
    final String alt = jsonData["alt"];
    final String status = jsonData["status"];
    final String lastUpdated = jsonData["updated"];
    final String views = jsonData["views"];
    final String synopsis = jsonData["synopsis"];

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
      status: status,
      genres: genres,
      authors: authors,
      img: img,
      src: src,
      views: views,
      chapters: chapters,
    );

    return manga;
  }
}
