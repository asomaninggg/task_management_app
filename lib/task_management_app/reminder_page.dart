import 'package:flutter/material.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification settings'),
      ),
      body: Center(
        child: Text(
          'Almost done',
        ),
      ),
    );
  }
}
