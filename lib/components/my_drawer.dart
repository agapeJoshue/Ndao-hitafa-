import 'package:flutter/material.dart';
import 'package:ndao_hitafa/pages/ajouter_page.dart';
import 'package:ndao_hitafa/pages/invitations.dart';
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

                // discussions list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("D I S C U S I O N S"),
                    leading: Icon(Icons.chat),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // invitations list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("A J O U T E R"),
                    leading: Icon(Icons.person_add),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AjouterPage(),
                        ),
                      );
                    },
                  ),
                ),

                // suggestions list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("I N V I T A T I O N S"),
                    leading: Icon(Icons.insert_invitation),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Invitations(),
                        ),
                      );
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
                title: Text("L O G O U T"),
                leading: Icon(Icons.logout),
                onTap: () {},
              ),
            )
          ],
        ));
  }
}
