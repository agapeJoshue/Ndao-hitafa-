import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_contacte.dart';

class my_contacte extends StatelessWidget {
  const my_contacte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos contactes"),
      ),
      body: MyContacte(userId: 1,),
    );
  }
}
