import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("NTU Student Job Market Application"),
      ),
      body: Center(
        child: Center(
          child: Text("Hello Flutter app"),
        ),
      ),
    );
  }
}
