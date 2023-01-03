import 'dart:async';

import 'package:auction_app/cache.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    change_theme();
  }
  int theme_num = 1;
  FutureOr<void> change_theme() {
   // if(cache.get_data("auto_theme")==null &&cache.get_data("auto_theme")==true ){

    if(cache.get_data("theme") == "light"){
      emit (const ThemeState(ThemeMode.light));
    }
    else if(cache.get_data("theme") == "dark"){
      emit (const ThemeState(ThemeMode.dark));
    }
    else{
      SchedulerBinding.instance.window.platformBrightness ==
          Brightness.light
          ? emit (const ThemeState(ThemeMode.light))
          : emit (const ThemeState(ThemeMode.dark));
    }

  }

}
