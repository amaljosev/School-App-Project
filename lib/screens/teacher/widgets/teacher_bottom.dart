import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class TeacherActions extends StatelessWidget {
  const TeacherActions({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: [
              Container(
                width: size.width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Time Table',
                    style: appbarTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: size.width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Leave Applications ',
                    style: appbarTextStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: size.width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Give an Assignment ',
                    style: appbarTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: size.width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Give a HomeWork ',
                    style: appbarTextStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: size.width * 0.50,
                height: 210,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Teacher\n Profile', 
                    style: appbarTextStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: size.width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Apply leave', 
                    style: appbarTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: size.width * 0.50,
                height: 100,
                decoration: BoxDecoration(
                  color: appbarColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Release a Notice', 
                    style: appbarTextStyle,
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}