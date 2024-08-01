import 'package:flutter/material.dart';

class MyTabicon extends StatelessWidget {
  final Icon icon;
  const MyTabicon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: icon,
    );
  }
}