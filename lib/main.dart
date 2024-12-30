import 'package:beginner/task_management_app/login_logout_page/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'task_management_app/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyApp());
  }
}
