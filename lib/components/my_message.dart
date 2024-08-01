import 'package:flutter/material.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyMessage extends StatelessWidget {
  //final void Function()? openRoom;

  final String imgUrl, user, briefChat, date, time, status;

  const MyMessage({
    super.key,
    required this.imgUrl,
    required this.user,
    required this.briefChat,
    required this.date,
    required this.time,
    required this.status,
    //required this.openRoom,
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
            //onTap: openRoom,
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
                            user,
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
                            briefChat,
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
                      Text(
                        date,
                        style: TextStyle(
                            color: myColors.backgoundColor.withOpacity(0.5),
                            fontSize: 14),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            color: myColors.backgoundColor.withOpacity(0.5),
                            fontSize: 12),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          status,
                          style: TextStyle(
                              color: myColors.backgoundColor.withOpacity(0.5),
                              fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
