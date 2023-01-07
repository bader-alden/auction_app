import 'dart:convert';

import 'package:auction_app/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locale/locale_bloc.dart';
String? terms;
class Terms_page extends StatelessWidget {
  const Terms_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
appBar: AppBar(leading: IconButton( onPressed: (){
  Navigator.pop(context);
},icon: context
      .read<LocaleBloc>()
      .lang
      ? Icon(Icons.arrow_forward_ios, color: Theme
      .of(context)
      .brightness == Brightness.dark ? Colors.white : Colors.black)
      : Icon(Icons.arrow_back_ios, color: Theme
      .of(context)
      .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text(context.read<LocaleBloc>().terms), elevation: 0),

        body: StatefulBuilder(builder: (context,setstate){
          dio.get_data(url: "/terms_and_conditions").then((value) {
            setstate((){
              terms=value?.data[0]["terms"];
            });
          });
          if(terms == null){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Container(
             width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Text(terms!,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 23)),

            );
          }
        })
      ),
    );
  }
}
