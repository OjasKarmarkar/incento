import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:incento_demo/Const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

showGetDialog(String title, String message) {
  Get.defaultDialog(
    radius: 10,
    textCancel: "Okay",
    cancelTextColor: accentColor,
    buttonColor: accentColor,
    contentPadding: EdgeInsets.all(10),
    title: title,
    content: Text(message),
  );
}

Widget circularIconButton(IconData ic, Function onpressed) {
  return ElevatedButton(
    onPressed: () => onpressed(),
    child: Icon(
      ic,
      color: Colors.black,
      size: 18,
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      fixedSize: const Size(55, 55),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(20),
      backgroundColor: Color(0xfff1f6f9), // <-- Button color
      foregroundColor: Colors.white, // <-- Splash color
    ),
  );
}

Widget memberCard() {
  return Container(
    width: double.infinity,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 35.0,
                  child: CircleAvatar(
                    radius: 33.0,
                    child: ClipOval(
                      child: SvgPicture.asset('assets/images/profile.svg'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ojas Karmarkar',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ',
                          style: TextStyle(fontSize: 12))
                    ],
                  ),
                )
              ],
            ),
            MasonryGridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Icon(
                        FeatherIcons.mapPin,
                        color: accentColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Hello",
                      )
                    ],
                  );
                })
          ],
        ),
      ),
    ),
  );
}

showSnackbar(String type, String content) {
  Get.snackbar(type, content);
}
