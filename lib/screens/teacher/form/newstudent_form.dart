import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/utils/loading_snakebar.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/form/widgets/textfield_widgets.dart';
import 'package:schoolapp/screens/teacher/widgets/class_details.dart';

class ScreenStudentForm extends StatefulWidget {
  const ScreenStudentForm(
      {super.key,
      required this.isUpdate,
      required this.students,
      required this.studentId});
  final bool isUpdate;
  final Map<String, dynamic>? students;
  final String? studentId;
  @override
  State<ScreenStudentForm> createState() => _ScreenStudentFormState();
}

enum Gender { male, female }

final firstNameController = TextEditingController();
final secondNameController = TextEditingController();
final rollNoController = TextEditingController();
final guardianNameController = TextEditingController();
final ageController = TextEditingController();
final registrationNumberController = TextEditingController();
final emailController = TextEditingController();
final contactController = TextEditingController();
final passwordController = TextEditingController();

int totalStrength = 0;
int totalBoys = 0;
int totalGirls = 0;

class _ScreenStudentFormState extends State<ScreenStudentForm> {
  Gender? gender = Gender.female;
  late Stream<DocumentSnapshot<Object?>> teacherDatas = const Stream.empty();

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchTeacherDatasEvent());
    firstNameController.text = widget.students?['first_name'] ?? '';
    secondNameController.text = widget.students?['second_name'] ?? '';
    rollNoController.text = widget.students?['roll_no'] ?? '';
    guardianNameController.text = widget.students?['guardian_name'] ?? '';
    ageController.text = widget.students?['age'] ?? '';
    registrationNumberController.text = widget.students?['register_no'] ?? '';
    emailController.text = widget.students?['email'] ?? '';
    contactController.text = widget.students?['contact_no'] ?? '';
    passwordController.text = widget.students?['password'] ?? '';
    final sex = widget.students?['gender'] ?? '';
    sex == 'Gender.male' ? gender = Gender.male : Gender.female;
  }

  @override
  Widget build(BuildContext context) {
    final studentFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context),
        child: BlocConsumer<TeacherBloc, TeacherState>(
          listener: (context, state) {
            if (state is AddStudentLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                loadingSnakebarWidget(),
              );
            } else if (state is AddStudentSuccessState) {
              Navigator.pop(context);
              toTeacherHome(context);
              AlertMessages().alertMessageSnakebar(
                  context, 'Student Created Successfully', Colors.green);
            } else if (state is AddStudentErrorState) {
              AlertMessages().alertMessageSnakebar(
                  context, 'Student not Added', Colors.red);
            } else if (state is RadioButtonState) {
              gender = state.gender;
            } else if (state is FetchTeacherDataState) {
              teacherDatas = state.teacherDatas!;
            } else if (state is UpdateStudentDataState) {
              AlertMessages().alertMessageSnakebar(
                  context, 'DataUpdated Successfully', Colors.green);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return StreamBuilder<DocumentSnapshot>(
                stream: teacherDatas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    DocumentSnapshot<Object?> documentSnapshot = snapshot.data!;
                    Map<String, dynamic> data =
                        documentSnapshot.data() as Map<String, dynamic>? ?? {};
                    final String teacher = data['name'];
                    final String standard = data['class'];
                    totalStrength = classDatasGlobel?['total_students'] ?? '0';
                    totalBoys = classDatasGlobel?['total_boys'] ?? '0';
                    totalGirls = classDatasGlobel?['total_girls'] ?? '0';
                    return SafeArea(
                      child: Form(
                        key: studentFormKey,
                        child: TextFieldTilesWidgetAddStudent(
                            gender: gender,
                            studentId: widget.studentId,
                            widget: widget,
                            studentFormKey: studentFormKey,
                            teacher: teacher,
                            standard: standard),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      child: Center(child: Text('Something went wrong')),
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}
