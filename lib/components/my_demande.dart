import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_invitations.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyDemande extends StatefulWidget {
  final int userId;

  const MyDemande({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _MyDemandeState createState() => _MyDemandeState();
}

class _MyDemandeState extends State<MyDemande> {
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
            'http://192.168.56.1:7576/api/users/suggestion-amis/${widget.userId}'),
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
        contactsFuture = fetchContacts();
      });
    } catch (e) {
      throw Exception('Failed to add friend: $e');
    }
  }

  Future<void> annuler(int receivedBy) async {
    try {
      await http.delete(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/cancel-demande/${widget.userId}/$receivedBy'),
        headers: {'Content-Type': 'application/json'},
      );
      setState(() {
        contactsFuture = fetchContacts();
      });
    } catch (e) {
      throw Exception('Failed to cancel invitation: $e');
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts found'));
          } else {
            return ListView.builder(
              primary: false,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var contact = snapshot.data![index];
                bool isPending = contact['invitationAlreadyExist'];
                return MyInvitations(
                  imgUrl: contact['profile_url'] ?? 'default_image_url',
                  username: contact['username'],
                  email: contact['email'],
                  onTap: isPending
                      ? () => annuler(contact['user_id'])
                      : () => ajouter(contact['user_id']),
                  buttonText: isPending ? 'Annuler' : 'Ajouter',
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
        child: Text(
          buttonText,
          style: TextStyle(
              color: buttonText == "Annuler"
                  ? Theme.of(context).colorScheme.primary
                  : myColors.blueColor),
        ),
      ),
    );
  }
}
