import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_demande.dart';

class Invitations extends StatelessWidget {
  const Invitations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend requests"),
      ),
      body: MyDemande(label: "Confirmer",),
    );
  }
}
