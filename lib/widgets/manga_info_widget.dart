import 'package:flutter/material.dart';

import '../models/manga_info_module.dart';
import '../src/data_source.dart';
import '../constants.dart';
import '../widgets/poster.dart';
import '../widgets/synposis.dart';

DataSource dataSource = DataSource();

Widget mangaInfoWidget({
  required MangaInfoModule manga,
  required BuildContext context,
}) {
  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return manga.genres.map((genres) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(genres.genre),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  var textTheme = Theme.of(context).textTheme;

  var movieInformation = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        manga.title,
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 8.0),
      SizedBox(height: 12.0),
      Row(children: _buildCategoryChips(textTheme)),
    ],
  );

  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: <Widget>[
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 140.0),
            ),
            Positioned(
              bottom: 0.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Poster(
                    manga.img,
                    height: 180.0,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(child: movieInformation),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Storyline(manga.synopsis),
        ),
        // Container(
        //   width: double.infinity,
        //   child: Center(
        //     child: Row(
        //       children: [
        //         Flexible(
        //           child: Container(
        //             child: Image.network(manga.img),
        //           ),
        //         ),
        //         Flexible(
        //           child: Column(
        //             children: [
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Text(
        //                   manga.title,
        //                   style: const TextStyle(
        //                     color: white,
        //                     fontSize: 35,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Text(
        //                   manga.alt,
        //                   style: const TextStyle(
        //                     color: white,
        //                     fontSize: 15,
        //                   ),
        //                 ),
        //               ),
        //               const SizedBox(
        //                 height: 30,
        //               ),
        //               Container(
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Row(
        //                   children: [
        //                     Container(
        //                       child: const Text(
        //                         "Author(s): ",
        //                         style: TextStyle(
        //                           color: white,
        //                           fontSize: 20,
        //                         ),
        //                       ),
        //                     ),
        //                     Expanded(
        //                       child: ListView.builder(
        //                           shrinkWrap: true,
        //                           physics:
        //                               const NeverScrollableScrollPhysics(),
        //                           itemCount: manga.authors.length,
        //                           itemBuilder: (_, index) {
        //                             return Text(
        //                               manga.authors[index].authorName,
        //                               style: const TextStyle(
        //                                 color: white,
        //                                 fontSize: 20,
        //                               ),
        //                             );
        //                           }),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Text(
        //                   "Status: " + manga.status,
        //                   style: const TextStyle(
        //                     color: white,
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Text(
        //                   "Last updated " + manga.lastUpdated,
        //                   style: const TextStyle(
        //                     color: white,
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Text(
        //                   "Views: " + manga.views,
        //                   style: const TextStyle(
        //                     color: white,
        //                     fontSize: 20,
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        //                 child: Row(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     Container(
        //                       child: const Text(
        //                         "Genres: ",
        //                         style: TextStyle(
        //                           color: white,
        //                           fontSize: 20,
        //                         ),
        //                       ),
        //                     ),
        //                     Expanded(
        //                       child: ListView.builder(
        //                           shrinkWrap: true,
        //                           physics:
        //                               const NeverScrollableScrollPhysics(),
        //                           itemCount: manga.genres.length,
        //                           itemBuilder: (_, index) {
        //                             return Text(
        //                               manga.genres[index].genre + ', ',
        //                               style: const TextStyle(
        //                                 color: white,
        //                                 fontSize: 20,
        //                               ),
        //                             );
        //                           }),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   alignment: Alignment.topLeft,
        // ),
      ],
    ),
  );
}
