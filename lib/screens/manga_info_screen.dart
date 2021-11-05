import 'package:flutter/material.dart';
import '../models/home_manga_module.dart';
import '../widgets/manga_info_widget.dart';
import '../models/manga_info_module.dart';

class MangaInfo extends StatelessWidget {
  final MangaModule manga;

  MangaInfo(this.manga);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
        title: Text(manga.title),
      ),
      body: FutureBuilder(
          future: dataSource.getMangaInfo(manga.src),
          builder: (_, AsyncSnapshot<MangaInfoModule> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            } else {
              return mangaInfoWidget(manga: snapshot.data!, context: _);
            }
          }),
    );
  }
}
