import 'package:flutter/material.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class MyButton2 extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton2({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: myColors.blueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                color: myColors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
