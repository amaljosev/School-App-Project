import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

bool? isSelected = false;

class ScreenSettingsAdmin extends StatelessWidget {
  const ScreenSettingsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar('Settings'),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is ShowWarningPopUpState) {
              acadamicChangeAlert(context);
            }
            if (state is CheckboxSelectedState) {
              isSelected = state.isSelected;
              acadamicChangeAlert(context);
            }
            if (state is LogOutState) {
              logOut(context);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Sign out'),
                    trailing: const Icon(Icons.power_settings_new_outlined),
                    onTap: () => context.read<AdminBloc>().add(LogOutEvent()),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Complete the Acadamic Year'),
                    trailing: const Icon(Icons.navigate_next_outlined),
                    onTap: () =>
                        context.read<AdminBloc>().add(ShowAlertEvent()),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ));
  }
}

FutureOr<void> acadamicChangeAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are You Sure !'),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: headingColor),
        content: const Text(
          '''This action for go next Acadamic Year. If you pressed the conform button the last class will cleard and every class got premoted to next class, and the first standard teacher need to sign up again.''',
        ),
        actions: <Widget>[
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (value) {
                  context
                      .read<AdminBloc>()
                      .add(CheckBoxTapEvent(isSelected: value ?? false));
                  Navigator.of(context).pop();
                },
              ),
              const Text('Accept and Continue')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: isSelected != null && isSelected!
                    ? () => Navigator.of(context).pop()
                    : null,
                child: const Text('Conform'),
              ),
              TextButton(
                child: const Text('Discard'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
