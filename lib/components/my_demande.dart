import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_invitations.dart';

class MyDemande extends StatelessWidget {
  final String label;
  const MyDemande({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: double.infinity,
      child: ListView(
        primary: false,
        children: [
          MyInvitations(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            label: label,
            onTap: () {},
          ),
          MyInvitations(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            label: label,
            onTap: () {},
          ),
          MyInvitations(
            imgUrl:
                "lib/images/uploads/happy-young-cute-illustration-face-profile-png.webp",
            username: "Joshué Agapé",
            email: "joshueagape@gmail.com",
            label: label,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
