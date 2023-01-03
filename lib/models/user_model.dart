class user_models{
  String? name;
  String? email;
  String? pass;
  String?national_id ;
  String? mobile_id;
  String? address;
  String? gsm_token;
  List<String>? fav;
  user_models.fromjson(json){
   // email = emaila.toString();
  //  pass = passs.toString();
    name = json["name"].toString();
  //  national_id  = json["Identification-num"].toString();
    mobile_id = json["mobile_id"].toString();
   // address = json["address"].toString();
    gsm_token = json["gsm_token"].toString();
    fav = json["fav"].toString().split("-");
  }
}