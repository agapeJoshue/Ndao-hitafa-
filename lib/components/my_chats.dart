import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_message.dart';
import 'package:ndao_hitafa/pages/messages.dart';

class MyChats extends StatelessWidget {
  final int userId;
  const MyChats({
    super.key,
    required this.userId,
  });

  Future<List<dynamic>> fetchMessage() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:7576/api/chats/list-messages/$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: double.infinity,
      child: FutureBuilder<List<dynamic>>(
        future: fetchMessage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load messages'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('Votre liste de discussion s\'affiche ici'));
          } else {
            List<dynamic> messages = snapshot.data!;
            return ListView.builder(
              primary: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return MyMessage(
                  imgUrl: message['profile_url'],
                  user: message['username'],
                  briefChat: message['content'],
                  date: message['date'],
                  time: message['heure'],
                  status: message['status'] ? "sent" : "received",
                );
              },
            );
          }
        },
      ),
    );
  }
}
