import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class StudentAttendenceDetailsWidget extends StatelessWidget {
  const StudentAttendenceDetailsWidget({
    super.key,
    required this.size,
    required this.studentsMap,
    required this.totalWorkingDaysCompleted,
  });

  final Size size;
  final Map<String, dynamic>? studentsMap;
  final int totalWorkingDaysCompleted;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? 0.9 * MediaQuery.of(context).size.height   
                : 0.4 * MediaQuery.of(context).size.height, 
                width: MediaQuery.of(context).orientation == Orientation.landscape
                ? 0.5 * MediaQuery.of(context).size.width     
                : 0.4 * MediaQuery.of(context).size.height,     
            decoration: BoxDecoration(
                color: appbarColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ': $totalWorkingDaysCompleted',
                            style: contentTextStyle,
                          ),
                          Text(
                            ': ${studentsMap?['total_present_days']}',
                            style: contentTextStyle,
                          ),
                          Text(
                            ': ${studentsMap?['total_missed_days']}',
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
        ],
      ),
    );
  }
}
