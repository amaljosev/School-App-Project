import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';

class ScreenStudentProfileTeacher extends StatelessWidget {
  const ScreenStudentProfileTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( 
            onPressed: () { 
              Navigator.of(context).pop();
              context
                  .read<TeacherBloc>()
                  .add(BottomNavigationEvent(currentPageIndex: 0)); 
            },
            icon: const Icon(Icons.arrow_back)),
            title: const Text('Student Profile'),
            backgroundColor: appbarColor, 
      ),
      body: WillPopScope(
        onWillPop: () => toHome(context), 
        child: SingleChildScrollView(
          child: Column(
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
                              AssetImage('lib/assets/images/student female.png'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text('Student Name ',
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
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appbarColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("RollNo :", style: studentProfileTextStyle),
                                Text('Name :', style: studentProfileTextStyle),
                                Text('Age :', style: studentProfileTextStyle),
                                Text('Class :', style: studentProfileTextStyle),
                                Text('RegisterNo :',
                                    style: studentProfileTextStyle),
                                Text('ContactNo :',
                                    style: studentProfileTextStyle),
                                Text('Guardian Name :',
                                    style: studentProfileTextStyle),
                                Text('Email :', style: studentProfileTextStyle),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(" 1", style: studentProfileTextStyle),
                                Text(' Akhila', style: studentProfileTextStyle),
                                Text(' 22', style: studentProfileTextStyle),
                                Text(' 5', style: studentProfileTextStyle),
                                Text(' 1965478', style: studentProfileTextStyle),
                                Text(' 97584685321',
                                    style: studentProfileTextStyle),
                                Text(' Krishna', style: studentProfileTextStyle),
                                Text(' diljith@gmail.com',
                                    style: studentProfileTextStyle),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  fixedSize: const Size(100, 30),
                                  elevation: 10),
                              onPressed: () {},
                              icon: const Icon(Icons.edit, color: whiteTextColor),
                              label: const Text(
                                'Edit',
                                style: TextStyle(color: whiteTextColor),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: size.height * 0.40,
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: 200,
                          width: size.width * 0.85,
                          decoration: BoxDecoration(
                              color: appbarColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Attendence Details',
                                  style: titleTextStyle,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.deepPurple.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: CircularPercentIndicator(
                                        animation: true,
                                        animateFromLastPercent: true,
                                        radius: 60.0,
                                        lineWidth: 9.0,
                                        percent: 0.70,
                                        center: const Text("75%"),
                                        progressColor: buttonColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total working Days Completed ',
                                          style: contentTextStyle,
                                        ),
                                        Text(
                                          'Total Present Days',
                                          style: contentTextStyle,
                                        ),
                                        Text(
                                          'Total Missed Days',
                                          style: contentTextStyle,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ': 140',
                                          style: contentTextStyle,
                                        ),
                                        Text(
                                          ': 120',
                                          style: contentTextStyle,
                                        ),
                                        Text(
                                          ': 20',
                                          style: contentTextStyle,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 100,
                          width: size.width * 0.75,
                          decoration: BoxDecoration(
                              color: appbarColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Fee Details',
                                  style: titleTextStyle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total Amount :',
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            'Amount Paied :',
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            'Amount Pending :',
                                            style: contentTextStyle,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' ₹25000',
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            ' ₹25000',
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            ' 0',
                                            style: contentTextStyle,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor,
                                          shape: const ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          fixedSize: const Size(100, 30),
                                          elevation: 10),
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit,
                                          color: whiteTextColor),
                                      label: const Text(
                                        'Edit',
                                        style: TextStyle(color: whiteTextColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
