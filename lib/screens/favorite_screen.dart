import 'package:flutter/material.dart';
import '../src/database_helper.dart';

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

  removeItem(String title, String chapterTitle) {
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
                      if (snapshot.data != null) {
                        chapters =
                            List<Map<String, Object>>.from(snapshot.data);
                      }
                      return (() {
                        if (chapters.isEmpty) {
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
                        } else {
                          return SingleChildScrollView(
                            child: ListView(
                              shrinkWrap: true,
                              children: chapters
                                  .map<Widget>((e) => ListTile(
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
                                            removeItem(e['title'].toString(),
                                                e['chapterTitle'].toString());
                                          },
                                        ),
                                      ))
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
