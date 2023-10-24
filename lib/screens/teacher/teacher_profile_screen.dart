import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class ScreenTeacherProfile extends StatelessWidget {
  const ScreenTeacherProfile({super.key, required this.teacherData});
final Map<String, dynamic> teacherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Teacher Profile',
          style: appbarTextStyle,
        ),
        
        backgroundColor: appbarColor,
      ),
      body: Column(
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
                  child: Text(teacherData['name'].toString().toUpperCase(),  
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.teko(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: headingColor)),
                )
              ],
            ),
          ),
          Column(
            children: [
              Text("Class Teacher of : ${teacherData['class']}", 
                  overflow: TextOverflow.ellipsis,
                  style: contentTextStyle), 
              Text('Email : ${teacherData['email']}',  
                  overflow: TextOverflow.ellipsis,
                  style: contentTextStyle),
              Text('Mobile No : ${teacherData['contact']}', 
                  overflow: TextOverflow.ellipsis,
                  style: contentTextStyle), 
            ],
          ),
          
          Expanded(
            child: SizedBox(
              child: ListView.separated( 
                  itemBuilder: (context, index) =>
                      Text('${index + 1} leave asked'),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
