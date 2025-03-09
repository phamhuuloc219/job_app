import 'package:flutter/material.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/reusable_text.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ReusableText(
              text: "Welcome to NTU Student Job Market",
              style: appStyle(18, Color(kDark.value), FontWeight.bold)
          ),
        ),
    );
  }
}