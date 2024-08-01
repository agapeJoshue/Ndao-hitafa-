import 'package:flutter/material.dart';
import 'package:ndao_hitafa/pages/ajouter_page.dart';
import 'package:ndao_hitafa/pages/invitations.dart';
import 'package:ndao_hitafa/pages/setting_page.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyDrawer extends StatelessWidget {
  final int userId;
  final String imgUrl, username, email;

  const MyDrawer({
    super.key,
    required this.userId,
    required this.imgUrl,
    required this.username,
    required this.email,
  });

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
                  child: Column(
                    children: [
                      Image.asset(
                        imgUrl,
                        width: 58,
                        height: 58,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                                color: myColors.appBarColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                // discussions list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text("D I S C U S I O N S",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.chat),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // invitations list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text("A J O U T E R",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.person_add),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AjouterPage(
                            userId: userId,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // suggestions list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text("I N V I T A T I O N S",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: const Icon(Icons.insert_invitation),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Invitations(
                            userId: userId,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // setting
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text("S E T T I N G S",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,),),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
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
