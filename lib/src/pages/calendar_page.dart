import 'package:animate_do/animate_do.dart';
import 'package:expenses_app/src/widgets/title_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        child: Column(
          children: [
            SizedBox(height: 40.0),
              TitleCustom(title: 'Recordatorios', icon:FontAwesomeIcons.clock),
              SizedBox(height: 25.0),
            TableCalendar(
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
          ],
        ),
      ),
    );
  }
}

