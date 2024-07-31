import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_friend.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyContacte extends StatelessWidget {
  final int userId;

  const MyContacte({
    super.key,
    required this.userId,
  });

  Future<List<dynamic>> fetchContacts() async {
    final response = await http.get(
      Uri.parse('http://192.168.56.1:7576/api/users/contactes/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load contacts');
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
            return Center(child: Text('No contacts found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data![index];
                return MyFriend(
                  userId: contact['user_id'],
                  imgUrl: contact['profile_url'],
                  username: contact['username'],
                  email: contact['email'],
                  status: "",
                  colorStatus: contact['status'] == 1
                      ? myColors.inLine
                      : Theme.of(context).colorScheme.primary,
                );
              },
            );
          }
        },
      ),
    );
  }
}
