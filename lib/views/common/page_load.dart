import 'package:flutter/material.dart';

class PageLoad extends StatelessWidget {
  const PageLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: //Center(child: CircularProgressIndicator()),
      Center(child: Image.asset("assets/images/loader.gif")),
    );
  }
}
