import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  final String text;
  const MyTabs({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: text
    );
  }
}