class FavoriteChapters {
  final int id;
  final String title;
  final String alt;
  final String img;
  final String chapterTitle;
  final String chapterViews;
  final String chapterLink;
  final bool isFavorite;

  FavoriteChapters({
    required this.id,
    required this.title,
    required this.alt,
    required this.img,
    required this.chapterTitle,
    required this.chapterViews,
    required this.chapterLink,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'alt': alt,
      'img': img,
      'chapterTitle': chapterTitle,
      'chapterViews': chapterViews,
      'chapterLink': chapterLink,
    };
  }
}

class FavoriteManga {
  final int id;
  final String title;
  final String img;
  final String mangaLink;
  final String synopsis;
  final String views;
  final bool isFavorite;

  FavoriteManga({
    required this.id,
    required this.title,
    required this.img,
    required this.mangaLink,
    required this.synopsis,
    required this.views,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'img': img,
      'mangaLink': mangaLink,
      'synopsis': synopsis,
      'views': views,
    };
  }
}
