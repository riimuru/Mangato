import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/home_manga_module.dart';
import '../widgets/manga_info_widget.dart';
import '../models/manga_info_module.dart';
import '../utils/constants.dart';
import '../src/data_source.dart';

class MangaInfo extends StatefulWidget {
  final MangaModule manga;

  const MangaInfo(this.manga);

  @override
  State<StatefulWidget> createState() => MangaInfoState(this.manga);
}

class MangaInfoState extends State<MangaInfo>
    with SingleTickerProviderStateMixin {
  final MangaModule manga;
  MangaInfoState(this.manga);

  late TabController _controller;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
        title: Hero(
          tag: manga.title,
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              manga.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: Constant.fontRegular,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: DataSource.getMangaInfo(manga.src),
        builder: (_, AsyncSnapshot<MangaInfoModule> snapshot) {
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
            return mangaInfoWidget(manga: snapshot.data!, context: _);
          }
        },
      ),
    );
  }
}
