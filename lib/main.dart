import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ShonenJump(),
      ),
    );

class ShonenJump extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShonenJumpState();
  }
}
