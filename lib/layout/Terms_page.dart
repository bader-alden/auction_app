
import 'package:auction_app/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locale/locale_bloc.dart';
String? terms;
class Terms_page extends StatefulWidget {
  const Terms_page({Key? key, this.with_init, this.inh_terms}) : super(key: key);
final with_init;
final inh_terms;
  @override
  State<Terms_page> createState() => _Terms_pageState(with_init,inh_terms);
}

class _Terms_pageState extends State<Terms_page> {
  final with_init;
  final inh_terms;

  _Terms_pageState(this.with_init, this.inh_terms);
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(with_init) {
      dio.get_data(url: "/terms_and_conditions").then((value) {
      setState((){
        terms=value?.data[0]["terms"];
      });
    });
    }else{
      terms=inh_terms;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    terms=null;
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
      .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text(context.read<LocaleBloc>().terms), elevation: 0),

        body: StatefulBuilder(builder: (context,setstate){
          if(terms == null){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
               width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: Text(terms!,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 23)),

              ),
            );
          }
        })
      ),
    );
  }
}
