class main_list_model{
  String? type;
  String? eng_name;
  String? ar_name;
  String? text;
  String? count;
  String? time;
  String? terms;
  String? price;
  bool? with_location;
  bool? is_soon;
  bool? is_plate;
  List<all_kind_model>? all_kind=[];
  List<String>? text_slot=[];
  List<String>? file_slot=[];
  main_list_model.fromjson(Map<String,dynamic> json,counta,timea){
     type=json['type'];
     json['all_kind'].toString().split("*").forEach((element) {
      all_kind?.add(all_kind_model.fromjson(element));
     });
     eng_name=json['eng_name'];
     ar_name=json['ar_name'];
     is_soon=json['is_soon'].toString()=="1";
     is_plate=json['is_plate'].toString()=="1";
     price=json['price'].toString();
     terms=json['terms'];
     with_location=json['with_location'] == 1 ? true : false;
     count=counta.toString();
     time=timea.toString();
     text_slot =json["text_slot"]==null ?null : json["text_slot"].toString().split("|");
     file_slot = json["file_solt"]==null ?null :json["file_solt"].toString().split("|");
  }
}
class all_kind_model{
  String? kind;
  String? img;
  String? time;
  String? main_data;
  all_kind_model.fromjson(json){
    kind=json.toString().split("|")[0];
    img=json.toString().split("|")[1];
    time=json.toString().split("|")[2];
    main_data=json.toString().split("|")[3];
  }
}