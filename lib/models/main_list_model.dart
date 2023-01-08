class main_list_model{
  String? type;
  String? eng_name;
  String? ar_name;
  String? detail;
  String? text;
  String? count;
  String? time;
  bool? is_auction;
  List<all_kind_model>? all_kind=[];
  List<String>? text_slot=[];
  List<String>? file_slot=[];
  main_list_model.fromjson(Map<String,dynamic> json,counta,timea,is_auc){
     type=json['type'];
     text=json['text'];
     json['all_kind'].toString().split("*").forEach((element) {
      all_kind?.add(all_kind_model.fromjson(element));
     });
     eng_name=json['eng_name'];
     ar_name=json['ar_name'];
     detail=json['detail'];
     is_auction=is_auc == 1 ? true : false;
     count=counta.toString();
     time=timea.toString();
     text_slot = json["text_slot"].toString().split("|");
     file_slot = json["file_slot"].toString().split("|");
  }
}
class all_kind_model{
  String? kind;
  String? img;
  all_kind_model.fromjson(json){
    kind=json.toString().split("|")[0];
    img=json.toString().split("|")[1];
  }
}