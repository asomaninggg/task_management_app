import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beginner/task_management_app/account_page.dart';
import 'taskformPage.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime currentDate = DateTime.now();
  List<DateTime> daysInMonth = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    generateDaysInMonth();
  }

  void _showCalendarDialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Details'),
          content: Column(
            mainAxisSize: MainAxisSize
                .min, // Ensures the dialog adjusts to the content's size
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              SizedBox(height: 20),
              //TaskformPage(),
              TextField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Generate days for the current month
  void generateDaysInMonth() {
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    daysInMonth = List<DateTime>.generate(
      lastDayOfMonth.day,
      (index) => DateTime(currentDate.year, currentDate.month, index + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff958f8f),
        title: Text(
          DateFormat('MMMM yyyy').format(currentDate).toUpperCase(),
          style: TextStyle(color: Color(0xff827575)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Color(0xffbfb8b8)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Days of the week header
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["M", "T", "W", "T", "F", "S", "S"]
                  .map((day) =>
                      Text(day, style: TextStyle(fontWeight: FontWeight.bold)))
                  .toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1.0,
              ),
              itemCount: daysInMonth.length,
              itemBuilder: (context, index) {
                DateTime day = daysInMonth[index];
                bool isSelected = day.day == currentDate.day;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskformPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xff8b8282) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
