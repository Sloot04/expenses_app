import 'package:expenses_app/src/model/event_model.dart';

class Recordatorio {
  int? id;
  String recordatorio;
  int fecha;

  Recordatorio({this.id, required this.recordatorio, required this.fecha});
 
 Map<String, dynamic> toMap(){
   return {"id": id, "recordatorio": recordatorio, "fecha": fecha };
 }

 static Recordatorio fromEvent(Event event){
  return Recordatorio(
      recordatorio: event.title,
      fecha: (event.date.millisecondsSinceEpoch / 1000).floor(),
    );
 }

 Event toEvent(){
   return Event(date:DateTime.fromMillisecondsSinceEpoch(this.fecha * 1000) , title: this.recordatorio);
 }

}