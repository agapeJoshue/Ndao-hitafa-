import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Messages extends StatefulWidget {
  final int userId, idUserConnected;
  final String emailUser, username, profileUrl, channelUUID;

  const Messages({
    super.key,
    required this.userId,
    required this.idUserConnected,
    required this.emailUser,
    required this.username,
    required this.profileUrl,
    required this.channelUUID,
  });

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _connectSocket();
    _fetchMessages();
  }

  void _connectSocket() {
    socket = IO.io('http://192.168.56.1:7576',
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.on('connect', (_) {
      print('Socket connected');
    });

    socket.on('connect_error', (error) {
      print('Socket connection error: $error');
    });

    socket.on('disconnect', (_) {
      print('Socket disconnected');
    });

    socket.on('messageReceived_${widget.userId}', (data) {
      final message = Message.fromJson(data);
      if (!messages.any((msg) =>
          msg.date == message.date && msg.content == message.content)) {
        setState(() {
          messages.add(message);
        });
      }
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = Message(
      content: _messageController.text,
      channelUUID: widget.channelUUID,
      sender: widget.idUserConnected,
      receivedBy: widget.userId,
      isMe: true,
      date: DateTime.now().toIso8601String(),
      heure: DateTime.now().toLocal().toString(),
      isRead: false,
      isUpdated: false,
    );

    final response = await http.post(
      Uri.parse("http://192.168.56.1:7576/api/chats/new-message"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 200) {
      setState(() {
        messages.add(message);
        _messageController.clear();
      });
    } else {
      print('Failed to send message');
    }
  }

  Future<void> _fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:7576/api/chats/list-discussions/${widget.channelUUID}/${widget.idUserConnected}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          // Réinitialisez la liste des messages avant d'ajouter les nouveaux messages
          messages = data.map((json) => Message.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                widget.profileUrl,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.emailUser,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Écrire un message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: message.isMe
              ? const Color.fromARGB(255, 0, 102, 255)
              : const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: message.isMe
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final String channelUUID;
  final int sender;
  final int receivedBy;
  final bool isMe;
  final String date;
  final String heure;
  final bool isRead;
  final bool isUpdated;

  Message({
    required this.content,
    required this.channelUUID,
    required this.sender,
    required this.receivedBy,
    required this.isMe,
    required this.date,
    required this.heure,
    required this.isRead,
    required this.isUpdated,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] ?? '',
      channelUUID: json['channelUUID'] ?? '',
      sender: json['sender'] ?? 0,
      receivedBy: json['receivedBy'] ?? 0,
      isMe: json['isMe'],
      date: json['date'],
      heure: json['heure'],
      isRead: json['is_read'] ,
      isUpdated: json['is_updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'channelUUID': channelUUID,
      'sender': sender,
      'receivedBy': receivedBy,
      'isMe': isMe,
      'date': date,
      'heure': heure,
      'is_read': isRead,
      'is_updated': isUpdated,
    };
  }
}
