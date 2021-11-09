import 'package:flutter/material.dart';

import '../models/manga_info_module.dart';
import '../src/data_source.dart';
import '../utils/constants.dart';
import '../custom/star_rating.dart';
import './chapters.dart';

DataSource dataSource = DataSource();

Widget mangaInfoWidget({
  required MangaInfoModule manga,
  required BuildContext context,
}) {
  final parentHeight = MediaQuery.of(context).size.height;
  final appBarHeight = parentHeight / 2.5;
  final thumbHeight = appBarHeight / 1.5;
  var textTheme = Theme.of(context).textTheme;

  return Scaffold(
    backgroundColor: Colors.black12,
    body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
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
                      width: MediaQuery.of(context).size.width / 1.75,
                      child: Text(
                        manga.title,
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
                        manga.img,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 150,
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 155,
                      width: MediaQuery.of(context).size.width / 1.75,
                      child: ListTile(
                        leading: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        title: Transform.translate(
                          child: Text(
                            manga.views,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: Constant.fontRegular,
                            ),
                          ),
                          offset: const Offset(-25, 0),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 240,
                        left: 162,
                        width: MediaQuery.of(context).size.width / 1.75,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: manga.rating != ''
                              ? StarRating(
                                  color: Theme.of(context).primaryColor,
                                  rating: double.parse(manga.rating),
                                  starCount: 5,
                                )
                              : Container(),
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                height: 50.0,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: manga.genres
                      .map<Widget>(
                        (g) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            label: Text(
                              g.genre,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: Constant.fontMedium,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
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
                  style: TextStyle(
                    fontFamily: Constant.fontRegular,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  manga.synopsis,
                  style: TextStyle(
                      fontFamily: Constant.fontRegular,
                      color: Colors.grey[500]),
                ),
              ),
              (() {
                if (manga.authors.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Author(s) -',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            manga.authors
                                .map<String>((e) => e.authorName)
                                .join(', '),
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
                // your code here
              }()),
              (() {
                if (manga.status.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: FractionalOffset.centerLeft,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Status -',
                          style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            manga.status,
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
                if (manga.lastUpdated.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Last Updated -',
                          style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            manga.lastUpdated,
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
                if (manga.alt.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: FractionalOffset.centerLeft,
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          'Alternate Name(s) -',
                          style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: <Widget>[
                              Text(
                                manga.alt,
                                style: TextStyle(
                                    fontFamily: Constant.fontRegular,
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
                height: 55,
              )
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
      elevation: 2,
      onPressed: () => Navigator.of(context).push(_createRoute(manga)),
      label: Text(
        "Start reading",
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 20,
          fontFamily: Constant.fontRegular,
        ),
      ),
    ),
  );
  // return SingleChildScrollView(
  //   physics: const BouncingScrollPhysics(),
  //   child: Hero(
  //     tag: manga.img,
  //     child: Stack(
  //       children: <Widget>[
  //         Image.network(
  //           'https://wallpaperaccess.com/full/639663.jpg',
  //           height: 225,
  //           width: double.infinity,
  //           scale: 5.0,
  //           fit: BoxFit.cover,
  //         ),
  //         Container(
  //           height: parentHeight,
  //           decoration: BoxDecoration(
  //             color: Colors.black.withOpacity(0.1),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
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
