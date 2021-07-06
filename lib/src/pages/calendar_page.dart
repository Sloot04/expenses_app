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
    final colors = Provider.of<ThemeChangerModel>(context);
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40.0),
            TitleCustom(
              title: 'Recordatorios',
              icon: FontAwesomeIcons.clock,
              titleColor: colors.titleColor,
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
                        Text(event.title, style: TextStyle(fontSize: 18, color: colors.titleColor, fontWeight: FontWeight.w300)),
                        Divider(indent: 60, endIndent: 60, color: colors.titleColor.withOpacity(0.7),),
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
    final colors = Provider.of<ThemeChangerModel>(context);
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
                      color: colors.titleColor, fontWeight: FontWeight.w300),
                ),
                contentPadding: EdgeInsets.all(0),
                contentTextStyle: TextStyle(fontSize: 0),
                actionsOverflowButtonSpacing: 10,
                actions: [
                  TextFormField(
                    cursorColor: colors.titleColor,
                    style: TextStyle(color: colors.titleColor),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colors.titleColor)),
                    ),
                    controller: _eventController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel",
                              style: TextStyle(color: colors.titleColor))),
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
                              style: TextStyle(color: colors.titleColor))),
                    ],
                  ),
                ],
              ),
            ),
        child: Text("Agregar Recordatorio",
            style: TextStyle(
                color: colors.titleColor, fontWeight: FontWeight.w300)));
  }

  TableCalendar<Event> calendarBuilder() {
    final colors = Provider.of<ThemeChangerModel>(context);
    return TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        weekendDays: [DateTime.sunday],
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
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: colors.titleColor,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: colors.titleColor,
          ),
          titleCentered: true,
          titleTextStyle: TextStyle(color: colors.titleColor),
          headerPadding: EdgeInsets.symmetric(vertical: 35),
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(color: Colors.green.withOpacity(colors.opacity), shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          outsideTextStyle: TextStyle(color: Colors.grey.shade500),
          defaultTextStyle:
              TextStyle(color: colors.titleColor.withOpacity(0.8)),
          weekendTextStyle: TextStyle(color: Colors.red.shade300),
          markersMaxCount: 1,
        ));
  }
}
