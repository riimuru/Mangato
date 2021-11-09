import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../models/manga_info_module.dart';
import '../src/data_source.dart';
import '../utils/constants.dart';

class Pages extends StatelessWidget {
  String chapterLink;
  Pages(this.chapterLink);

  void check() => print(this.chapterLink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: <Widget>[
        Container(
          color: Colors.black, // Your screen background color
        ),
        Expanded(
          child: FutureBuilder(
            future: DataSource.getChapterPages(chapterLink),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: const Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              } else {
                return Swiper(
                  itemCount: snapshot.data.length,
                  loop: false,
                  itemHeight: 300,
                  layout: SwiperLayout.DEFAULT,
                  itemBuilder: (context, index) {
                    return Image.network(
                      snapshot.data[index].img,
                      fit: BoxFit.contain,
                      headers: const {"Referer": Constant.referer},
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: Text(''), // You can add title here
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor:
                Colors.blue.withOpacity(0), //You can make this transparent
            elevation: 0.0, //No shadow
          ),
        ),
      ]),
      // body: Swiper(
      //   itemCount: chapterPages.length,
      //   itemBuilder: (context, index) {
      //     return Image.network(
      //       chapterPages[index].img,
      //       fit: BoxFit.fill,
      //     );
      //   },
      //   itemHeight: 300,
      //   layout: SwiperLayout.DEFAULT,
      // ),
    );
  }
}
