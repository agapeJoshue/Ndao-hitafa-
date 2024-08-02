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
  _MyInvitationsPageState createState() => _MyInvitationsPageState();
}

class _MyInvitationsPageState extends State<Myinvitations> {
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
            'http://192.168.56.1:7576/api/users/lists-invitations-friend/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load contacts');
      }
    } catch (e) {
      throw Exception('Failed to load contacts: $e');
    }
  }

  Future<void> cancel(int receivedBy) async {
    try {
      await http.delete(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/cancel-a-invitation/${widget.userId}/$receivedBy'),
        headers: {'Content-Type': 'application/json'},
      );
      setState(() {
        contactsFuture = fetchContacts();
      });
    } catch (e) {
      throw Exception('Failed to cancel invitation: $e');
    }
  }

  Future<void> confirm(int invitationId) async {
    try {
      await http.put(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/accept-a-invitation/${widget.userId}/$invitationId'),
        headers: {'Content-Type': 'application/json'},
      );
      setState(() {
        contactsFuture = fetchContacts();
      });
    } catch (e) {
      throw Exception('Failed to confirm invitation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
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
            return const Center(child: Text('No invitations found'));
          } else {
            return ListView.builder(
              primary: false,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var invitation = snapshot.data![index];
                return MyInvitationTile(
                  imgUrl: invitation['profile_url'],
                  username: invitation['username'],
                  email: invitation['email'],
                  onTap: () => confirm(invitation['id']),
                  buttonText: 'Confirm',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MyInvitationTile extends StatelessWidget {
  final String imgUrl;
  final String username;
  final String email;
  final VoidCallback onTap;
  final String buttonText;

  const MyInvitationTile({
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
      leading: SizedBox(
        width: 58,
        height: 58,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            imgUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: ElevatedButton(
        onPressed: onTap,
        child: Text(buttonText),
      ),
    );
  }
}
