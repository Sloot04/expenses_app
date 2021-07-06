import 'package:flutter/material.dart';

class EventModel with ChangeNotifier {
  Map<DateTime, List<Event>> _selectedEvents = {};
  TextEditingController _eventController = TextEditingController();

  Map<DateTime, List<Event>> get selectedEvents => this._selectedEvents;

  TextEditingController get eventController => this._eventController;

  set selectedEvents(Map<DateTime, List<Event>> event) {
    selectedEvents[event]!.add(
      Event(title: eventController.text),
    );
    notifyListeners();
  }

  set eventController(TextEditingController controller) {
    this._eventController = controller;
    notifyListeners();
  }

  List<Event> getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
}

class Event {
  final String title;

  Event({required this.title});

  String toString() => this.title;
}
