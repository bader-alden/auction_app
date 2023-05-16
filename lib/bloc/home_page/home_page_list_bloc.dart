import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:auction_app/dio.dart';
import '../../models/main_list_model.dart';

part 'home_page_list_event.dart';
part 'home_page_list_state.dart';
List<main_list_model>? main_list = [];
class HomePageListBloc extends Bloc<HomePageListEvent, HomePageListState> {
  HomePageListBloc() : super(HomePageListState([])) {
  }

  Future<void> get_main_list() async {
    main_list = [];
   await dio.get_data(url: "main").then((value) {
     print(value?.data);
      value?.data.forEach((element) async {
        await  dio.get_data(url:"main_data",quary:{"type":element['type'] } ).then((value) {
        //  print(value?.data);
          main_list?.add( main_list_model.fromjson(element,value?.data['results'][0]["num"],value?.data['b']));
        });
        if( main_list?.length == value.data.length ){
          print("end");
         emit(HomePageListState(main_list!));
        }
      });
    });
  }
}
