import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/form/newstudent_form.dart';
import 'package:schoolapp/screens/teacher/profile/student_profile.dart';

class TeacherStudentsList extends StatelessWidget {
  const TeacherStudentsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherBloc, TeacherState>(
      listener: (context, state) {
        if (state is FormStudentState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenStudentForm(), 
              ));
        } else if (state is StudentProfileState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenStudentProfileTeacher(),
              ));
        }
      },
      builder: (context, state) {
        return SizedBox(
            height: 130,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [ 
                      GestureDetector(
                        onTap: () => context
                            .read<TeacherBloc>()
                            .add(FormStudentEvent()),
                        child: CircleAvatar(
                          backgroundColor: appbarColor,
                          radius: 40,
                          child: const Icon(Icons.add,
                              size: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Add Student',
                        style: teacherAddStudentTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () => context
                              .read<TeacherBloc>()
                              .add(StudentProfileEvent()),
                          child: CircleAvatar(
                            backgroundColor: appbarColor,
                            backgroundImage: AssetImage(index % 2 == 0
                                ? 'lib/assets/images/student male.jpg'
                                : 'lib/assets/images/student female.png'),
                            radius: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'name',
                          style: teacherAddStudentTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}