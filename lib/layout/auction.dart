import 'package:auction_app/cache.dart';
import 'package:auction_app/layout/payment.dart';
import 'package:flutter/material.dart';
import 'package:auction_app/models/fav_molde.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../bloc/fav/fav_bloc.dart';
import '../bloc/locale/locale_bloc.dart';
import '../const.dart';
import 'auction_details.dart';
import 'package:auction_app/models/add_model.dart';
bool is_change = false;

class Auctions extends StatelessWidget {
  const Auctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavBloc()..add(fav_evint("auctions")),
      child: BlocConsumer<FavBloc, FavState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(FavBloc.get(context).is_fav == false  ){
            return  Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("المزادات التي شاركت بها"),
                elevation: 0,),
              body: const Center(child: Text("لم تتم تشارك بأي مزاد"),),
            );
          }else {
            if(state is init_state || state is fav_evint ||FavBloc.get(context).fav_list.isEmpty ){
              return  Center(child: Image(
                  image: Theme.of(context).brightness==Brightness.dark
              ?AssetImage("assets/img/dark_loading.gif")
              :AssetImage("assets/img/loading.gif")
              ,height: 125,width: 125,));
            }else {
              return StatefulBuilder(
                  builder: (context,setstate) {
                    return Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: const Text("المزادات التي شاركت بها"),
                        elevation: 0,),
                      body: Directionality(
                        textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  return my_auction_item(context,index,FavBloc.get(context).fav_list[index],setstate);
                                }, separatorBuilder: (context,index){
                              return const SizedBox(height: 20,);
                            }, itemCount: FavBloc.get(context).fav_list.length),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
          }
        },
      ),
    );
  }
}

Widget my_auction_item(context,index,fav_model model,setstate) {
  return Material(
    elevation: 10,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : const Color.fromARGB(255, 35, 35, 35) ,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(radius:25 ,backgroundColor: Colors.red,child:model.status=="4"?Icon(Icons.archive_outlined,color: Colors.white,size: 30,):Image(
                    height: 30,
                    width: 30,
                    image: NetworkImage(base_url+"/file/${model.type!.replaceAll(" ", "")}.png"),
                  ),),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(model.name!,style: const TextStyle(fontSize: 20),),
                    ],
                  ),
                  
                  const Spacer(),
                  Container(width: 5,height: 5,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(20)),),
                  const SizedBox(width: 5,),
                  if(model.status!="4")
                  Timer_widget(model.time, context, Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                ],
              ),
            ),
            Container(color: Theme.of(context).brightness==Brightness.light ?const Color.fromARGB(255, 247, 247, 247):const Color.fromARGB(255, 35, 35, 35) ,width: double.infinity,child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Builder(builder: (context){
                 if (model.status == "2" &&model.sub==cache.get_data("id").toString()){
                    return  Center(child: Text("بإنتظار الموافقة على السعر"));
                  }else if (model.status == "3"&&model.sub==cache.get_data("id").toString() ){
                   print(model.status);
                    return   ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                      onPressed: () async {
                        showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      TextButton(
                                        child: Text('دفع المبلغ كامل بدون خصم'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(model: add_model.fromjson("a|${model.id}|${model.type}|a", {"name":"a","price":'0',"created_at":"no"}), pay_type: 'pay2',)));

                                        },
                                      ),
                                      TextButton(
                                        child: Text(' خصم من الرصيد'),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Dismiss alert dialog
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(model: add_model.fromjson("a|${model.id}|${model.type}|a", {"name":"a","price":'0',"created_at":"ok"}), pay_type: 'pay2',)));

                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(model: add_model.fromjson("a|${model.id}|${model.type}|a", {"name":"a","price":'0',"time":"a"}), pay_type: 'pay2',)));
                      },
                      child: const Text("يرجى الدفع"),
                    );
                  } else  if (model.status == "2" ||model.status == "3") {
                   return Center(child: Text("إنتها وقت المزاد"));
                 } else  if (model.status == "4" ||model.type=="archive"){
                   return  ElevatedButton(
                       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                       onPressed: (){}, child: Text("التواصل مع الدعم الفني لإتمام التسليم"));
                 }else if (model.status == "0" ){
                    return   ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Test2(type: model.type, id: model.id)));
                      },
                      child: const Text("الإنتقال إالى المزاد"),
                    );
                  }else{
                    return Text("error");
                  }
                },)
            ),),
            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: Row(children: const [
            //     Text("laser machin 2022"),
            //     Spacer(),
            //     Text("you paid:"),
            //     Text("700")
            //   ],),
            // )
          ],
        ),
      ),),
  );
}
// Widget tab_item(a)=>  Row(children: [
//   CircleAvatar(backgroundColor: Colors.grey,radius: 10,child: Center(child: Text((alist.indexOf(a)+1).toString(),style: TextStyle(color: Colors.white))),),
//   const SizedBox(width: 5,),
//   Text(a,style: TextStyle(color: Colors.grey.shade400)),
// ]);
