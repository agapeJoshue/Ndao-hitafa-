import 'dart:async'; // Importer le package pour utiliser Timer
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_message.dart';
import 'package:ndao_hitafa/pages/messages.dart';

class MyChats extends StatefulWidget {
  final int userId;
  const MyChats({
    super.key,
    required this.userId,
  });

  @override
  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  late Future<List<dynamic>> _messagesFuture;
  Timer? _timer; // Déclaration du Timer

  @override
  void initState() {
    super.initState();
    _messagesFuture = fetchMessages();

    // Initialiser le Timer pour rafraîchir toutes les 5 secondes
    /* _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _refreshMessages();
    }); */
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Vous pouvez éventuellement vouloir appeler _refreshMessages ici aussi
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annuler le Timer lorsque le widget est supprimé
    super.dispose();
  }

  Future<void> _refreshMessages() async {
    setState(() {
      _messagesFuture = fetchMessages();
    });
  }

  Future<List<dynamic>> fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:7576/api/chats/list-messages/${widget.userId}'),
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
        future: _messagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load messages'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
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
                  status: message['status'],
                  openRoom: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Messages(
                          userId: message['user_id'],
                          idUserConnected: widget.userId,
                          emailUser: message['email'],
                          username: message['username'],
                          profileUrl: message['profile_url'],
                          channelUUID: message['channel_uuid'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
