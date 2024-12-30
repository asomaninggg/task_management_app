import 'package:flutter/material.dart';
import 'package:beginner/task_management_app/calendar.dart';
import 'package:beginner/task_management_app/taskPage.dart';
import 'package:beginner/task_management_app/account_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beginner/task_management_app/blocs/task_bloc.dart';
import 'package:beginner/task_management_app/blocs/task_event.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String id;
  String title;
  DateTime time;
  String description;

  Task({
    required this.id,
    required this.title,
    required this.time,
    required this.description,
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? time,
    String? description,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc()..add(const LoadTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  Widget getCurrentPage() {
    if (currentIndex == 0) {
      return CalendarScreen();
    } else if (currentIndex == 1) {
      return taskPage();
    } else {
      return AccountPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Planner'),
      ),
      body: getCurrentPage(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff827575),
              ),
              child: Text('Planner'),
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Holidays'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Meetings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: 'Tasks',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index; // Update the current index
          });
        },
      ),
    );
  }
}
