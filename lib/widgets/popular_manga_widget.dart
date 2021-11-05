import '../models/home_manga_module.dart';
import 'package:flutter/material.dart';
import '../screens/manga_info_screen.dart';
import '../src/data_source.dart';

DataSource dataSource = DataSource();

Widget popularMangaCard({
  required MangaModule item,
  required BuildContext context,
}) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MangaInfo(item),
          ),
        );
      },
      child: Wrap(
        // height: 700,
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          // physics: const NeverScrollableScrollPhysics(),
          Card(
            color: const Color.fromRGBO(0, 0, 0, 0),
            elevation: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          item.img,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    minLeadingWidth: 0,
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item.synopsis,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // child: Container(
                  //   padding: const EdgeInsets.all(10),
                  //   height: 150,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         item.title,
                  //         style: const TextStyle(
                  //           color: Color(0xFFFFFFFF),
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Container(
                  //         width: 240,
                  //         child: Text(
                  //           item.synopsis,
                  //           style: const TextStyle(
                  //             color: Color(0xFFFFFFFF),
                  //           ),
                  //           maxLines: 3,
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
