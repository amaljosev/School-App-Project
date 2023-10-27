import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class TeacherPrfileWidget extends StatelessWidget {
  const TeacherPrfileWidget({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(color: appbarColor),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: headingColor,
                  radius: 60,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        AssetImage('lib/assets/images/teacher.jpg'),
                  ),
                ),
              ),
              Flexible(
                child: Text('Alexander'.toString().toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.teko(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: headingColor)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: appbarColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Class Teacher of : 5",
                    overflow: TextOverflow.ellipsis, style: contentTextStyle),
                Text('Email : teacher@gmail.com',
                    overflow: TextOverflow.ellipsis, style: contentTextStyle),
                Text('Mobile No : 79456132456',
                    overflow: TextOverflow.ellipsis, style: contentTextStyle),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  fixedSize: const Size(160, 30),
                  elevation: 10),
              onPressed: () {},
              icon: const Icon(Icons.edit, color: whiteTextColor),
              label: const Text(
                'Edit Profile',
                style: TextStyle(color: whiteTextColor),
              )),
        ),
      ],
    );
  }
}
