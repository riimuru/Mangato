import 'package:flutter/material.dart';
import 'package:shonen_jump/models/manga_info_module.dart';
import '../src/data_source.dart';

DataSource dataSource = DataSource();

Widget mangaInfoWidget({
  required MangaInfoModule manga,
  required BuildContext context,
}) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            width: double.infinity,
            child: Row(
              children: [
                Flexible(
                  child: Image.network(manga.img),
                ),
                Flexible(
                  child: Container(
                    height: 340,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Text(
                            manga.title,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Text(
                            manga.alt,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: const Text(
                                  "Author(s): ",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: manga.authors.length,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        child: Text(
                                          manga.authors[index].authorName,
                                          style: const TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 20,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Text(
                            "Status: " + manga.status,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Text(
                            "Last updated " + manga.lastUpdated,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Text(
                            "Views: " + manga.views,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: const Text(
                                  "Genres: ",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: manga.genres.length,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        child: Text(
                                          manga.genres[index].genre + ', ',
                                          style: const TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 20,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
