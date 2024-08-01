import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Myinvitations extends StatefulWidget {
  final int userId;

  const Myinvitations({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _MyInvitationState createState() => _MyInvitationState();
}

class _MyInvitationState extends State<Myinvitations> {
  late Future<List<dynamic>> contactsFuture;
  Set<int> pendingInvitations = {};

  @override
  void initState() {
    super.initState();
    contactsFuture = fetchContacts();
  }

  Future<List<dynamic>> fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/lists-invitations-friend/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
      );

        return jsonDecode(response.body);
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
      setState(() {
        pendingInvitations.add(receivedBy);
      });
    } catch (e) {
      throw Exception('Failed to add friend: $e');
    }
  }

  Future<void> annuler(int receivedBy) async {
    try {
      await http.delete(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/cancel-invitation/${widget.userId}/$receivedBy'),
        headers: {'Content-Type': 'application/json'},
      );
      setState(() {
        pendingInvitations.remove(receivedBy);
      });
    } catch (e) {
      throw Exception('Failed to cancel invitation: $e');
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
                  onTap:  () => {},
                  buttonText: 'Confirmer',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MyInvitations extends StatelessWidget {
  final String imgUrl;
  final String username;
  final String email;
  final VoidCallback onTap;
  final String buttonText;

  const MyInvitations({
    Key? key,
    required this.imgUrl,
    required this.username,
    required this.email,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          imgUrl,
          width: 58,
          height: 58,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(username),
      subtitle: Text(email),
      trailing: ElevatedButton(
        onPressed: onTap,
        child: Text(buttonText),
      ),
    );
  }
}
