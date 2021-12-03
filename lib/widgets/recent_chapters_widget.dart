import 'package:flutter/material.dart';

import '../models/home_manga_module.dart';
import '../screens/manga_info_screen.dart';

Widget recentChapterCard({
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
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 2, 5),
        height: 200,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              manga.img,
            ),
          ),
        ),
        child: Wrap(
          children: [
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  manga.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                subtitle: Text(
                  manga.chapter,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
        alignment: Alignment.bottomCenter,
      ),
    );
