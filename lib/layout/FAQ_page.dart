import 'package:flutter/material.dart';
import 'package:auction_app/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locale/locale_bloc.dart';
List faq_list=[];
class FAQ_page extends StatefulWidget {
  const FAQ_page({Key? key}) : super(key: key);

  @override
  State<FAQ_page> createState() => _FAQ_pageState();
}

class _FAQ_pageState extends State<FAQ_page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dio.get_data(url: "/faq").then((value) {
      setState((){
        faq_list = value?.data ;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    faq_list.clear();
  }
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

            if(faq_list.isEmpty){
              return Center(child: CircularProgressIndicator());
            }
            else{
              return ListView.separated(
                shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
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
