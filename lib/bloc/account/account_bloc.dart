import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auction_app/cache.dart';
import '../../models/user_model.dart';
import 'package:auction_app/dio.dart';
part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<Accountlodaded>(app_load);
    on<login_event>(login);
    on<logout_event>(logout);
    on<register_event>(register);
  }
  user_models? user;
  Future<void> app_load(Accountlodaded event, Emitter<AccountState>emit) async {
    emit(app_check());
    if(cache.get_data("id")!=null){
      await dio.post_data(url: "/account/loginid", quary: {
        "id": cache.get_data("id"),
      }).then((value) {
        print(value?.data);
        if (value?.data != "notfound"&&value?.data.isNotEmpty) {
          user = user_models.fromjson(value?.data[0]);
          emit(is_login_state(user!));
        }else{
          emit(is_not_login_state());
        }
      });
    }else{
      emit(is_not_login_state());
    }
  print("start bloc load");
  }
  Future<void> login(login_event event, Emitter<AccountState>emit) async {
    print("start bloc login");
    await dio.post_data(url: "/account/login", quary: {
      "mobile_id": event.email,
      "gsm_token": event.token.toString().split(":")[0],
      "gsm_token2": event.token.toString().split(":")[1],
    }).then((value) {
      print(value?.data);
      if (value?.data.isNotEmpty && value?.data != "notfound") {
        cache.save_data("id",value?.data[0]['id'] );
        user = user_models.fromjson(value?.data[0]);
        print(user?.name);
        cache.remove_data("otp_id");
        emit(is_login_state(user!));
      }else{
        print("errrrrrorrrrrrrrr");
        emit(error_login_state());
      }
  });}
  void logout(logout_event event, Emitter<AccountState>emit) {
    cache.remove_data("id" );
    print('logout');
    emit(is_not_login_state());
    //emit(is_not_login_state());
  }

  Future<FutureOr<void>> register(register_event event, Emitter<AccountState> emit) async {
    print("start bloc login");
    await dio.post_data(url: "/account/signin", quary: {
      "mobile_id": cache.get_data("reg").toString().split("|")[0],
      "gsm_token": event.token.toString().split(":")[0],
      "gsm_token2": event.token.toString().split(":")[1],
      "name": cache.get_data("reg").toString().split("|")[1],
      "email": cache.get_data("reg").toString().split("|")[2],
      "address": cache.get_data("reg").toString().split("|")[3],
      "id_number": cache.get_data("reg").toString().split("|")[4],
    }).then((value) async {
      print(value?.data);
      if (value?.data != null) {
        cache.save_data("id",value?.data );
        await dio.post_data(url: "/account/loginid", quary: {
          "id": cache.get_data("id"),
        }).then((value) {
          print(value?.data);
          if (value?.data != "notfound") {
            cache.remove_data("otp_id");
            user = user_models.fromjson(value?.data[0]);
            emit(is_login_state(user!));
          }
        });
      }else{
        print(value?.data);
      }
    });
  }
}
