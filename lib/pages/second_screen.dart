import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_appbar.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/pages/third_screen.dart';
import 'package:flutter_application_1/provider/name_provider.dart';
import 'package:flutter_application_1/provider/selected_user_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedUser = context.watch<SelectedUserProvider>().selectedUser;
    final name = context.watch<NameProvider>().name;

    return Scaffold(
      appBar: const MyAppbar(title: "Second Screen"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      name ?? "No Name",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              selectedUser != null
                  ? "${selectedUser.firstName} ${selectedUser.lastName}"
                  : "Selected User Name",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
            MyButton(
              text: "Choose a User",
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThirdScreen(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
