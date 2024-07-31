import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_message.dart';

class MyChats extends StatelessWidget {
  const MyChats({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: double.infinity,
      child: ListView(
        primary: false,
        children: [
          MyMessage(
              imgUrl:
                  "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl: "lib/images/uploads/Profile-Male-PNG.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl: "lib/images/uploads/Profile-Male-PNG.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl: "lib/images/uploads/Profile-Male-PNG.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl:
                  "lib/images/uploads/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
          MyMessage(
              imgUrl: "lib/images/uploads/Profile-Male-PNG.png",
              user: "Joshué Agapé",
              briefChat: "Bonjour Mr Agapé",
              date: "14/07/2024",
              time: "14:07",
              status: "sent"),
        ],
      ),
    );
  }
}
