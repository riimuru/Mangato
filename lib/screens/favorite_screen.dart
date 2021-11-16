import 'package:flutter/material.dart';
import '../widgets/pages.dart';
import '../src/database_helper.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
        appBar: AppBar(
          title: const Text("Bookmarks"),
          backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Manga",
            ),
            Tab(
              text: "Chapters",
            )
          ]),
        ),
        body: TabBarView(
          children: [
            Container(
              child: const Center(
                child: Text(
                  "Manga",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            (() {
              return FutureBuilder(
                future: _chapterFuture,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text(
                          "Chapters",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                          ),
                        ),
                      );
                    case ConnectionState.waiting:
                      return Container();
                    case ConnectionState.active:
                      return Container();
                    case ConnectionState.done:
                      if (snapshot.data != null) {
                        chapters =
                            List<Map<String, Object>>.from(snapshot.data);
                      }
                      return (() {
                        if (chapters.isEmpty) {
                          return const Center(
                            child: Text(
                              "Chapters",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                              ),
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
                                        title: Text(
                                          e['chapterTitle'].toString() +
                                              " From " +
                                              e['title'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: GestureDetector(
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
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
