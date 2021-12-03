import 'package:flutter/material.dart';

import '../models/home_manga_module.dart';
import '../screens/manga_info_screen.dart';
import '../services/data_source.dart';
import '../custom/custom_tile.dart';
import '../utils/constants.dart';

DataSource dataSource = DataSource();

Widget popularMangaCard({
  required MangaModule manga,
  required BuildContext context,
}) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MangaInfo(manga),
          ),
        );
      },
      child: CustomListItemTwo(
        thumbnail: Image.network(
          manga.img,
          fit: BoxFit.cover,
        ),
        title: manga.title,
        latestChapter: manga.chapter,
        author: manga.author,
        synopsis: manga.synopsis,
        publishDate: manga.uploadedDate,
      ),
      // child: Wrap(
      //   // height: 700,
      //   // padding: const EdgeInsets.symmetric(horizontal: 10),
      //   children: <Widget>[
      //     // physics: const NeverScrollableScrollPhysics(),
      //     Card(
      //       color: const Color.fromRGBO(0, 0, 0, 0),
      //       elevation: 5,
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Flexible(
      //             child: Container(
      //               height: 150,
      //               width: 120,
      //               decoration: BoxDecoration(
      //                 borderRadius: const BorderRadius.only(
      //                     bottomLeft: Radius.circular(5),
      //                     topLeft: Radius.circular(5)),
      //                 image: DecorationImage(
      //                   fit: BoxFit.cover,
      //                   image: NetworkImage(
      //                     item.img,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Flexible(
      //             child: ListTile(
      //               minLeadingWidth: 0,
      //               title: Text(
      //                 item.title,
      //                 style: const TextStyle(
      //                   color: white,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //               subtitle: Text(
      //                 item.synopsis,
      //                 style: const TextStyle(
      //                   color: white,
      //                 ),
      //                 maxLines: 3,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //             ),
      //   ),
      // ],
    );
      //     ),
      //   ],
      // ),
