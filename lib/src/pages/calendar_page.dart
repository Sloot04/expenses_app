import 'package:expenses_app/src/model/recordatorios_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<RecordatoriosModel>> selectedRecordatorios;

  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _format = CalendarFormat.month;

  @override
  void initState() {
    selectedRecordatorios = {};
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    super.initState();
  }

  List<RecordatoriosModel> _getEventsfromDay(DateTime date) {
    return selectedRecordatorios[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            focusedDay: _focusedDay,
            lastDay: DateTime.now().add(Duration(days: 365)),
            daysOfWeekVisible: true,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) =>
                isSameDay(_selectedDay, day),
            calendarFormat: _format,
            onFormatChanged: (CalendarFormat format) {
              setState(() => _format = format);
            },
            eventLoader: _getEventsfromDay,
            //Estilos
            headerStyle: HeaderStyle(
              titleCentered: true,
              headerPadding: EdgeInsets.symmetric(vertical: 35),

              //format button
              formatButtonVisible: true,
              formatButtonShowsNext: false,
              //formatButtonDecoration: BoxDecoration(color: Colors.red)
            ),
          ),
          TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Add Recordatorio"),
                        content: Text("Enter Recordatorio Title"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Ok")),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"))
                        ],
                      )),
              child: Text("Agregar Recordatorio")),
        ],
      ),
    );
  }
}
