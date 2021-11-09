class FavoriteChapters {
  final int id;
  final String title;
  final String alt;
  final String img;
  final String chapterTitle;
  final String chapterViews;
  final String chapterLink;

  FavoriteChapters({
    required this.id,
    required this.title,
    required this.alt,
    required this.img,
    required this.chapterTitle,
    required this.chapterViews,
    required this.chapterLink,
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
