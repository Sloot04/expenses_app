import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          focusedDay: _focusedDay,
          lastDay: DateTime.now().add(Duration(days: 365)),
          selectedDayPredicate: (day) => _selectedDay == day,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              _selectedDay = selectedDay;
            });
          },
        ),
      ),
    );
  }
}
