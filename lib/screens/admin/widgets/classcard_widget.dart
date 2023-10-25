import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';

class ClassCardWidget extends StatelessWidget {
  const ClassCardWidget({
    super.key,
    required this.teachersList,
  });

  final List teachersList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
            itemCount: teachersList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document =
                  teachersList[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () => context
                      .read<AdminBloc>()
                      .add(StudentCardTapEvent()),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: scaffoldColor,
                        border: Border.all(
                            color: headingColor, width: 2),
                        borderRadius:
                            const BorderRadius.all(
                                Radius.circular(5))),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 20),
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.teko(
                                fontSize: 45,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                                color: headingColor),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Class : ${data["class"]}',
                                  style: contentTextStyle),
                              Text(
                                  'Total Students : ${data["students"]}',
                                  style: contentTextStyle),
                              Flexible(
                                child: Text(
                                    'Class Teacher: ${data['name']} ',
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style:
                                        contentTextStyle),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
