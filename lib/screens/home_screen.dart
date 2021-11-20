import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/recent_chapters_widget.dart';
import '../src/data_source.dart';
import '../widgets/popular_manga_widget.dart';
import '../screens/favorite_screen.dart';
import '../screens/search_screen.dart';
import '../utils/constants.dart';
import './search_screen.dart';

class ShonenJumpState extends State<ShonenJump> {
  ShonenJumpState({Key? key}) : super();

  void openSearch() async {
    await showSearch(context: context, delegate: DataSearch());
  }

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
              color: white,
            ),
            onPressed: () => openSearch(),
            iconSize: 27.0,
            enableFeedback: true,
            splashRadius: 15.0,
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark_border_outlined,
              color: Colors.white,
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
                  color: white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: FutureBuilder(
                future: DataSource.getLatestManga(),
                builder: (_, AsyncSnapshot snapshot) {
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
                  color: white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Wrap(
              // width: double.infinity,
              children: [
                FutureBuilder(
                  future: DataSource.getPopularManga(),
                  builder: (_, AsyncSnapshot snapshot) {
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
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int index) => popularMangaCard(
                            manga: snapshot.data[index], context: context),
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
