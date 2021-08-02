class Recordatorio {
  int? id;
  String recordatorio;
  String fecha;

  Recordatorio({this.id, required this.recordatorio, required this.fecha});
 
 Map<String, dynamic> toMap(){
   return {"id": id, "recordatorio": recordatorio, "fecha": fecha };
 }

}