import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:expenses_app/src/model/theme_changer_model.dart';
import 'package:expenses_app/src/model/event.dart';
import 'package:expenses_app/src/widgets/title_custom.dart';
import 'package:provider/provider.dart';
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
    final isDark = Provider.of<ThemeChangerModel>(context).isDark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black87 : Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40.0),
            TitleCustom(
              title: 'Recordatorios',
              icon: FontAwesomeIcons.clock,
              titleColor: isDark ? Colors.white : Colors.black,
            ),
            SizedBox(height: 25.0),
            calendarBuilder(),
            bottomRecordatorioBuilder(context),
            SizedBox(height: 20),

            //Lista de Recordatorios
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ..._getEventsfromDay(_selectedDay).map(
                    (Event event) => Column(
                      children: [
                        Text(event.title, style: TextStyle(fontSize: 18)),
                        Divider(indent: 60, endIndent: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  TextButton bottomRecordatorioBuilder(BuildContext context) {
    final isDark = Provider.of<ThemeChangerModel>(context).isDark;
    return TextButton(
        onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                 
                backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
                actionsPadding: EdgeInsets.symmetric(horizontal: 15),
                insetPadding: EdgeInsets.symmetric(horizontal: 65),
                title: Text(
                  "Agregar Recordatorio",
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                contentPadding: EdgeInsets.all(0),
                contentTextStyle: TextStyle(fontSize: 0),
                actionsOverflowButtonSpacing: 10,
                actions: [
                  TextFormField(
                    cursorColor: isDark? Colors.white : Colors.black,
                     style: TextStyle(color: isDark? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: isDark? Colors.white : Colors.black)),
                    ),
                    controller: _eventController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel",
                              style: TextStyle(
                                  color:
                                      isDark ? Colors.white : Colors.black))),
                      SizedBox(
                        width: 5,
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
                              return;
                            }
                          },
                          child: Text("Ok",
                              style: TextStyle(
                                  color:
                                      isDark ? Colors.white : Colors.black))),
                    ],
                  ),
                ],
              ),
            ),
        child: Text("Agregar Recordatorio",
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w300)));
  }

  TableCalendar<Event> calendarBuilder() {
    return TableCalendar(
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
        selectedDayPredicate: (DateTime day) => isSameDay(_selectedDay, day),
        eventLoader: _getEventsfromDay,

        //Estilos

        headerStyle: HeaderStyle(
          titleCentered: true,
          headerPadding: EdgeInsets.symmetric(vertical: 35),
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          markersMaxCount: 1,
        ));
  }
}
