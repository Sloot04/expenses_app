import 'package:expenses_app/src/db/db.dart';
import 'package:expenses_app/src/db/recordatorios_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:expenses_app/src/model/theme_changer_model.dart';
import 'package:expenses_app/src/model/event_model.dart';
import 'package:expenses_app/src/model/languaje_model.dart';
import 'package:expenses_app/src/widgets/title_custom.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeChangerModel>(context);

    final getEventsfromDay =
        Provider.of<EventModel>(context).getEventsfromDay(_selectedDay);
    final languajeModel = Provider.of<LanguajeModel>(context);

    return Scaffold(
      
      backgroundColor: colors.backgroundColor,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 45, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleCustom(
              title: languajeModel.reminders,
              icon: FontAwesomeIcons.clock,
              titleColor: colors.titleColor,
            ),

            calendarBuilder(),
            Expanded(child: bottomRecordatorioBuilder(context)),
           
           
            //Lista de Recordatorios
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ...getEventsfromDay.map(
                    (Event event) => Column(
                      children: [
                        Text(event.title,
                            style: TextStyle(
                                fontSize: 18,
                                color: colors.titleColor,
                                fontWeight: FontWeight.w300)),
                        Divider(
                          indent: 60,
                          endIndent: 60,
                          color: colors.titleColor.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton bottomRecordatorioBuilder(BuildContext context) {
    final isDark = Provider.of<ThemeChangerModel>(context).isDark;
    final colors = Provider.of<ThemeChangerModel>(context);
    final eventController = Provider.of<EventModel>(context).eventController;
    final selectedEvents = Provider.of<EventModel>(context).selectedEvents;
    final languajeModel = Provider.of<LanguajeModel>(context);

    return TextButton(
        onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
                actionsPadding: EdgeInsets.symmetric(horizontal: 15),
                insetPadding: EdgeInsets.symmetric(horizontal: 65),
                title: Text(
                  languajeModel.addReminders,
                  style: TextStyle(
                      color: colors.titleColor, fontWeight: FontWeight.w300),
                ),
                contentPadding: EdgeInsets.all(0),
                contentTextStyle: TextStyle(fontSize: 0),
                actionsOverflowButtonSpacing: 10,
                actions: [
                  TextFormField(
                    autofocus: true,
                    cursorColor: colors.titleColor,
                    style: TextStyle(color: colors.titleColor),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colors.titleColor)),
                    ),
                    controller: eventController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(languajeModel.cancel,
                              style: TextStyle(color: colors.titleColor))),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                          onPressed: () async {
                            await DB.insert(Recordatorio(
                                recordatorio: eventController.text,
                                fecha: _selectedDay.toString()));
                            if (eventController.text.isEmpty) {
                            } else {
                              if (selectedEvents[_selectedDay] != null) {
                                selectedEvents[_selectedDay]!.add(
                                  Event(title: eventController.text),
                                );
                              } else {
                                selectedEvents[_selectedDay] = [
                                  Event(title: eventController.text)
                                ];
                              }
                              Navigator.pop(context);
                              eventController.clear();
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
        child: Text(languajeModel.addReminders,
            style: TextStyle(
                color: colors.titleColor, fontWeight: FontWeight.w300)));
  }

  TableCalendar<Event> calendarBuilder() {
    final colors = Provider.of<ThemeChangerModel>(context);
    final eventModel = Provider.of<EventModel>(context);
    final languajeModel = Provider.of<LanguajeModel>(context);

    return TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        weekendDays: [DateTime.sunday],
        locale: languajeModel.isSpanish ? "es_ES" : "en_US",
        focusedDay: _focusedDay,
        lastDay: DateTime.now().add(Duration(days: 730)),
        startingDayOfWeek: StartingDayOfWeek.sunday,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        selectedDayPredicate: (DateTime day) => isSameDay(_selectedDay, day),
        eventLoader: (_selectedDay) =>
            eventModel.getEventsfromDay(_selectedDay),

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
          headerPadding: EdgeInsets.only(top: 25, bottom: 15),
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
              color: Colors.green.withOpacity(colors.opacity),
              shape: BoxShape.circle),
          selectedDecoration:
              BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          outsideTextStyle: TextStyle(color: Colors.grey.shade500),
          defaultTextStyle:
              TextStyle(color: colors.titleColor.withOpacity(0.8)),
          weekendTextStyle: TextStyle(color: Colors.red.shade300),
          markersMaxCount: 1,
          markerDecoration:
              BoxDecoration(color: colors.titleColor, shape: BoxShape.circle),
        ));
  }
}
