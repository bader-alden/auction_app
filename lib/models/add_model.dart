class add_model{
  String? state;
  String? id;
  String? type;
  String? auc_status;
  String? name;
  String? time;
  add_model.fromjson(json,json2){
    state = json.toString().split("|")[0];
    id = json.toString().split("|")[1];
    type = json.toString().split("|")[2];
    auc_status=json2['status'].toString();
    name=json2['name'];
    time= json2['created_at'];
  }
}