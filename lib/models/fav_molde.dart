class fav_model{
  String? name;
  String? type;
  String? id;
  String? time;
  fav_model.fromjson(names,times,types,ids){
     name =names.toString();
     time =times.toString();
     type = types.toString();
     id = ids.toString();
  }
}