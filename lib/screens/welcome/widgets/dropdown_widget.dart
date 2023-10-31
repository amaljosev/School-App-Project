import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';

class DropDownWidget extends StatelessWidget {
  DropDownWidget({
    super.key,
    required this.classNames,
    required this.index,
  });

  final List<String> classNames;
  int index;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      hintText: 'Class',
      menuHeight: 200,
      width: MediaQuery.of(context).size.width * 0.91,
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(appbarColor),
        elevation: const MaterialStatePropertyAll(10),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        filled: true,
        fillColor: loginTextfieldColor,
      ),
      onSelected: (value) {
        index = classNames.indexWhere((item) => item == value);

        return context
            .read<WelcomeBloc>()
            .add(DropdownMenuTapEvent(dropdownValue: value, onSelected: index));
      },
      dropdownMenuEntries:
          classNames.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
