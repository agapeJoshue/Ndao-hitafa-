import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/components/my_friend.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class Mynewcontact extends StatefulWidget {
  final int userId;

  const Mynewcontact({
    super.key,
    required this.userId,
  });

  @override
  _MyContacteState createState() => _MyContacteState();
}

class _MyContacteState extends State<Mynewcontact>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchContacts() async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.56.1:7576/api/users/contactes2/${widget.userId}'),
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
    return Scaffold(
      body: SizedBox(
        width: width,
        height: double.infinity,
        child: FutureBuilder<List<dynamic>>(
          future: fetchContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "Vérifiez votre connexion internet",
              ));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Aucun contact trouvé.',
                ),
              );
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
      ),
    );
  }
}
