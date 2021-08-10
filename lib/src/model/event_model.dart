import 'package:dartz/dartz.dart';
import 'package:expenses_app/src/db/db.dart';
import 'package:expenses_app/src/db/recordatorios_db.dart';
import 'package:flutter/material.dart';

class EventModel with ChangeNotifier {
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

  Future<List<Tuple2<EventId, Event>>> getEventsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    List<Recordatorio> recordatorios = await DB.getByDate(start, end);
    return recordatorios.map((r) {
      return Tuple2(EventId(r.id!), r.toEvent());
    }).toList();
  }

  Future<List<Tuple2<EventId, Event>>> getEventsByDay(DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = DateTime(day.year, day.month, day.day, 23, 59, 59);

    return await this.getEventsByDateRange(start, end);
  }
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
