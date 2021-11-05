import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Manga(),
      ),
    );

class Manga extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MangaState();
  }
}
