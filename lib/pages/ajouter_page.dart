import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_demande.dart';

class AjouterPage extends StatelessWidget {
  final int userId;
  const AjouterPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Ajouter des contactes"),
        title: Text("Add new contact"),
      ),
      body: MyDemande(
        userId: userId,
      ),
    );
  }
}
