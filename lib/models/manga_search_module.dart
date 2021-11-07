class SearchModule {
  final String query;
  final String totalStoriesFound;
  final String totalPages;
  final List<SearchedChapters> mangas;

  SearchModule({
    required this.query,
    required this.totalStoriesFound,
    required this.totalPages,
    required this.mangas,
  });
}

class SearchedChapters {
  final String title;
  final String authors;
  final String lastUpdated;
  final String views;
  final String img;
  final String src;
  final List<latestChapters> chapters;

  SearchedChapters({
    required this.title,
    required this.authors,
    required this.lastUpdated,
    required this.views,
    required this.img,
    required this.src,
    required this.chapters,
  });
}

class latestChapters {
  final String chapterTitle;
  final String chapterLink;

  latestChapters({
    required this.chapterTitle,
    required this.chapterLink,
  });
}
