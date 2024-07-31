import 'package:flutter/material.dart';
import 'package:ndao_hitafa/components/my_button.dart';
import 'package:ndao_hitafa/themes/light_mode.dart';

class MyInvitations extends StatelessWidget {
  final void Function()? onTap;
  final String imgUrl, username, email, label;

  const MyInvitations({
    super.key,
    required this.imgUrl,
    required this.username,
    required this.email,
    required this.label,
    required this.onTap,
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
            onTap: () {},
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
                  padding: EdgeInsets.only(right: 0),
                  child: MyButton2(
                    text: label,
                    onTap: onTap,
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
