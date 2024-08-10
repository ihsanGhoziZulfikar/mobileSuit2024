import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/first_screen.dart';
import 'package:flutter_application_1/provider/name_provider.dart';
import 'package:flutter_application_1/provider/selected_user_provider.dart';
import 'package:flutter_application_1/themes/default.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedUserProvider()),
        ChangeNotifierProvider(create: (_) => NameProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ihsan Ghozi Zulfikar',
      theme: defaultTheme,
      home: const FirstScreen(),
    );
  }
}
