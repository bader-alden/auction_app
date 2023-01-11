import 'dart:async';

import 'package:auction_app/cache.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:auction_app/dio.dart';

import '../../models/fav_molde.dart';
part 'fav_event.dart';
part 'fav_state.dart';
class FavBloc extends  Bloc<FavEvent,FavState> {
  FavBloc() : super(init_state()){
    on<fav_evint>(fav_evint_void);
  }
  static FavBloc get(context) => BlocProvider.of(context);
  List<String>? fav=[];
  bool? is_fav ;
  void check(type,id) async {
    emit(loadin_state());
    if(cache.get_data("id")!=null){
      await dio.get_data(url: "/account/fav", quary: {
        "id": cache.get_data("id"),
      }).then((value) {
        if(value?.data[0]['fav'] !=null){
         // fav = value?.data[0]['fav'].toString().split(",");
          if(value!.data[0]['fav'].toString().contains(id+"|"+type)){
            is_fav = true;
            emit(fav_state());
          }else{
            is_fav = false;
            emit(fav_state());
          }
          //emit(fav_state());
        }else{
          is_fav = false;
          emit(fav_state());
        }
      });
    }else{
      is_fav = false;
      emit(fav_state());
    }
    }
  void delet_fav(type,id) async {
     is_fav = false;
      emit(fav_state());
      await dio.get_data(url: "/account/fav", quary: {
        "id": cache.get_data("id"),
      }).then((value) {
        if(value?.data[0]['fav'] !=null){
          fav = value?.data[0]['fav'].toString().split(",");
          fav?.remove(id+"|"+type);
          dio.post_data(url: "/account/fav_delet", quary: {
            "id": cache.get_data("id"),
            "fav": fav,
          });
        }
      });
  }
 void add_to_fav_void( type, id) async {
    is_fav = true;
    emit(fav_state());
      await dio.post_data(url: "/account/fav", quary: {
        "fav": "${","+id}|"+type,
        "id": cache.get_data("id"),
      });

  }
int cout =0;

List<fav_model> fav_list =[];
  fav_evint_void(fav_evint evint , Emitter<FavState> state) async {
    emit(errorfavstate());
    if(cache.get_data("id")!=null){
      await dio.get_data(url: "/account/${evint.type}", quary: {
        "id": cache.get_data("id"),
      }).then((value) {
        print(value);
        if(value ?.data != []&&value?.data[0][evint.type] !=""&&value?.data[0][evint.type] !=" "){
          List<String>? lfav = value?.data[0][evint.type].toString().split(",");
          lfav?.removeWhere((element) => element=="");
          fav_list =[];
          lfav?.forEach((element) async {
            if(element!= ""){
              await dio.get_data(url: "/account/get_data", quary: {
                "id":element.split("|")[0] ,
                "type": element.split("|")[1],
              }).then((value) {
                fav_list.add(fav_model.fromjson(value?.data[0]["name"],value?.data[0]["created_at"],element.split("|")[1],element.split("|")[0],value?.data[0]["status"]));
                if(lfav.length == fav_list.length){
                  emit(fav_state());
                }
              });
            }
          });
        }else{
          print("object");
          is_fav = false;
          emit(errorfavstate());
        }
      });
    }else{
      print("object");
      is_fav = false;
      emit(errorfavstate());
    }
  }


}


