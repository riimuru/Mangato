import 'package:MangaApp/screens/favorite_screen.dart';
import 'package:flutter/material.dart';

import '../models/manga_info_module.dart';
import '../utils/constants.dart';
import './pages.dart';
import '../src/database_helper.dart';
import '../models/bookmarks_module.dart';

class ChaptersDetails extends StatefulWidget {
  final MangaInfoModule manga;

  const ChaptersDetails(this.manga);

  @override
  State<StatefulWidget> createState() => ChaptersDetailsState(this.manga);
}

class ChaptersDetailsState extends State<ChaptersDetails> {
  final MangaInfoModule manga;
  Future? _chaptersFuture;
  List<Map<String, Object>> chapters = [];

  ChaptersDetailsState(this.manga);

  @override
  void initState() {
    super.initState();
    _chaptersFuture = getChapters();
  }

  getChapters() async {
    final _chapterData = await DatabaseHelper.db.getChapters();
    return _chapterData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Hero(
          tag: "${manga.title} Chapters",
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              "${manga.title} Chapters",
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
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FutureBuilder(
                  future: _chaptersFuture,
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.waiting:
                        return Container();
                      case ConnectionState.active:
                        return Container();
                      case ConnectionState.done:
                        if (!chapters.isNotEmpty) {
                          chapters =
                              List<Map<String, Object>>.from(snapshot.data);
                        }
                        return Container(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: manga.chapters.map((c) {
                              bool isFavorite = false;
                              var map = chapters.asMap();
                              map.forEach((i, e) {
                                if (e['chapterTitle'] == c.chapterTitle &&
                                    e['title'] == manga.title) {
                                  print(c.chapterTitle);
                                  isFavorite = true;
                                  return;
                                } else {
                                  isFavorite = false;
                                }
                              });

                              return ListTile(
                                title: Text(
                                  c.chapterTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  c.chapterViews + " Views.",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                isThreeLine: true,
                                leading: null,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "Uploaded : " + c.uploadedDate,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                                    ),
                                    IconButton(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      alignment: Alignment.center,
                                      iconSize: 24,
                                      icon: isFavorite
                                          ? const Icon(Icons.star,
                                              color: Colors.white)
                                          : const Icon(
                                              Icons.star_border,
                                              color: Colors.white,
                                            ),
                                      onPressed: () {
                                        if (isFavorite) {
                                          isFavorite = false;
                                        } else {
                                          isFavorite = true;
                                          var addChapter = FavoriteChapters(
                                            id: DateTime.now()
                                                .millisecondsSinceEpoch,
                                            title: manga.title,
                                            alt: manga.alt,
                                            img: manga.img,
                                            chapterTitle: c.chapterTitle,
                                            chapterViews: c.chapterViews,
                                            chapterLink: c.chapterLink,
                                          );
                                          DatabaseHelper.db
                                              .insertChapter(addChapter);
                                        }
                                      },
                                    )
                                  ],
                                ),
                                onTap: () => Navigator.of(context)
                                    .push(_createRoute(c.chapterLink)),
                              );
                            }).toList(),
                          ),
                        );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
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