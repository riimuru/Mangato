class MangaInfoModule {
  final String title;
  final String synopsis;
  final String alt;
  final String status;
  final String lastUpdated;
  final String rating;
  final String totalVoted;
  final List<Genres> genres;
  final List<Authors> authors;
  final String img;
  final String views;
  final String src;
  final List<Chapters> chapters;
  final String mangaLink;

  MangaInfoModule({
    required this.title,
    required this.synopsis,
    required this.alt,
    required this.status,
    required this.lastUpdated,
    required this.rating,
    required this.totalVoted,
    required this.genres,
    required this.authors,
    required this.img,
    required this.src,
    required this.views,
    required this.chapters,
    required this.mangaLink,
  });
}

class Genres {
  final String genre;
  final String genreLink;

  Genres({
    required this.genre,
    required this.genreLink,
  });
}

class Authors {
  final String authorName;
  final String authorLink;

  Authors({
    required this.authorName,
    required this.authorLink,
  });
}

class Chapters {
  final String chapterTitle;
  final String chapterViews;
  final String uploadedDate;
  final String chapterLink;
  bool isFavorite;

  Chapters({
    required this.chapterTitle,
    required this.chapterViews,
    required this.uploadedDate,
    required this.chapterLink,
    this.isFavorite = false,
  });
}

class ChapterPages {
  final String chapterPageTitle;
  final String img;

  ChapterPages({
    required this.chapterPageTitle,
    required this.img,
  });
}
