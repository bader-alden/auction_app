import 'package:auction_app/bloc/locale/locale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/list_auction_model.dart';

class option_details extends StatelessWidget {
  const option_details({Key? key,required auction_details_list_model this.model}) : super(key: key);
  final auction_details_list_model model;
  @override
  Widget build(BuildContext context) {
    return  Directionality(
     textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton( onPressed: (){
          Navigator.pop(context);
        },icon: context
            .read<LocaleBloc>()
            .lang
            ? Icon(Icons.arrow_forward_ios, color: Theme
            .of(context)
            .brightness == Brightness.dark ? Colors.white : Colors.black)
            : Icon(Icons.arrow_back_ios, color: Theme
            .of(context)
            .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text(model.name!),),
       body: ListView(
         children: [
           Container(width: double.infinity,padding: EdgeInsets.all(8),child: Text(model.details.toString(),textDirection: TextDirection.rtl,style: TextStyle(fontSize: 22),)),
         ],
       ),
        // body: ListView.separated(
        //     itemBuilder: (context,index){
        //   return Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Center(child: Text(model.details![index])),
        //   );
        // }, separatorBuilder: (context,index){
        //   return Container(
        //     height: 2,
        //     width: double.infinity,
        //     color: Colors.grey,
        //   );
        // }, itemCount: model.details!.length),
      ),
    );
  }
}
