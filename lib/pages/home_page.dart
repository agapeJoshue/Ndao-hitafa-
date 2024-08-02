import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_chats.dart';
import 'package:ndao_hitafa/components/my_contacte.dart';
import 'package:ndao_hitafa/components/my_profile.dart';
import 'package:ndao_hitafa/components/my_tabIcon.dart';
import 'package:ndao_hitafa/pages/contacts_page.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class HomePage extends StatelessWidget {
  final String token, username, email, profilePath;
  final int userId;

  const HomePage({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
    required this.profilePath,
    required this.token,
  });

  void logout(BuildContext context) {
    // Implémenter la déconnexion ici
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 16, 107),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wechat,
                    color: myColors.white.withOpacity(0.9),
                    size: 40,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Ndao Hitafa",
                    style: TextStyle(
                      color: myColors.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'Profile':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfile(
                                email: email,
                                userId: userId,
                                username: username,
                                profileUrl: profilePath,
                              ),
                            ),
                          );
                          break;
                        case 'Help?':
                          // Ajouter l'action pour "Help?"
                          break;
                        case 'A propos':
                          // Ajouter l'action pour "A propos"
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'Profile',
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 119, 119, 119),
                              ),
                              Text('Profile'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Help?',
                          child: Row(
                            children: [
                              Icon(
                                Icons.help,
                                color: Color.fromARGB(255, 119, 119, 119),
                              ),
                              Text('Help?'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'A propos',
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Color.fromARGB(255, 119, 119, 119),
                              ),
                              Text('A propos'),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 0, 247, 255),
            indicatorWeight: 3.5,
            labelColor: Color.fromARGB(255, 0, 247, 255),
            unselectedLabelColor: myColors.white.withOpacity(0.5),
            tabs: [
              MyTabicon(icon: Icon(Icons.chat_rounded)),
              MyTabicon(icon: Icon(Icons.people)),
              MyTabicon(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MyChats(userId: userId),
            MyContacte(userId: userId),
            MyProfile(
              userId: userId,
              username: username,
              email: email,
              profileUrl: profilePath,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactsPage(userId: userId),
              ),
            );
          },
          child: Icon(Icons.chat),
          backgroundColor: myColors.tabFocusedColor,
        ),
      ),
    );
  }
}
