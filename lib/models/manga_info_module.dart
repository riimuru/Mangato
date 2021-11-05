import './manga_chapters_module.dart';
import './manga_genres_module.dart';
import './manga_authors_module.dart';

class MangaInfoModule {
  final String title;
  final String synopsis;
  final String alt;
  final String status;
  final String lastUpdated;
  final List<Genres> genres;
  final List<Authors> authors;
  final String img;
  final String views;
  final String src;
  final List<Chapters> chapters;

  MangaInfoModule({
    required this.title,
    required this.synopsis,
    required this.alt,
    required this.status,
    required this.lastUpdated,
    required this.genres,
    required this.authors,
    required this.img,
    required this.src,
    required this.views,
    required this.chapters,
  });
}
