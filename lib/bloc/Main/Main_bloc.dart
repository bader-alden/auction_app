
import 'package:auction_app/bloc/Main/Main_event.dart';
import 'package:auction_app/bloc/Main/Main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/main_list_model.dart';
main_list_model? main_list;
// List<main_list_model> test_list = [
// main_list_model.fromjson(Map.from({'id': 1, 'type': 'real_estates', 'ar_name': 'عقارات', 'eng_name': 'Real Estates', 'detail': 'All about Real Estates', 'text':'كل شيئ عن عقارات', 'created_at': '2022-12-28T23:19:47.000000Z', 'updated_at': '2022-12-15T23:19:47.000000Z','all_kind':""})),
// main_list_model.fromjson( Map.from({'id': 2, 'type': 'vehicles', 'ar_name': 'مركبات', 'eng_name': 'Vehicles', 'detail': 'All about Vehicles', 'text':'كل شيئ عن مركبات', 'created_at': '2022-12-22T23:20:14.000000Z', 'updated_at': '2022-12-21T23:20:14.000000Z','all_kind':"cars-havey"})),
// main_list_model.fromjson( Map.from({'id': 3, 'type': 'vehicle_plates', 'ar_name': 'لوحات سيارات', 'eng_name': 'Vehicle Plates', 'detail': 'All about Vehicle Plates', 'text': 'كل شيئ عن لوحات السيارات', 'created_at': '2022-12-22T23:20:32.000000Z', 'updated_at': '2022-12-15T23:20:32.000000Z','all_kind':""})),
// main_list_model.fromjson( Map.from({'id': 4, 'type': 'mix', 'ar_name': 'منوعات', 'eng_name': 'Mix', 'detail': 'All about Mix', 'text':'كل شيئ عن منوعات', 'created_at': '2022-12-22T23:20:49.000000Z', 'updated_at': '2022-12-08T23:20:49.000000Z','all_kind':""})),
// main_list_model.fromjson( Map.from({'id': 5, 'type': 'mobile_numbers', 'ar_name': 'أرقام جوالات', 'eng_name': 'Mobile Numbers', 'detail': 'All about Mobile Numbers', 'text': 'كل شيئ عن أرقام جوالات', 'created_at': '2022-12-22T23:21:06.000000Z', 'updated_at': '2022-12-27T23:21:06.000000Z','all_kind':""})),
// ];
class main_bloc extends Bloc<main_event,main_state> {
  main_bloc() : super(init());

  static main_bloc get(context) => BlocProvider.of(context);


  int nav_bar_index = 0;

  void change_nav_index(new_index) {
    nav_bar_index = new_index;
    emit(nav_bar_state());
  }

  //List<main_list_model>? main_list = [];

  // Future<void> get_main_data() async {
  //   emit(loading_main_list_state());
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   dio.get_data(url: "main").then((value) {
  //     value?.data.forEach((element) {
  //       dio.get_data(url:"main_data",quary:{"type":element['type'] } ).then((value) {
  //         main_list?.add( main_list_model.fromjson(element,value?.data['results'][0]["num"],value?.data['data'].isEmpty?'2022':value?.data['data'][0]["created_at"]));
  //       });
  //       print(value.data.length );
  //       print(value.data.indexOf(element) );
  //       if(value.data.length == value.data.indexOf(element)+1){
  //         print("end");
  //         emit(get_main_list_state(main_list!));
  //       }
  //     });
  //
  //   });

        // main_list = test_list;
        // emit(get_main_list_state());

   //  dio.get_data(url: "mains").then((value) {
   //    print(value?.data['data']);
   //    value?.data['data'].forEach((element) {
   //      main_list?.add(main_list_model.fromjson(element));
   //    });
   //    emit(get_main_list_state());
   //  });
 // }


  // void register(email, pass, name, mobile_id, address) {
  //   dio.post_data(url: "/register", quary: {
  //     "email": email,
  //     "password": pass,
  //     "name": name,
  //     "mobile_id": mobile_id,
  //     "address": address,
  //   }).then((value) {
  //     if (value?.data["status"] == "success") {
  //       cache.save_data("email", email);
  //       cache.save_data("password", pass);
  //       user = user_models.fromjson(value?.data['user']);
  //       emit(scc_login());
  //     }
  //   });
  // }
}
