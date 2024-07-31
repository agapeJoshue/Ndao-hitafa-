import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_friend.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyContacte extends StatelessWidget {
  const MyContacte({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: double.infinity,
      child: ListView(
        primary: false,
        children: [
          MyFriend(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            status: "",
            colorStatus: myColors.inLine,
          ),
          MyFriend(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            status: "",
            colorStatus: myColors.inLine,
          ),
          MyFriend(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            status: "",
            colorStatus: myColors.inLine,
          ),
          MyFriend(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            status: "",
            colorStatus: Theme.of(context).colorScheme.primary,
          ),
          MyFriend(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            status: "",
            colorStatus: Theme.of(context).colorScheme.primary,
          ),
          MyFriend(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            status: "",
            colorStatus: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
