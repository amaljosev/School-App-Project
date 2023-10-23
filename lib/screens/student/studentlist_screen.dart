import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';

bool isExpanded = true;

class ScreenStudentList extends StatelessWidget {
  const ScreenStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text('Class 1',
            style: appbarTextStyle), 
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: headingColor,
            )),
      ),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentTileOpenState) {
            isExpanded = state.isExpanded;
          } else if (state is StudentTileCloseState) {
            isExpanded = state.isExpanded;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: headingColor),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  tilePadding: const EdgeInsets.all(10),
                  backgroundColor: appbarColor,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(index % 2 == 0
                        ? 'lib/assets/images/student male.jpg'
                        : 'lib/assets/images/student female.png'),
                  ),
                  title: Text('name',style: titleTextStyle,), 
                  trailing: Icon(
                    isExpanded
                        ? Icons.arrow_drop_down_circle
                        : Icons.arrow_drop_down,
                  ),
                  onExpansionChanged: (bool expanded) {
                    context
                        .read<StudentBloc>()
                        .add(StudentTileTapEvent(isExpanded: expanded));
                  },
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                               Text('class',style: contentTextStyle,), 
                                Text('class teacher',style: contentTextStyle,),
                              Text('email',style: contentTextStyle,),
                              Text('age',style: contentTextStyle,), 
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
   
