class add_model{
  String? state;
  String? id;
  String? type;
  add_model.fromjson(json){
    state = json.toString().split("|")[0];
    id = json.toString().split("|")[1];
    type = json.toString().split("|")[2];
  }
}