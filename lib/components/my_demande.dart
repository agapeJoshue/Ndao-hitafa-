import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_invitations.dart';

class MyDemande extends StatelessWidget {
  final int userId;
  final String label;
  const MyDemande({
    super.key,
    required this.label,
    required this.userId,
  });

  Future<List<dynamic>> fetchContacts() async {
    final response = await http.get(
      Uri.parse('http://192.168.56.1:7576/api/users/suggestion-amis/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    final response2 = await http.get(
      Uri.parse(
          'http://192.168.56.1:7576/api/users/lists-invitations-friend/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (label == "Confirmer") {
      return jsonDecode(response2.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: double.infinity,
      child: FutureBuilder<List<dynamic>>(
        future: fetchContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No contacts found'));
          } else {
            return ListView.builder(
              primary: false,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var contact = snapshot.data![index];
                return MyInvitations(
                  imgUrl: contact['profile_url'] ?? 'default_image_url',
                  username: contact['username'],
                  email: contact['email'],
                  label: label,
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
