import 'package:flutter/material.dart';

import '../models/manga_info_module.dart';
import '../utils/constants.dart';
import './pages.dart';

class ChaptersDetails extends StatefulWidget {
  final MangaInfoModule manga;

  const ChaptersDetails(this.manga);

  @override
  State<StatefulWidget> createState() => ChaptersDetailsState(this.manga);
}

class ChaptersDetailsState extends State<ChaptersDetails> {
  final MangaInfoModule manga;

  ChaptersDetailsState(this.manga);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white10,
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
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: manga.chapters
                        .map<Widget>((c) => ListTile(
                              title: Text(
                                c.chapterTitle,
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
                              trailing: Text(
                                "Uploaded : " + c.uploadedDate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () => Navigator.of(context)
                                  .push(_createRoute(c.chapterLink)),
                            ))
                        .toList(),
                  ),
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
