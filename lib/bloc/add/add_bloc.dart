
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
    dio.get_data(url: "/account/auctions",quary: {"id":cache.get_data("id")}).then((value) {
      print(value?.data);
      if(value?.data !="" &&value?.data.isNotEmpty){
        value?.data.toString().split(",").forEach((element) {
          print(element);
          add_list.add(add_model.fromjson(element));
          if(value.data.toString().split(",").length == value.data.toString().split(",").indexOf(element)){
            emit(next());
          }
        });
      }
    });
  }

  void add_void(my_id, name, des, price, min_price, num_day, city, type){
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
    "kind":"all",
  "location":"a" ,
  "file_slot_3":"a" ,
  "file_slot_2":"a" ,
  "file_slot_1":"a" ,
  "text_slot_1":"a" ,
  "text_slot_2":"a" ,
  "text_slot_3":"a" ,
  "photo":"a" ,
  "photos":"a" ,

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