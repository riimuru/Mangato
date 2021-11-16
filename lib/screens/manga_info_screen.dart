import 'package:MangaApp/models/bookmarks_module.dart';
import 'package:MangaApp/src/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/home_manga_module.dart';
import '../widgets/manga_info_widget.dart';
import '../models/manga_info_module.dart';
import '../utils/constants.dart';
import '../src/data_source.dart';

class MangaInfo extends StatefulWidget {
  final MangaModule manga;

  const MangaInfo(this.manga);

  @override
  State<StatefulWidget> createState() => MangaInfoState(this.manga);
}

class MangaInfoState extends State<MangaInfo>
    with SingleTickerProviderStateMixin {
  final MangaModule manga;
  Future? _mangaFuture;
  Map<String, Object> mangaObj = {};
  MangaInfoState(this.manga);

  late TabController _controller;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
    _mangaFuture = getMangaBytitle();
  }

  getMangaBytitle() async {
    final _mangaData = await DatabaseHelper.db.getMangaByTitle(manga.title);
    return _mangaData;
  }

  deleteMangaFromDatabase() {
    DatabaseHelper.db.deleteManga(manga.title);
    mangaObj.clear();
  }

  addMangaToDatabase(String title, String img, String mangaLink,
      String synopsis, String views) {
    var addManga = FavoriteManga(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      img: img,
      mangaLink: mangaLink,
      synopsis: synopsis,
      views: views,
      isFavorite: true,
    );
    DatabaseHelper.db.insertManga(addManga);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
        title: Hero(
          tag: manga.title,
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              manga.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: Constant.fontRegular,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          FutureBuilder(
              future: _mangaFuture,
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.waiting:
                    return Container();
                  case ConnectionState.active:
                    return Container();
                  case ConnectionState.done:
                    if (snapshot.data != null) {
                      mangaObj = Map<String, Object>.from(snapshot.data);
                      print(mangaObj);
                    }
                    return IconButton(
                      icon: const Icon(
                        Icons.bookmark_add_sharp,
                        color: white,
                      ),
                      onPressed: () => addMangaToDatabase(manga.title,
                          manga.img, manga.src, manga.synopsis, manga.views),
                      iconSize: 27.0,
                      enableFeedback: true,
                      splashRadius: 15.0,
                    );
                }
              }),
        ],
      ),
      body: FutureBuilder(
        future: DataSource.getMangaInfo(manga.src),
        builder: (_, AsyncSnapshot<MangaInfoModule> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          } else {
            return mangaInfoWidget(manga: snapshot.data!, context: _);
          }
        },
      ),
    );
  }
}
