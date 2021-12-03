import 'package:flutter/material.dart';

class _MangaDescription extends StatelessWidget {
  _MangaDescription({
    Key? key,
    required this.title,
    required this.latestChapter,
    required this.author,
    required this.publishDate,
    required this.synopsis,
    this.isFavorite,
  }) : super(key: key);

  final String title;
  final String latestChapter;
  final String author;
  final String publishDate;
  final String synopsis;
  Widget? isFavorite;

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
              ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: isFavorite,
              ),
              // Text(
              //   title,
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
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
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    : Container();
              }()),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                synopsis,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
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
                style: Theme.of(context).textTheme.caption,
                maxLines: 1,
              ),
              Text(
                publishDate,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.latestChapter,
    required this.author,
    required this.synopsis,
    required this.publishDate,
    this.isFavorite,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String latestChapter;
  final String author;
  final String publishDate;
  final String synopsis;
  Widget? isFavorite;
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
                  isFavorite: isFavorite,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
