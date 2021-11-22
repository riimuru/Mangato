class MangaModule {
  final int idx;
  final String title;
  String chapter;
  final String img;
  String synopsis;
  final String views;
  final String src;
  String uploadedDate;
  String author;
  String rating;
  final int timeStamp;

  MangaModule({
    required this.idx,
    required this.title,
    this.chapter = "",
    required this.img,
    required this.src,
    this.synopsis = "",
    required this.views,
    this.uploadedDate = "",
    this.author = "",
    this.rating = "",
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'idx': idx,
      'title': title,
      'chapter': chapter,
      'img': img,
      'synopsis': synopsis,
      'views': views,
      'src': src,
      'uploadedDate': uploadedDate,
      'author': author,
      'rating': rating,
      'timeStamp': timeStamp,
    };
  }
}
