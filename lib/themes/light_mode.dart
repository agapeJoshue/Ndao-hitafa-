import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
);

class myColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color appBarColor = Color(0xFF1F2C34);
  static const Color backgoundColor = Color(0xFF121B22);
  static const Color tabFocusedColor = Color(0xFF05A381);
  static const Color inLine = Color.fromARGB(255, 0, 219, 18);
}

class myIcons extends StatelessWidget {
  final double? right;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const myIcons(
      {this.right,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: right ?? 0.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}

class myIcons2 extends StatelessWidget {
  final double? right;
  final IconData icon;
  final Color color;
  final double size;

  const myIcons2(
      {this.right,
      required this.icon,
      required this.color,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: right ?? 0.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Icon(
            icon,
            color: color,
            size: size,
          ),
        ),
      ),
    );
  }
}
