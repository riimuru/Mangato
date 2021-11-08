class SearchModule {
  final String query;
  final List<SearchedChapters> mangas;

  SearchModule({
    required this.query,
    required this.mangas,
  });
}

class SearchedChapters {
  final String title;
  final String chapterTitle;
  final String authors;
  final String updatedDate;
  final String views;
  final String img;
  final String src;
  final String synopsis;
  final String rating;

  SearchedChapters({
    required this.title,
    required this.chapterTitle,
    required this.authors,
    required this.views,
    required this.img,
    required this.src,
    required this.synopsis,
    required this.updatedDate,
    required this.rating,
  });
}
