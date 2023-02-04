import 'package:ddd_tutorial/presentation/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class AppWiget extends StatelessWidget {
  const AppWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.light().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: Colors.blueAccent, primary: Colors.red[800]),
          inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}
