import 'package:flutter/material.dart';

import '../src/data_source.dart';
import '../screens/manga_info_screen.dart';
import '../custom/custom_tile.dart';
import '../models/home_manga_module.dart';
import '../models/manga_search_module.dart';

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
    return SingleChildScrollView(
      child: FutureBuilder(
        future: DataSource.getResults(query),
        builder: (_, AsyncSnapshot<SearchModule> snapshot) {
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
              itemCount: snapshot.data!.mangas.length,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MangaInfo(
                          MangaModule(
                            index: index,
                            title: snapshot.data!.mangas[index].title,
                            img: snapshot.data!.mangas[index].img,
                            src: snapshot.data!.mangas[index].src,
                            views: snapshot.data!.mangas[index].views,
                          ),
                        ),
                      ),
                    );
                  },
                  child: CustomListItemTwo(
                    thumbnail: Image.network(
                      snapshot.data!.mangas[index].img,
                      fit: BoxFit.cover,
                    ),
                    title: snapshot.data!.mangas[index].title,
                    subtitle: snapshot.data!.mangas[index].chapterTitle,
                    author: snapshot.data!.mangas[index].authors,
                    synopsis: snapshot.data!.mangas[index].synopsis,
                    publishDate: snapshot.data!.mangas[index].updatedDate,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return SingleChildScrollView(
        child: FutureBuilder(
          future: DataSource.getResults(query),
          builder: (_, AsyncSnapshot<SearchModule> snapshot) {
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
                itemCount: snapshot.data!.mangas.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MangaInfo(
                            MangaModule(
                              index: index,
                              title: snapshot.data!.mangas[index].title,
                              img: snapshot.data!.mangas[index].img,
                              src: snapshot.data!.mangas[index].src,
                              views: snapshot.data!.mangas[index].views,
                            ),
                          ),
                        ),
                      );
                    },
                    child: CustomListItemTwo(
                      thumbnail: Image.network(
                        snapshot.data!.mangas[index].img,
                        fit: BoxFit.cover,
                      ),
                      title: snapshot.data!.mangas[index].title,
                      subtitle: snapshot.data!.mangas[index].chapterTitle,
                      author: snapshot.data!.mangas[index].authors,
                      synopsis: snapshot.data!.mangas[index].synopsis,
                      publishDate: snapshot.data!.mangas[index].updatedDate,
                    ),
                  );
                },
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
