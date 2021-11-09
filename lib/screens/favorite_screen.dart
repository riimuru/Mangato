import 'package:MangaApp/src/database_helper.dart';
import 'package:flutter/material.dart';
import '';

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  List<Map<String, Object>> chapters = [];

  Future? _chapterFuture;

  @override
  void initState() {
    super.initState();
    _chapterFuture = getChapters();
  }

  getChapters() async {
    final _chapterData = await DatabaseHelper.db.getChapters();
    return _chapterData;
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
                      return Container(
                        child: const Center(
                          child: Text(
                            "Chapters",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    case ConnectionState.waiting:
                      return Container();
                    case ConnectionState.active:
                      return Container();
                    case ConnectionState.done:
                      if (chapters.isNotEmpty) {
                        chapters =
                            List<Map<String, Object>>.from(snapshot.data);
                      }
                      return SingleChildScrollView(
                        child: ListView(
                          children: chapters
                              .map<Widget>((e) => ListTile(
                                    title: Text(
                                      e['chapterTitle'].toString() +
                                          " From " +
                                          e['title'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                  }
                  return Container();
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
