import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/MyInvitations.dart';

class Invitations extends StatelessWidget {
  final int userId;
  const Invitations({
    super.key,
    required this.userId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend requests"),
      ),
      body: Myinvitations(
        userId: userId,
      ),
    );
  }
}
