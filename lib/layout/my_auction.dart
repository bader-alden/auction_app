import 'package:auction_app/bloc/add/add_bloc.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/dio.dart';
import 'package:auction_app/main.dart';
import 'package:auction_app/models/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/locale/locale_bloc.dart';
import '../const.dart';
import 'add_auction.dart';
import 'auction_details.dart';
import 'payment.dart';

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
                  ),if(model.state == "2")
                    Text("")
                 else if(model.auc_status == "2"||model.auc_status=="3")
                  Row(
                    children: [
                      Text("أعلى سعر:"),
                      SizedBox(width: 5,),
                      Text(model.price??" "),
                    ],
                  )
                 else if( model.state !="0")
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
                  child: Builder(builder: (context){
                    if(model.auc_status=="2"){
                      return Row(
                        children: [
                      Expanded(
                        child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                    onPressed: () async {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            content: Text('هل أنت متأكد من قبول سعر المزاد'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('لا'),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                                },
                              ),
                              TextButton(
                                child: Text('نعم'),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                  dio.post_data(url: "/post_auction/answer",quary: {
                                    "id":model.id,
                                    "type":model.type,
                                    "user_id":cache.get_data("id"),
                                    "answer":"yes",
                                  }).then((value) {
                                    print(value?.data);
                                    if(value?.data =="yes"){
                                      Navigator.of(context).pop();
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false);
                                    }
                                  });
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Container(child: Center(child: CircularProgressIndicator(),)),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );

                    },
                    child: const Text("موافقة على السعر"),
                    ),
                      ),SizedBox(width: 10,),Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                              onPressed: () async {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text('هل أنت متأكد من رفض سعر المزاد'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('لا'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        TextButton(
                                          child: Text('نعم'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            dio.post_data(url: "/post_auction/reject",quary: {
                                              "id":model.id,
                                              "type":model.type,
                                              "user_id":cache.get_data("id"),
                                            }).then((value) {
                                              print(value?.data);
                                              if(value?.data =="yes"){
                                                Navigator.of(context).pop();
                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false);
                                              }
                                            });
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Container(child: Center(child: CircularProgressIndicator(),)),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("رفض السعر"),
                            ),
                          )
                        ],
                      );
                    }
                    else if (model.auc_status == "3" ){
                      return  Center(child: Text("بإنتظار الدفع من الفائز"));
                    } else if (model.state == "0" ){
                      return  Center(child: Text("بإنتظار الموافقة"));
                    } else if (model.state == "3" ){
                      return  Center(child: Text("بإنتظار الموافقة على الدفعة"));
                    }else if (model.state == "2" ){
                      return   ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(model: model,pay_type: "pay",)));
                        },
                        child: const Text("يرجى الدفع"),
                      );
                    } else if (model.state == "1" && model.auc_status == "0"){
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
                  })
                  // child: model.auc_status == "2"
                  //     ? Center(child:
                  // model.state =="0"
                  // ?Text("بإنتظار الموافقة")
                  // :Text("أنتهى وقت المزاد"))
                  //     : ElevatedButton(
                  //         style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                  //         onPressed: () async {
                  //           Navigator.push(context, MaterialPageRoute(builder: (context) => Test2(type: model.type, id: model.id)));
                  //         },
                  //         child: const Text("الإنتقال إالى المزاد"),
                  //       )
                ,),
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
