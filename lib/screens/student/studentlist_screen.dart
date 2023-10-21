import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';

class ScreenStudentList extends StatelessWidget {
  const ScreenStudentList(
      {super.key, });
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text('Class 1',
            style: GoogleFonts.tiltNeon(
                fontSize: 20,
                color: headingColor,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: headingColor,
            )),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: scaffoldColor,
                  border: Border.all(color: headingColor, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(index % 2 == 0
                          ? 'lib/assets/images/student male.jpg'
                          : 'lib/assets/images/student female.png'),
                    ),
                  ),
                  const Padding( 
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Name : surya',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
