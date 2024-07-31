import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_invitations.dart';

class MyDemande extends StatefulWidget {
  final int userId;
  final String label;

  const MyDemande({
    Key? key,
    required this.label,
    required this.userId,
  }) : super(key: key);

  @override
  _MyDemandeState createState() => _MyDemandeState();
}

class _MyDemandeState extends State<MyDemande> {
  late Future<List<dynamic>> contactsFuture;

  @override
  void initState() {
    super.initState();
    contactsFuture = fetchContacts();
  }

  Future<List<dynamic>> fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/suggestion-amis/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
      );

      final response2 = await http.get(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/lists-invitations-friend/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (widget.label == "Confirmer") {
        return jsonDecode(response2.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Failed to load contacts: $e');
    }
  }

  Future<void> ajouter(int receivedBy) async {
    try {
      await http.post(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/add-new-friend/${widget.userId}/$receivedBy'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw Exception('Failed to add friend: $e');
    }
  }

  Future<void> confirmer(int invitationId) async {
    try {
      await http.put(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/accept-a-invitation/${widget.userId}/$invitationId'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw Exception('Failed to confirm invitation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: double.infinity,
      child: FutureBuilder<List<dynamic>>(
        future: contactsFuture,
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
                  label: widget.label,
                  onTap: widget.label == "Confirmer"
                      ? () => confirmer(contact['id'])
                      : () => ajouter(contact['user_id']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
