import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/recent_chapters_widget.dart';
import '../src/data_source.dart';
import '../widgets/popular_manga_widget.dart';
import '../screens/favorite_screen.dart';
import '../screens/search_screen.dart';
import '../utils/constants.dart';
import './search_screen.dart';
import '../models/home_manga_module.dart';
import '../src/database_helper.dart';

class ShonenJumpState extends State<ShonenJump> {
  ShonenJumpState({Key? key}) : super();
  Future? recentMangaFuture;
  Future? popularMangaFuture;
  // refresh data every 15 minutes
  static const int minutes = 15;
  void openSearch() async {
    await showSearch(context: context, delegate: DataSearch());
  }

  @override
  void initState() {
    super.initState();
    recentMangaFuture = getMangas('R', 'recent_manga');
    popularMangaFuture = getMangas('P', 'popular_manga');
  }

  // ignore: non_constant_identifier_names
  getMangas(String TAG, String table) async {
    if (await getOfflineManga(table) != null) {
      List<MangaModule> res = await getOfflineManga(table) as List<MangaModule>;
      if (DateTime.fromMillisecondsSinceEpoch(res[0].timeStamp)
                  .add(const Duration(minutes: minutes))
                  .millisecondsSinceEpoch <
              DateTime.now().millisecondsSinceEpoch &&
          await DataSource.isConnectedToInternet() == true) {
        print('reseting data');
        var ress = (TAG == 'R')
            ? await DataSource.getLatestManga()
            : await DataSource.getPopularManga();
        await DatabaseHelper.db.clearTable(table);
        for (MangaModule manga in ress) {
          await DatabaseHelper.db.insertHomeManga(manga, table);
        }
        return ress;
      } else {
        print("Data is still usable");
        return res;
      }
    } else if (await DataSource.isConnectedToInternet() == true) {
      var res = (TAG == 'R')
          ? await DataSource.getLatestManga()
          : await DataSource.getPopularManga();
      for (MangaModule manga in res) {
        await DatabaseHelper.db.insertHomeManga(manga, table);
      }
      return res;
    } else {
      return null;
    }
  }

  getOfflineManga(String table) async {
    var res = await DatabaseHelper.db.getManga(table);
    return res;
  }

  // TODO: swipe to refresh
  refresh() async {}

  @override
  Widget build(context) {
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
                builder: (context) => Favorites(),
              ),
            ),
            iconSize: 27.0,
            enableFeedback: true,
            splashRadius: 15.0,
          )
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
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
                  future: recentMangaFuture,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int index) => recentChapterCard(
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
                    future: popularMangaFuture,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int index) => popularMangaCard(
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
      ),
    );
  }
}
