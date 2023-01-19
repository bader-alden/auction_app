import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/layout/FAQ_page.dart';
import 'package:auction_app/layout/Home.dart';
import 'package:auction_app/layout/Setting.dart';
import 'package:auction_app/layout/Terms_page.dart';
import 'package:auction_app/layout/social_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/Main/Main_bloc.dart';
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

Widget drawer_widget(BuildContext context,GlobalKey<ScaffoldState> scaffold){
  return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width/1.5,color:Theme.of(context).brightness == Brightness.dark ?main_black.withOpacity(0.9):main_white.withOpacity(0.9),child: SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30,),
        Center(child: CircleAvatar(radius: 50,backgroundColor:Theme.of(context).brightness == Brightness.light ?Colors.grey.shade300:main_white,child: Icon(Icons.account_circle,size: 100,color: main_red,),)),
         SizedBox(height: 30,),
         InkWell(
           onTap: (){
             context.read<main_bloc>().change_nav_index(3);
             con.jumpToPage(3);
             scaffold.currentState?.closeDrawer();
           },
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Row(
               children: [
                 Container(
                  child: Text(context.read<LocaleBloc>().profile,style: TextStyle(fontSize: 24)),
                 ),
                 Spacer(),
                 Icon(context.read<LocaleBloc>().lang?Icons.arrow_forward_ios:Icons.arrow_back_ios_new),
               ],
             ),
           ),
         ),
        SizedBox(height: 30,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
            scaffold.currentState?.closeDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  child: Text(context.read<LocaleBloc>().setting,style: TextStyle(fontSize: 24)),
                ),
                Spacer(),
                Icon(context.read<LocaleBloc>().lang?Icons.arrow_forward_ios:Icons.arrow_back_ios_new),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms_page(with_init: true,)));
            scaffold.currentState?.closeDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  child: Text(context.read<LocaleBloc>().terms,style: TextStyle(fontSize: 20)),
                ),
                Spacer(),
                Icon(context.read<LocaleBloc>().lang?Icons.arrow_forward_ios:Icons.arrow_back_ios_new),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ_page()));

            scaffold.currentState?.closeDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  child: Text(context.read<LocaleBloc>().faq,style: TextStyle(fontSize: 24)),
                ),
                Spacer(),
                Icon(context.read<LocaleBloc>().lang?Icons.arrow_forward_ios:Icons.arrow_back_ios_new),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Social_page()));
            scaffold.currentState?.closeDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  child: Text(context.read<LocaleBloc>().social,style: TextStyle(fontSize: 24)),
                ),
                Spacer(),
                Icon(context.read<LocaleBloc>().lang?Icons.arrow_forward_ios:Icons.arrow_back_ios_new),
              ],
            ),
          ),
        ),
        SizedBox(height: 30,),
        InkWell(
          onTap: (){
            scaffold.currentState?.closeDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  child: Text("الشكاوي",style: TextStyle(fontSize: 24)),
                ),
                Spacer(),
                Icon(context.read<LocaleBloc>().lang?Icons.arrow_forward_ios:Icons.arrow_back_ios_new),
              ],
            ),
          ),
        ),
      ],
    ),
  ));
}