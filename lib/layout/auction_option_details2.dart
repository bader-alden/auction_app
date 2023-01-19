import 'package:auction_app/bloc/locale/locale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/list_auction_model.dart';
Map main_data_map={};
class option_details2 extends StatefulWidget {
  const option_details2({Key? key,required  this.row}) : super(key: key);
  final row ;

  @override
  State<option_details2> createState() => _option_details2State(row);
}

class _option_details2State extends State<option_details2> {
  final row;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    row.toString().split("^").forEach((element) {
      main_data_map[element.split("**")[0]]=element.split("**")[1];
    });
  }
  _option_details2State(this.row);
  @override
  Widget build(BuildContext context) {
    return  Directionality(
     textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr:TextDirection.rtl,
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
            .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text("المعلومات الأساسية"),),
       body: ListView.separated(itemBuilder: (context,index){
         return Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             children: [

               Text(main_data_map.keys.elementAt(index),style: TextStyle(fontSize: 22)),
               Spacer(),
               Text(main_data_map[main_data_map.keys.elementAt(index)],style: TextStyle(fontSize: 22)),
               SizedBox(width: 20,),
             ],
           ),
         );
       }, separatorBuilder: (context,index){
         return Container(height: 2,color: Colors.grey,);
       }, itemCount: 2)
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
