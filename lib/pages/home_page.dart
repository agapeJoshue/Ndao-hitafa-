import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_chats.dart';
import 'package:ndao_hitafa/components/my_contacte.dart';
import 'package:ndao_hitafa/components/my_drawer.dart';
import 'package:ndao_hitafa/components/my_tabIcon.dart';
import 'package:ndao_hitafa/components/my_tabs.dart';
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

  void logout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                      color: myColors.white.withOpacity(0.5),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Ndao Hitafa",
                      style: TextStyle(
                          color: myColors.white.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    myIcons(
                      icon: Icons.search,
                      right: 20,
                      color: myColors.white.withOpacity(0.5),
                      onTap: () {},
                    ),
                    myIcons(
                      icon: Icons.more_vert,
                      right: 0,
                      color: myColors.white.withOpacity(0.5),
                      onTap: () {},
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
                /* const MyTabs(text: "Discussions"),
                const MyTabs(text: "Contacts"), */
                const MyTabicon(icon: Icon(Icons.chat_rounded)),
                const MyTabicon(icon: Icon(Icons.people)),
              ],
            ),
          ),
          /* drawer: MyDrawer(
            userId: userId,
            username: username,
            email: email,
            imgUrl: profilePath,
          ), */
          body: TabBarView(
            children: [
              MyChats(userId: userId),
              MyContacte(userId: userId),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactsPage(userId: userId)),
              );
            },
            child: Icon(Icons.chat),
            backgroundColor: myColors.tabFocusedColor,
          ),
        ));
  }
}
