import 'package:auction_app/bloc/add/add_bloc.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/locale/locale_bloc.dart';
import 'add_auction.dart';
List<String> alist = ["aaaa","cccccccc","cccccccccc","ajjaaa","ccccccchhhc","ccbbbbcccccccc"];
List<String> s =["Cars","Plate","House","h","k"];

class My_action extends HookWidget {
  const My_action({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var my_action_tab_con = useTabController(initialLength: alist.length);
    return BlocProvider(
  create: (context) => AddBloc()..check_add(),
  child: BlocConsumer<AddBloc, AddState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(floatingActionButtonLocation:
    context.read<LocaleBloc>(). lang
    ?FloatingActionButtonLocation.endDocked
    :FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: main_red,
          child: const Icon(Icons.add,color: Colors.white,),
          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const add_auction()));
      }),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("مزاداتي"),
        elevation: 0,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Directionality(
          textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context,index){
                    return my_auction_item(context,index);
                  }, separatorBuilder: (context,index){
                    return const SizedBox(height: 20,);
                  }, itemCount: AddBloc.get(context).add_list.length),
                ),
              )
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}

Widget my_auction_item(context,index) {
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
                const CircleAvatar(radius:25 ,backgroundColor: Colors.red,child: Icon(Icons.all_inclusive,color: Colors.white,),),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(s[index],style: const TextStyle(fontSize: 20),),
                    const Text("2020-20-20   2020-20-20",style: TextStyle(color: Colors.grey),)
                  ],
                ),
                const Spacer(),
                Container(width: 5,height: 5,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(20)),),
                const SizedBox(width: 5,),
                const Text("5 hr 40 min")
              ],
            ),
          ),
          // Container(color: Theme.of(context).brightness==Brightness.light ?Color.fromARGB(255, 247, 247, 247):Color.fromARGB(255,76,83,81),width: double.infinity,child: Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TabBar(
          //     indicatorColor: Colors.transparent,
          //     isScrollable: true,
          //     controller: my_action_tab_con,
          //     tabs: alist.map(tab_item).toList(),
          //   ),
          // ),),
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
