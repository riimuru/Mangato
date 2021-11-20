import 'package:flutter/material.dart';

class _MangaDescription extends StatelessWidget {
  const _MangaDescription({
    Key? key,
    required this.title,
    required this.latestChapter,
    required this.author,
    required this.publishDate,
    required this.synopsis,
  }) : super(key: key);

  final String title;
  final String latestChapter;
  final String author;
  final String publishDate;
  final String synopsis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              (() {
                return (latestChapter.isNotEmpty)
                    ? const Padding(padding: EdgeInsets.only(bottom: 2.0))
                    : Container();
              }()),
              (() {
                return (latestChapter.isNotEmpty)
                    ? Text(
                        "Latest: $latestChapter",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      )
                    : Container();
              }()),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                synopsis,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              Text(
                publishDate,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo(
      {Key? key,
      required this.thumbnail,
      required this.title,
      required this.latestChapter,
      required this.author,
      required this.synopsis,
      required this.publishDate})
      : super(key: key);

  final Widget thumbnail;
  final String title;
  final String latestChapter;
  final String author;
  final String publishDate;
  final String synopsis;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        height: 145,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 120,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                child: _MangaDescription(
                  title: title,
                  latestChapter: latestChapter,
                  author: author,
                  publishDate: publishDate,
                  synopsis: synopsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
