class MangaModule {
  final int index;
  final String title;
  String chapter;
  final String img;
  String synopsis;
  final String views;
  final String src;
  String uploadedDate;
  String author;
  String rating;

  MangaModule({
    required this.index,
    required this.title,
    this.chapter = "",
    required this.img,
    required this.src,
    this.synopsis = "",
    required this.views,
    this.uploadedDate = "",
    this.author = "",
    this.rating = "",
  });
}
