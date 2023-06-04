class add_model{
  String? state;
  String? id;
  String? type;
  String? auc_status;
  String? name;
  String? time;
  String? price;
  bool? is_wait;
  add_model.fromjson(json,json2,_is_wait){
    state = json.toString().split("|")[0];
    id = json.toString().split("|")[1];
    type = json.toString().split("|")[2];
    auc_status=json2['status'].toString();
    name=json2['name'];
    is_wait=_is_wait;
    price=json2['price'].toString()??"";
    time= json2['created_at'];
  }
}