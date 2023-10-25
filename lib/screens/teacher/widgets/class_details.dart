
import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class ClassDetailsWidget extends StatelessWidget {
  const ClassDetailsWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: size.width * 0.97,
        decoration: BoxDecoration(
            color: appbarColor,
            borderRadius:
                const BorderRadius.all(Radius.circular(10))), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class 1',
                    style: appbarTextStyle,
                  ),
                  Text(
                    'Class Strength :30',
                    style: contentTextStyle,
                  ),
                  Text(
                    'Boys : 18',
                    style: contentTextStyle,
                  ),
                  Text(
                    'Girls : 12',
                    style: contentTextStyle,
                  ),
                  Text(
                    'Today Presents :26',
                    style: contentTextStyle,
                  ),
                  Text(
                    'Today Absents : 4',
                    style: contentTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Take Attendence')),
            ),
          ],
        ),
      ),
    );
  }
}


