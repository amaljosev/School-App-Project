import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class StudentDetailsWidget extends StatelessWidget {
  const StudentDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 270,
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
                      Text('Class Teacher :', style: studentProfileTextStyle),
                      Text('Age :', style: studentProfileTextStyle),
                      Text('Class :', style: studentProfileTextStyle),
                      Text('RegisterNo :', style: studentProfileTextStyle),
                      Text('ContactNo :', style: studentProfileTextStyle),
                      Text('Guardian Name :', style: studentProfileTextStyle),
                      Text('Email :', style: studentProfileTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" 1", style: studentProfileTextStyle),
                      Text('emil ', style: studentProfileTextStyle),
                      Text(' Akhila', style: studentProfileTextStyle),
                      Text(' 22', style: studentProfileTextStyle),
                      Text(' 5', style: studentProfileTextStyle),
                      Text(' 1965478', style: studentProfileTextStyle),
                      Text(' 97584685321', style: studentProfileTextStyle),
                      Text(' paul', style: studentProfileTextStyle),
                      Text(' pual@gmail.com', style: studentProfileTextStyle),
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
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
    );
  }
}
