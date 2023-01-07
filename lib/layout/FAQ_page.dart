import 'package:flutter/material.dart';
import 'package:auction_app/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locale/locale_bloc.dart';
List faq_list=[];
class FAQ_page extends StatelessWidget {
  const FAQ_page({Key? key}) : super(key: key);

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
              .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text(context.read<LocaleBloc>().faq), elevation: 0),

          body: StatefulBuilder(builder: (context,setstate){
            dio.get_data(url: "/faq").then((value) {
              setstate((){
                faq_list = value?.data ;
              });
            });
            if(faq_list == []){
              return CircularProgressIndicator();
            }
            else{
              return ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Text(faq_list[index]["Answer"],style: TextStyle(fontSize: 23)),
                          SizedBox(height: 10,),
                          Text(faq_list[index]["Question"]),
                          SizedBox(height: 5,),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return Container(width: double.infinity,height: 2,color: Colors.grey,);
                  },
                  itemCount: faq_list.length);
            }
          })
      ),
    );
  }
}
