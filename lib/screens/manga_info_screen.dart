import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/home_manga_module.dart';
import '../models/manga_info_module.dart';
import '../utils/constants.dart';
import '../services/data_source.dart';
import '../custom/star_rating.dart';
import '../widgets/chapters.dart';
import '../models/bookmarks_module.dart';
import '../services/database_helper.dart';

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
  Map<String, Object?>? mangaObj;
  FavoriteManga? favManga;
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

  deleteMangaFromDatabase(String title) {
    favManga = null;
    favManga = FavoriteManga(
      id: int.parse(mangaObj?.values.first.toString() ?? "0"),
      title: mangaObj?.values.elementAt(1).toString() ?? "",
      img: mangaObj?.values.elementAt(3).toString() ?? "",
      mangaLink: mangaObj?.values.elementAt(4).toString() ?? "",
      synopsis: mangaObj?.values.elementAt(5).toString() ?? "",
      views: mangaObj?.values.elementAt(6).toString() ?? "",
      isFavorite: true,
    );
    DatabaseHelper.db.deleteManga(title);
    favManga = null;
  }

  addMangaToDatabase(
    String title,
    String latestChapter,
    String img,
    String mangaLink,
    String synopsis,
    String views,
    String uploadedDate,
    String authors,
    String rating,
  ) {
    int timeStmap = DateTime.now().millisecondsSinceEpoch;
    var addManga = FavoriteManga(
      id: timeStmap,
      title: title,
      chapter: latestChapter,
      img: img,
      mangaLink: mangaLink,
      synopsis: synopsis,
      views: views,
      author: authors,
      rating: rating,
      uploadedDate: uploadedDate,
      isFavorite: true,
    );
    DatabaseHelper.db.insertManga(addManga);
    favManga = addManga;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: manga.title,
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              manga.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2,
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
                    if (snapshot.hasData) {
                      mangaObj = Map<String, Object?>.from(snapshot.data?[0]);

                      favManga = FavoriteManga(
                        id: int.parse(mangaObj?.values.first.toString() ?? "0"),
                        title: mangaObj?.values.elementAt(1).toString() ?? "",
                        img: mangaObj?.values.elementAt(3).toString() ?? "",
                        mangaLink:
                            mangaObj?.values.elementAt(4).toString() ?? "",
                        synopsis:
                            mangaObj?.values.elementAt(5).toString() ?? "",
                        views: mangaObj?.values.elementAt(6).toString() ?? "",
                        isFavorite: true,
                      );
                    }
                    return IconButton(
                      icon: (favManga == null)
                          ? const Icon(
                              Icons.bookmark_add_outlined,
                            )
                          : const Icon(
                              Icons.bookmark_added_sharp,
                            ),
                      onPressed: () {
                        setState(() {
                          if (favManga == null) {
                            addMangaToDatabase(
                              manga.title,
                              manga.chapter,
                              manga.img,
                              manga.src,
                              manga.synopsis,
                              manga.views,
                              manga.uploadedDate,
                              manga.author,
                              manga.rating,
                            );
                            print("Added");
                          } else {
                            print("delete");

                            deleteMangaFromDatabase(manga.title);
                          }
                        });
                      },
                      iconSize: 27.0,
                      enableFeedback: true,
                      splashRadius: 15.0,
                    );
                }
              }),
        ],
      ),
      body: FutureBuilder<MangaInfoModule>(
        future: DataSource.getMangaInfo(manga.src),
        builder: (_, AsyncSnapshot<MangaInfoModule> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return (() {
              MangaInfoModule mangaInfo = snapshot.data!;
              final parentHeight = MediaQuery.of(context).size.height;
              final appBarHeight = parentHeight / 2.5;
              final thumbHeight = appBarHeight / 1.5;
              var textTheme = Theme.of(context).textTheme;

              const int maxLines = 3;

              return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Image.network(
                                    Constant.mangaInfoBackgroundWallpaper,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 170,
                                  width:
                                      MediaQuery.of(context).size.width / 1.75,
                                  child: Text(
                                    mangaInfo.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 10,
                                  child: Image.network(
                                    mangaInfo.img,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 150,
                                  ),
                                ),
                                Positioned(
                                  top: 200,
                                  left: 200,
                                  width:
                                      MediaQuery.of(context).size.width / 1.75,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.remove_red_eye,
                                    ),
                                    title: Transform.translate(
                                      child: Text(
                                        mangaInfo.views,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      offset: const Offset(-25, 0),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 240,
                                  left: 210,
                                  width:
                                      MediaQuery.of(context).size.width / 1.75,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: mangaInfo.rating != ''
                                        ? StarRating(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            rating:
                                                double.parse(mangaInfo.rating),
                                            starCount: 5,
                                          )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            height: 50.0,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: mangaInfo.genres
                                  .map<Widget>(
                                    (g) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Chip(
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                        label: Text(
                                          g.genre,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            child: Text(
                              "Synopsis: ",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              mangaInfo.synopsis,
                              style: TextStyle(
                                  fontFamily: Constant.fontRegular,
                                  color: Colors.grey[500]),
                              maxLines: null,
                            ),
                          ),
                          (() {
                            if (mangaInfo.authors.isNotEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Author(s) -',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          mangaInfo.authors
                                              .map<String>((e) => e.authorName)
                                              .join(', '),
                                          style: TextStyle(
                                              fontFamily: Constant.fontRegular,
                                              color: Colors.grey[500]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                            // your code here
                          }()),
                          (() {
                            if (mangaInfo.status.isNotEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: FractionalOffset.centerLeft,
                                child: Wrap(
                                  children: <Widget>[
                                    Text(
                                      'Status -',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        mangaInfo.status,
                                        style: TextStyle(
                                            fontFamily: Constant.fontRegular,
                                            color: Colors.grey[500]),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }()),
                          (() {
                            if (mangaInfo.lastUpdated.isNotEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Last Updated -',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        mangaInfo.lastUpdated,
                                        style: TextStyle(
                                            fontFamily: Constant.fontRegular,
                                            color: Colors.grey[500]),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }()),
                          (() {
                            if (mangaInfo.alt.isNotEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: FractionalOffset.centerLeft,
                                child: Wrap(
                                  children: <Widget>[
                                    Text(
                                      'Alternate Name(s) -',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            mangaInfo.alt,
                                            style: TextStyle(
                                                fontFamily:
                                                    Constant.fontRegular,
                                                color: Colors.grey[500]),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }()),
                          const SizedBox(
                            height: 57,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  elevation: 2,
                  onPressed: () =>
                      Navigator.of(context).push(_createRoute(mangaInfo)),
                  label: Text("Start reading",
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.button),
                ),
              );
            }());
          }
        },
      ),
    );
  }
}

Route _createRoute(MangaInfoModule manga) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ChaptersDetails(manga),
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
