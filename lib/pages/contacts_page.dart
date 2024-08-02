import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/create_neMessage.dart';

class ContactsPage extends StatelessWidget {
  final int userId;
  const ContactsPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos contactes"),
      ),
      body: CreateNemessage(
        userId: userId,
      ),
    );
  }
}
