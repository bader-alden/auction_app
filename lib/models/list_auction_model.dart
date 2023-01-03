class list_auction_model{
  String? name;
  String? id;
  String? kind;
  String? num;
  String? num_add;
  String? num_price;
  String? price;
  String? time;
  String? photo;
  List<String>? photos;
  List<String>? sub;
  String? log;
  String? des;
  String? city;
  bool? is_auction;
  String? status;
  List<String>? location = [];
  auction_details_list_model? text_1;
  auction_details_list_model? text_2;
  auction_details_list_model? text_3;
  auction_details_list_model_file? file_1;
  auction_details_list_model_file? file_2;
  auction_details_list_model_file? file_3;
  list_auction_model.fromjson(json){
    name = json['name'];
     id = json['id'].toString();
     kind = json['kind'].toString();
     num = json['num'].toString();
     num_add = json['num_add'].toString();
     num_price = json['min_price'].toString();
     price = json['price'].toString();
     time = json['created_at'].toString();
     photo = json['photo'].toString();
     photos = json['photos'].toString().split("|");
     sub = json['sub'].toString().split(",");
     log = json['log'].toString();
     des = json['des'].toString();
     city = json['city'].toString();
     status = json['status'].toString();
     is_auction = json['is_auction'] == 1 ? true : false;
     text_1 = json['text_slot_1'] == null || json['text_slot_1'] == " " || json['text_slot_1'] == ""? null : auction_details_list_model.fromjson(json['text_slot_1']);
     text_2 = json['text_slot_2'] == null || json['text_slot_2'] == " "|| json['text_slot_2'] == "" ? null : auction_details_list_model.fromjson(json['text_slot_2']);
     text_3 = json['text_slot_3'] == null || json['text_slot_3'] == " "|| json['text_slot_3'] == "" ? null : auction_details_list_model.fromjson(json['text_slot_3']);
      location = json["location"] ==null ||  json["location"] == " "||  json["location"] == "" ? null: json['location'].toString().split(",");
    file_1 = json['file_slot_1'] == null || json['file_slot_1'] == " "|| json['file_slot_1'] == "" ? null : auction_details_list_model_file.fromjson(json['file_slot_1']);
    file_2 = json['file_slot_2'] == null || json['file_slot_2'] == " "|| json['file_slot_2'] == "" ? null : auction_details_list_model_file.fromjson(json['file_slot_2']);
    file_3 = json['file_slot_3'] == null || json['file_slot_3'] == " "|| json['file_slot_3'] == "" ? null : auction_details_list_model_file.fromjson(json['file_slot_3']);
  }
}
class auction_details_list_model{

  List<String>? details;
  String? name;
  auction_details_list_model.fromjson(String json){
      name = json.split("-")[0];
      details = json.split("-")[1].split("،");
  }

}
class auction_details_list_model_file{
  String? link;
  String? name;
  auction_details_list_model_file.fromjson(String json){
    name = json.split("-")[0];
    link = json.split("-")[1];
  }}