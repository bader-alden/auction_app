import 'package:auction_app/bloc/add/add_bloc.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/models/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/locale/locale_bloc.dart';
import '../const.dart';
import 'add_auction.dart';
import 'auction_details.dart';

List<String> alist = ["aaaa", "cccccccc", "cccccccccc", "ajjaaa", "ccccccchhhc", "ccbbbbcccccccc"];
List<String> s = ["Cars", "Plate", "House", "h", "k"];

class My_action extends HookWidget {
  const My_action({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var my_action_tab_con = useTabController(initialLength: alist.length);
    return BlocProvider(
        create: (context) => AddBloc()..check_add(),
        child: BlocConsumer<AddBloc, AddState>(
            listener: (context, state) {},
            builder: (context, state) {
          if(state is empty_state){
           return Scaffold(
             appBar: AppBar(

               centerTitle: true,
               title: const Text("مزاداتي"),
               elevation: 0,
             ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("لم تتم إضافة أي مزاد"),),
                  SizedBox(height: 20,),
                  Center(child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_red)),onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const add_auction()));
                  },child: Text("أنشاء"),),),
                ],
              ),
            );
          }
          return Scaffold(
              body: AddBloc.get(context).add_list.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : StatefulBuilder(builder: (context, setstate) {
                      return Scaffold(
                        floatingActionButtonLocation:
                        context.read<LocaleBloc>().lang ? FloatingActionButtonLocation.endDocked : FloatingActionButtonLocation.startDocked,
                        floatingActionButton: FloatingActionButton(
                            backgroundColor: main_red,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const add_auction()));
                            }),
                        appBar: AppBar(

                          centerTitle: true,
                          title: const Text("مزاداتي"),
                          elevation: 0,
                        ),
                        body: Directionality(
                          textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return my_auction_item(context, index, AddBloc.get(context).add_list[index], setstate);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemCount: AddBloc.get(context).add_list.length),
                            ),
                          ),
                        ),
                      );
                    }));


        }));
  }
}

Widget my_auction_item(context, index, add_model model, setstate) {
  print(model.auc_status);
  print(model.state);
  return Material(
    elevation: 10,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : const Color.fromARGB(255, 35, 35, 35),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                    child: Image(
                      height: 30,
                      width: 30,
                      image: NetworkImage("https://faceted-dull-evening.glitch.me/file/${model.type!.replaceAll(" ", "")}.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if( model.state !="0")
                  Timer_widget(model.time, context, Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                ],
              ),
            ),
            if(model.state.toString() =="0")
              Container(
                color:
                Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 247, 247, 247) : const Color.fromARGB(255, 35, 35, 35),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(child: Text("بإنتظار الموافقة")
                    )),
              )else
            Container(
              color:
                  Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 247, 247, 247) : const Color.fromARGB(255, 35, 35, 35),
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: model.auc_status == "2"
                      ? Center(child:
                  model.state =="0"
                  ?Text("بإنتظار الموافقة")
                  :Text("أنتهى وقت المزاد"))
                      : ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Test2(type: model.type, id: model.id)));
                          },
                          child: const Text("الإنتقال إالى المزاد"),
                        )),
            ),
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
      ),
    ),
  );
}

// Widget tab_item(a)=>  Row(children: [
//   CircleAvatar(backgroundColor: Colors.grey,radius: 10,child: Center(child: Text((alist.indexOf(a)+1).toString(),style: TextStyle(color: Colors.white))),),
//   const SizedBox(width: 5,),
//   Text(a,style: TextStyle(color: Colors.grey.shade400)),
// ]);
