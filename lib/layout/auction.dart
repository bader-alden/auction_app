import 'package:flutter/material.dart';
import 'package:auction_app/models/fav_molde.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../bloc/fav/fav_bloc.dart';
import '../bloc/locale/locale_bloc.dart';
import '../const.dart';
import 'auction_details.dart';
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
              return const Center(child: CircularProgressIndicator());
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
                  CircleAvatar(radius:25 ,backgroundColor: Colors.red,child:Image(
                    height: 30,
                    width: 30,
                    image: NetworkImage("https://tatbeky01.000webhostapp.com/aa/${model.type!.replaceAll(" ", "")}.png"),
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
                  Timer_widget(model.time, context, Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                ],
              ),
            ),
            Container(color: Theme.of(context).brightness==Brightness.light ?const Color.fromARGB(255, 247, 247, 247):const Color.fromARGB(255, 35, 35, 35) ,width: double.infinity,child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: model.status == "2" ? Center(child: Text("أنتهى وقت المزاد")):ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Test2(type: model.type,id: model.id)));
                  },
                  child: const Text("الإنتقال إالى المزاد"),
                )
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