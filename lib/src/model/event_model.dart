import 'package:dartz/dartz.dart';
import 'package:expenses_app/src/db/db.dart';
import 'package:expenses_app/src/db/recordatorios_db.dart';
import 'package:flutter/material.dart';

class EventModel with ChangeNotifier {
  Map<DateTime, List<Event>> _selectedEvents = {};
  TextEditingController _eventController = TextEditingController();

  Map<DateTime, List<Event>> get selectedEvents => this._selectedEvents;

  TextEditingController get eventController => this._eventController;

  /*  set selectedEvents(Map<DateTime, List<Event>> event) {
    selectedEvents[event]!.add(
      Event(title: eventController.text),
    );
    notifyListeners();
  } */

  set eventController(TextEditingController controller) {
    this._eventController = controller;
    notifyListeners();
  }

  List<Event> getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  Future<EventId> addEvent(Event event) async {
    final int x = await DB.insert(Recordatorio.fromEvent(event));
    notifyListeners();
    return EventId(x);
  }

  Future<EventId> deleteEvent(Event event) async {
    final int x = await DB.delete(Recordatorio.fromEvent(event));
    notifyListeners();
    return EventId(x);
  }

  Future<List<Tuple2<EventId, Event>>> getAllEvents() async {
    List<Recordatorio> recordatorios = await DB.getAll();

    return recordatorios.map((r) {
      return Tuple2(EventId(r.id!), r.toEvent());
    }).toList();
  }

  Future<List<Tuple2<EventId, Event>>> getEventsByDate(
      DateTime day) async {
    List<Recordatorio> recordatorios = await DB.getByDate(day);
    return recordatorios.map((r) {
      return Tuple2(EventId(r.id!), r.toEvent());
    }).toList();
  }

  /* Future<List<Tuple2<EventId, Event>>> getEventsByDate(
      DateTime start, DateTime end) async {
    List<Recordatorio> recordatorios = await DB.getByDate(start, end);
    return recordatorios.map((r) {
      return Tuple2(EventId(r.id!), r.toEvent());
    }).toList();
  } */
}

class EventId {
  final int id;
  EventId(this.id);
}

class Event {
  final String title;
  final DateTime date;

  Event({required this.date, required this.title});

  String toString() => this.title;
}
