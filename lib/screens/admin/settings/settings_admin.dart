import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  
                ],
              ),
            );
          },
        ));
  }
}


