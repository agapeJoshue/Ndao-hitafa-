import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_chats.dart';
import 'package:ndao_hitafa/components/my_tabs.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void logout() {}
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myColors.backgoundColor,
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
                      fontWeight: FontWeight.bold
                    ),
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
            indicatorColor: myColors.tabFocusedColor,
            indicatorWeight: 3.5,
            labelColor: myColors.tabFocusedColor,
            unselectedLabelColor: myColors.white.withOpacity(0.5),
            tabs: [
              MyTabs(text: "chats"),
              MyTabs(text: "contacte"),
              MyTabs(text: "profile"),
            ]
          ),
        ),
        body: TabBarView(
            children: [
            MyChats(),
            Container(),
            Container(),
            /* whatsappStatus(),
            whatsappCall(), */
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.chat
          ),
          backgroundColor: myColors.tabFocusedColor,
        ),


      )
    );
  }
}
