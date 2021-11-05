import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: const Color.fromRGBO(50, 50, 50, 0.5),
      ),
      body: Container(
        child: const Center(
          child: Text(
            "Your list is empty.",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
