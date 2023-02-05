class fav_model{
  String? name;
  String? type;
  String? id;
  String? time;
  String? status;
  String? sub;
  fav_model.fromjson(names,times,types,ids,sttatus,ssub){
    if(ssub != " "&&ssub!= ""&&ssub!=null) sub =ssub.toString().split(",")[0].split("|")[0].replaceAll("-", "");
    name =names.toString();
     time =times.toString();
     type = types.toString();
     id = ids.toString();
     status = sttatus.toString();
  }
}