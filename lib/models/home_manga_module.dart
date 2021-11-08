class MangaModule {
  final int index;
  final String title;
  String chapter = "";
  final String img;
  String synopsis = "";
  final String views;
  final String src;

  MangaModule({
    required this.index,
    required this.title,
    this.chapter = "",
    required this.img,
    required this.src,
    this.synopsis = "",
    required this.views,
  });
}
