import 'package:flutter/material.dart';

import '../widgets/pages.dart';
import '../services/database_helper.dart';
import '../custom/custom_tile.dart';
import '../screens/manga_info_screen.dart';
import '../models/home_manga_module.dart';

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  List<Map<String, Object>> chapters = [];
  List<Map<String, Object>> mangas = [];

  Future? _chapterFuture;
  Future? _mangaFuture;

  @override
  void initState() {
    super.initState();
    _chapterFuture = getChapters();
    _mangaFuture = getMangas();
  }

  getChapters() async {
    final _chapterData = await DatabaseHelper.db.getChapters();
    return _chapterData;
  }

  removeChapter(String title, String chapterTitle) {
    try {
      DatabaseHelper.db.deleteChapter(title, chapterTitle);
      chapters.removeWhere((item) =>
          item.containsValue(title) && item.containsValue(chapterTitle));

      setState(() {
        _chapterFuture = getChapters();
      });
    } catch (err) {
      print(err);
    }
  }

  getMangas() async {
    final _mangaData = await DatabaseHelper.db.getMangas();
    return _mangaData;
  }

  removeManga(String title) {
    try {
      DatabaseHelper.db.deleteManga(title);
      mangas.removeWhere((element) => element.containsValue(title));
      setState(() {
        _mangaFuture = getMangas();
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> refreshManga() async {
    final _mangaData = await DatabaseHelper.db.getMangas();
    setState(() {
      _mangaFuture = Future.value(_mangaData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookmarks",
            style: Theme.of(context).textTheme.headline3,
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(
                text: "Manga",
              ),
              Tab(
                text: "Chapters",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            (() {
              return FutureBuilder(
                future: _mangaFuture,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.waiting:
                      return Container();
                    case ConnectionState.active:
                      return Container();
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        mangas = List<Map<String, Object>>.from(snapshot.data);
                      }
                      return (() {
                        if (mangas.isEmpty) {
                          return Center(
                            child: Text(
                              "Your Manga list is empty.",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: mangas.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MangaInfo(MangaModule(
                                      idx: 0,
                                      title: mangas[index]["title"].toString(),
                                      chapter:
                                          mangas[index]["chapter"].toString(),
                                      author:
                                          mangas[index]["author"].toString(),
                                      rating:
                                          mangas[index]["rating"].toString(),
                                      synopsis:
                                          mangas[index]["synopsis"].toString(),
                                      uploadedDate: mangas[index]
                                              ["uploadedDate"]
                                          .toString(),
                                      img: mangas[index]["img"].toString(),
                                      src: mangas[index]["src"].toString(),
                                      views: mangas[index]["views"].toString(),
                                      timeStamp: 0,
                                    )),
                                  ),
                                ),
                                child: CustomListItemTwo(
                                  author: mangas[index]["author"].toString(),
                                  latestChapter:
                                      mangas[index]["chapter"].toString(),
                                  publishDate:
                                      mangas[index]["uploadedDate"].toString(),
                                  synopsis:
                                      mangas[index]["synopsis"].toString(),
                                  thumbnail: Image.network(
                                    mangas[index]["img"].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                  title: mangas[index]["title"].toString(),
                                  isFavorite: GestureDetector(
                                    child: const Icon(
                                      Icons.close,
                                    ),
                                    onTap: () => removeManga(
                                      mangas[index]["title"].toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }());
                  }
                },
              );
            }()),
            (() {
              return FutureBuilder(
                future: _chapterFuture,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.waiting:
                      return Container();
                    case ConnectionState.active:
                      return Container();
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        chapters =
                            List<Map<String, Object>>.from(snapshot.data);
                      }
                      return (() {
                        if (chapters.isEmpty) {
                          return Center(
                            child: Text(
                              "Your Chapters list is empty.",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: ListView(
                              shrinkWrap: true,
                              children: chapters
                                  .map<Widget>(
                                    (e) => GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          _createRoute(
                                              e["chapterLink"].toString())),
                                      child: ListTile(
                                        title: RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: e['chapterTitle']
                                                        .toString() +
                                                    " From ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              TextSpan(
                                                text: e['title'].toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              )
                                            ],
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: const Icon(
                                            Icons.close,
                                          ),
                                          onTap: () {
                                            removeChapter(e['title'].toString(),
                                                e['chapterTitle'].toString());
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        }
                      }());
                  }
                },
              );
              // return Container(
              //   child: const Center(
              //     child: Text(
              //       "Chapters",
              //       style: TextStyle(
              //         color: Color(0xFFFFFFFF),
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // );
            }())
          ],
        ),
      ),
    );
  }
}

Route _createRoute(String manga) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Pages(manga),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
