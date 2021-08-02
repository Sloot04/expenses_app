class Recordatorios {
  int id;
  String recordatorio;
  String fecha;

  Recordatorios({this.id = 0, required this.recordatorio, required this.fecha});
 
 Map<String, dynamic> toMap(){
   return {"id": id, "recordatorio": recordatorio, "fecha": fecha };
 }

}