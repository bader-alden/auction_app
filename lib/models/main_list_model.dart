class main_list_model{
  String? type;
  String? eng_name;
  String? ar_name;
  String? detail;
  String? text;
  String? count;
  String? time;
  bool? is_auction;
  List<String>? all_kind;
  main_list_model.fromjson(Map<String,dynamic> json,counta,timea,is_auc){
     type=json['type'];
     text=json['text'];
     all_kind=json['all_kind'].toString().split("-");
     eng_name=json['eng_name'];
     ar_name=json['ar_name'];
     detail=json['detail'];
     is_auction=is_auc == 1 ? true : false;
     count=counta.toString();
     time=timea.toString();
  }
}