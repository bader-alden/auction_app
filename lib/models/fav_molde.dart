class fav_model{
  String? name;
  String? type;
  String? id;
  String? time;
  String? status;
  fav_model.fromjson(names,times,types,ids,sttatus){
     name =names.toString();
     time =times.toString();
     type = types.toString();
     id = ids.toString();
     status = sttatus.toString();
  }
}