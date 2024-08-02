import 'package:flutter/material.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class ListesContact extends StatelessWidget {

  final void Function()? openNewDiscussion;


  final int userId;
  final String imgUrl, username, email, status;
  final Color colorStatus;

  const ListesContact({
    super.key,
    required this.imgUrl,
    required this.username,
    required this.email,
    required this.status,
    required this.colorStatus,
    required this.userId,
    required this.openNewDiscussion,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: Container(
        width: width,
        height: 75,
        color: Colors.grey[200],
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: openNewDiscussion,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          imgUrl,
                          width: 58,
                          height: 58,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            username,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            email,
                            style: TextStyle(
                              color: myColors.backgoundColor.withOpacity(0.5),
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      myIcons2(
                        color: colorStatus,
                        right: 10,
                        icon: Icons.circle,
                        size: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          status,
                          style: TextStyle(
                              color: myColors.backgoundColor.withOpacity(0.5),
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
