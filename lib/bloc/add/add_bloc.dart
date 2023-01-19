
import 'package:auction_app/cache.dart';
import 'package:auction_app/models/add_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:auction_app/dio.dart';
part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddEvent>((event, emit) {

    });
  }
  static AddBloc get(context) => BlocProvider.of(context);

List<add_model> add_list = [];
  void check_add(){
    int num =0;
    dio.get_data(url: "/account/my_auction",quary: {"id":cache.get_data("id")}).then((value) {
      print(value?.data[0]["my_auction"]);
      if(value?.data[0]["my_auction"] !=" " &&value?.data.isNotEmpty){
        value?.data[0]["my_auction"].toString().split(",").forEach((element) async {
          //print(element);
          if(element!= ""){

          }
          if(element!="" &&element.split("|")[0].toString()=="1" ){
            await dio.get_data(url: "/account/get_data", quary: {
              "id":element.split("|")[1] ,
              "type": element.split("|")[2],
            }).then((value) {
              print(value?.data!=null);
              print(value?.data.isEmpty);
              print(value?.data);
             if(value?.data.isNotEmpty){
               add_list.add(add_model.fromjson(element,value?.data[0]));
               num++;
             }
            });
          }
          if(element!="" &&element.split("|")[0].toString()=="0" ){
            await dio.get_data(url: "/account/get_data_wait", quary: {
              "id":element.split("|")[1],
              "type": element.split("|")[2],
            }).then((value) {
              if(value?.data[0]!=""){
                add_list.add(add_model.fromjson(element,value?.data[0]));
              }
            });
          }
        print("=="*50);
          if(add_list.length == num){
            print(add_list);
            emit(next());
          }
        });
      }else{
        print("ok"*20);
        emit(empty_state());
      }
    });
  }

  void add_void(my_id, name, des, price, min_price, num_day, city, type,location,text_slot_1,text_slot_2,text_slot_3,kind,name_text_1,name_text_2,name_text_3,main_data){
dio.post_data(
  url: "/post_auction",
  quary: {
  "user_id":  my_id ,
  "name":name ,
  "des":des ,
  "price":price ,
  "min_price":min_price ,
  "end_in":num_day ,
  "city":city ,
  "type":type ,
  "created_at":DateTime.now().add(Duration(days: int.parse(num_day))) ,
  "is_auction":1 ,
  "status":0 ,
  "num_add":0 ,
  "kind":kind,
  "location":location ,
  "file_slot_3":" " ,
  "file_slot_2":" " ,
  "file_slot_1":" " ,
  "text_slot_1":text_slot_1 == "" ?" ":name_text_1+"-"+text_slot_1 ,
  "text_slot_2":text_slot_2 == "" ?" ":name_text_2+"-"+text_slot_2 ,
  "text_slot_3":text_slot_3 == "" ?" ":name_text_3+"-"+text_slot_3 ,
  "photo":"https://www.ipcc.ch/site/assets/uploads/sites/3/2019/10/img-placeholder.png" ,
  "photos":"" ,
  "main_data":main_data ,

  }
).then((value) {
  print(value?.data);
if(value?.data == "yes"){
  print("aaaa");
  emit(next());
}
});
  }
}
//( ``,  `photo`, `photos`, ``, `=`,``, ``,  `kind`, `des`, `text_slot_1`, `text_slot_2`, `text_slot_3`,