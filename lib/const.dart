import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/locale/locale_bloc.dart';


//Color main_red = const Color.fromARGB(255, 235, 29, 54);
// Color main_red = const Color.fromARGB(255, 189, 93, 68);
//Color sec_color = const Color.fromARGB(255, 245, 237, 220);
// Color sec_color = const Color.fromARGB(255, 230, 214, 180);

void tost({String? msg,Color? color}) => Fluttertoast.showToast(
    msg: msg ??"null",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0);

Widget Timer_widget(time,BuildContext context,Color text_color){
  return CountdownTimer(
   // endTime:  DateTime.now().millisecondsSinceEpoch + 1000 * 190000000,
     endTime: DateTime.parse(time!).microsecondsSinceEpoch ~/ 1000,
    widgetBuilder: (_, CurrentRemainingTime? time) {
      if (time == null) {
        return Text('أنتهى الوقت',style: TextStyle(color: text_color),);
      }
      if(time.days == null && time.hours == null && time.min == null  ){
        return  Directionality(
          textDirection: TextDirection.ltr,
          child: AnimatedFlipCounter(
            textStyle:  TextStyle(color: text_color),
            duration: const Duration(seconds: 1),
            value: time.sec!.toInt(),
            prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().second} ",
            suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().second}":"",
          ),
        );
        //return Text('${time.sec} '+context.read<LocaleBloc>().second,style: TextStyle(color: text_color),);
      }
      if(time.days == null &&time.hours == null ){
        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: AnimatedFlipCounter(
                textStyle: TextStyle(color: text_color),
                duration: const Duration(seconds: 1),
                value: time.sec!.toInt(),
                prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().second} ",
                suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().second}":"",
              ),
            ),
            Text(" : ",style:TextStyle(color: text_color),),
            Directionality(
              textDirection: TextDirection.ltr,
              child: AnimatedFlipCounter(
                textStyle: TextStyle(color: text_color),
                duration: const Duration(seconds: 1),
                value: time.min!.toInt(),
                prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().minutes} ",
                suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().minutes}":"",
              ),
            ),
          ],
        );
        //return Text('${time.min} ${context.read<LocaleBloc>().minutes} : ${time.sec} '+context.read<LocaleBloc>().second,style: TextStyle(color: text_color),);
      }
      if(time.days == null ){
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: AnimatedFlipCounter(
                textStyle: TextStyle(color: text_color),
                duration: const Duration(seconds: 1),
                value: time.min!.toInt(),
                prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().minutes} ",
                suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().minutes}":"",
              ),
            ),
            Text(" : ",style:TextStyle(color: text_color),),
            Directionality(
              textDirection: TextDirection.ltr,
              child: AnimatedFlipCounter(
                textStyle: TextStyle(color: text_color),
                duration: const Duration(seconds: 1),
                value: time.hours!.toInt(),
                prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().hour} ",
                suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().hour}":"",
              ),
            ),
          ],
        );
        //return Text('${time.hours} ${context.read<LocaleBloc>().hour} : ${time.min} '+context.read<LocaleBloc>().minutes,style: TextStyle(color: text_color),);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedFlipCounter(
              textStyle: TextStyle(color: text_color),
              duration: const Duration(seconds: 1),
              value: time.hours!.toInt(),
              prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().hour} ",
              suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().hour}":"",
            ),
          ),
          Text(" : ",style:TextStyle(color: text_color),),
          Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedFlipCounter(
              textStyle: TextStyle(color: text_color),
              duration: const Duration(seconds: 1),
              value: time.days!.toInt(),
              prefix: context.read<LocaleBloc>().lang?"":"${context.read<LocaleBloc>().day} ",
              suffix: context.read<LocaleBloc>().lang?" ${context.read<LocaleBloc>().day}":"",
            ),
          ),
        ],
      );
      //return Text('${time.days} ${context.read<LocaleBloc>().day} : ${time.hours} '+context.read<LocaleBloc>().hour,style: TextStyle(color: text_color),);
    },
  );
}