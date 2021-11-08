import 'package:flutter/material.dart';
import '../models/home_manga_module.dart';

import '../src/data_source.dart';
import '../screens/manga_info_screen.dart';

DataSource data = DataSource();

class DataSearch extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      backgroundColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.black,
        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
        focusColor: Colors.white,
        hoverColor: Colors.white,
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF191919),
      ),
      scaffoldBackgroundColor: const Color(0xFF191919),
    );
  }
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return Theme.of(context).copyWith(
  //     scaffoldBackgroundColor: Color(0xFF191919),
  //   );
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, ""),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: data.getResults(query),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.mangas.length,
              itemBuilder: (context, int index) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MangaInfo(
                        MangaModule(
                          index: index,
                          title: snapshot.data.mangas[index].title,
                          img: snapshot.data.mangas[index].img,
                          src: snapshot.data.mangas[index].src,
                          views: snapshot.data.mangas[index].views,
                        ),
                      ),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                title: Text(
                  snapshot.data.mangas[index].title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container(
        child: FutureBuilder(
          future: data.getResults(query),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.mangas.length,
                itemBuilder: (context, int index) => ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MangaInfo(
                          MangaModule(
                            index: index,
                            title: snapshot.data.mangas[index].title,
                            img: snapshot.data.mangas[index].img,
                            src: snapshot.data.mangas[index].src,
                            views: snapshot.data.mangas[index].views,
                          ),
                        ),
                      ),
                    );
                  },
                  leading: const Icon(
                    Icons.book,
                    color: Colors.white,
                  ),
                  title: Text(
                    snapshot.data.mangas[index].title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
    } else {
      return Container(
        child: const Center(
          child: Text(
            "",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      );
    }
  }
}
