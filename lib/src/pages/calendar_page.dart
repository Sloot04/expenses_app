import 'package:expenses_app/src/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  TextEditingController _eventController = TextEditingController();
  late Map<DateTime, List<Event>> selectedEvents;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                focusedDay: _focusedDay,
                lastDay: DateTime.now().add(Duration(days: 365)),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (DateTime day) =>
                    isSameDay(_selectedDay, day),
                eventLoader: _getEventsfromDay,

                //Estilos
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  headerPadding: EdgeInsets.symmetric(vertical: 35),
                  formatButtonVisible: false,
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actionsPadding: EdgeInsets.symmetric(horizontal: 15),
                      insetPadding: EdgeInsets.symmetric(horizontal: 65),
                      title: Text("Agregar Recordatorio"),
                      contentPadding: EdgeInsets.all(0),
                      contentTextStyle: TextStyle(fontSize: 0),
                      actionsOverflowButtonSpacing: 10,
                      actions: [
                        TextFormField(
                          controller: _eventController,
                        ),
                        TextButton(
                            onPressed: () {
                              if (_eventController.text.isEmpty) {
                              } else {
                                if (selectedEvents[_selectedDay] != null) {
                                  selectedEvents[_selectedDay]!.add(
                                    Event(title: _eventController.text),
                                  );
                                } else {
                                  selectedEvents[_selectedDay] = [
                                    Event(title: _eventController.text)
                                  ];
                                }
                                Navigator.pop(context);
                                _eventController.clear();
                                setState(() {});
                                print(selectedEvents);
                                return;
                              }
                            },
                            child: Text("Ok")),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"))
                      ],
                    ),
                  ),
              child: Text("Agregar Recordatorio")),
          ..._getEventsfromDay(_selectedDay)
              .map((Event event) => ListTile(title: Text(event.title))),
        ],
      ),
    );
  }
}
