import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class StudentFeeDetailsWidget extends StatelessWidget {
  const StudentFeeDetailsWidget({
    super.key, required this.isTeacher,
  });
final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appbarColor,
      ),
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
              child:isTeacher? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape:
                          const ContinuousRectangleBorder(
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
                  )):null
            ),
          ],
        ),
      ),
    );
  }
}