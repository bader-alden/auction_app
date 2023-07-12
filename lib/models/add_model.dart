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

class add_plate{
  late int id ;
  late int ic ;
  add_plate.a(d,c){
    id=d;
    ic=c;
  }
  add_plate get car {
    return add_plate.a(1,2);
  }
  add_plate get transp_car {
    return add_plate.a(1,2);
  }
  add_plate get motor {
    return add_plate.a(1,2);
  }
}