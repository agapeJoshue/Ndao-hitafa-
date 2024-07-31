import 'package:flutter/material.dart';
import 'package:ndao_hitafa/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //logo
                DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.wechat,
                      color: Theme.of(context).colorScheme.primary,
                      size: 64,
                    ),
                  ),
                ),

                // home list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("H O M E"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // setting
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("S E T T I N G S"),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            //logout
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("H O M E"),
                leading: Icon(Icons.logout),
                onTap: () {},
              ),
            )
          ],
        ));
  }
}
