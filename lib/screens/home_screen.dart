import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/recent_chapters_widget.dart';
import '../src/data_source.dart';
import '../widgets/popular_manga_widget.dart';
import '../screens/favorite_screen.dart';
import '../screens/search_screen.dart';
import '../models/home_manga_module.dart';

var dataSource = new DataSource();

class MangaState extends State<Manga> {
  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
      appBar: AppBar(
        title: const Text('Shonen Jump'),
        backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => Search(),
              ),
            ),
            iconSize: 27.0,
            enableFeedback: true,
            splashRadius: 15.0,
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Color.fromRGBO(200, 0, 0, 1),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => Favorites(),
              ),
            ),
            iconSize: 27.0,
            enableFeedback: true,
            splashRadius: 15.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
              width: double.infinity,
              child: const Text(
                "Recent Chapters",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: FutureBuilder(
                future: dataSource.getLatestManga(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading..."),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, int index) => recentChapterCard(
                          item: snapshot.data[index], context: context),
                    );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
              width: double.infinity,
              child: const Text(
                "Popular Manga",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Wrap(
              // width: double.infinity,
              children: [
                FutureBuilder(
                  future: dataSource.getPopularManga(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int index) => popularMangaCard(
                            item: snapshot.data[index], context: context),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
