import 'dart:async';
import 'dart:ui';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../bloc/locale/locale_bloc.dart';
import '../bloc/stram/stream_bloc.dart';
import '../models/list_auction_model.dart';
import '../models/main_list_model.dart';
import 'auction_details.dart';

SfRangeValues _values = const SfRangeValues(10.0, 5000.0);
List price_item = ["2500", "3000"];
List<String> city_list = ["جدة", "الرياض"];
var price_selected;
var time = "....";
List<list_auction_model>? list_model = [];
var aa;
List<list_auction_model>? a = [];
class Test3 extends StatelessWidget {
  final type;
  final is_plate;
  List<all_kind_model>? kind;
  final type_name;
  final main_list_model model;
  Test3({super.key, required this.type, this.type_name, this.kind, this.is_plate, required this.model});
  @override
  Widget build(BuildContext context) {
    String? filter_1;
    String? filter_2;
    int kind_index = 0;

    return Material(
      child: Directionality(
        textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => StreamBloc()
                ..init_stream_void()
                ..get_all(type),
            ),
            BlocProvider(
              create: (context) => LocaleBloc(),
            ),
          ],
          child: StatefulBuilder(builder: (context, setstate) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: context.read<LocaleBloc>().lang
                        ? Icon(Icons.arrow_forward_ios, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                        : Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                // title: Text(kind_index.),
                title: Text(kind![kind_index].kind!),
              ),
              body: StreamBuilder(
                initialData: "loading",
                stream: context.read<StreamBloc>().get_stream_controller.stream,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Center(child: Image(
                      image: Theme.of(context).brightness==Brightness.dark
                          ?AssetImage("assets/img/dark_loading.gif")
                          :AssetImage("assets/img/loading.gif")
                      ,height: 125,width: 125,));
                  }
                  if (snapshot.data.toString() == "NOTFOUND") {
                    return const Scaffold(
                        body: Center(
                          child: Text("العنصر المطلوب غير متاح"),
                        ));
                  }
                  aa = "";
                  a = [];
                  if (list_model!.isNotEmpty ) {
                    list_model?.forEach((elementa) {
                      snapshot.data?.forEach((element) {
                        if (element.price != elementa.price && element.id == elementa.id && element.name == elementa.name) {
                          a?.add(element);
                        }
                      });
                    });
                  }
                  if (a!.isNotEmpty) {
                    aa = a?.first.id;
                  }
                  list_model = [];
                  snapshot.data.forEach((element) {
                    if (element.kind == kind?[kind_index].kind&&element.status.toString() =="0") {
                      if (filter_1 != null &&
                          double.parse(element.price) > double.parse(filter_1!.split("-")[0]) &&
                          double.parse(element.price) < double.parse(filter_1!.split("-")[1])) {
                        if (filter_2 != null&&element.city == filter_2) {
                          list_model?.add(element);
                        }else if (filter_2 == null) {
                          list_model?.add(element);
                        }
                      }
                      else if (filter_2 != null&&element.city == filter_2) {
                        if(filter_1 != null &&
                            double.parse(element.price) > double.parse(filter_1!.split("-")[0]) &&
                            double.parse(element.price) < double.parse(filter_1!.split("-")[1])){
                          list_model?.add(element);
                        }else if (filter_1 == null) {
                          list_model?.add(element);
                        }
                      }else if (filter_1 == null&&filter_2 == null) {
                        list_model?.add(element);
                      }
                    }
                  });

                  return Container(
                    child: snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StatefulBuilder(builder: (context, sertstte) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 85,
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,index){
                                        print(kind!.length);
                                        return Column(
                                          children: [
                                            InkWell(
                                                borderRadius: BorderRadius.circular(100),
                                                onTap: () {
                                                  //  StreamBloc().get_all(type, kind[1]);
                                                  setstate(() {
                                                    kind_index= index;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: kind_index == index ? const Color.fromARGB(255, 184, 60, 60) : const Color.fromARGB(255, 220, 200, 173),
                                                  child:  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image(
                                                      image: NetworkImage(kind![index].img!),
                                                      height: 30,
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(height: 10,),
                                            if(index == kind_index)
                                              RotatedBox(
                                                  quarterTurns: 90,
                                                  child: Image(
                                                    image: const AssetImage("assets/img/5.png"),
                                                    height: 15,
                                                    width: 15,
                                                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                                    filterQuality: FilterQuality.high,
                                                  ))
                                          ],
                                        );
                                      }, separatorBuilder: (context,index){
                                    return SizedBox(width: 20,);
                                  }, itemCount: kind!.length),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).brightness == Brightness.light ?Colors.white:Colors.grey.shade900,
                                          borderRadius: const BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))),
                                      height: MediaQuery.of(context).size.height / 3,
                                      child: StatefulBuilder(builder: (context, setState) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 5,),
                                            Container(
                                              width: 150,
                                              height: 5,
                                              decoration: BoxDecoration( color: Colors.grey,borderRadius: BorderRadius.circular(30)),
                                            ), const SizedBox(height: 40,),
                                            Text(context.read<LocaleBloc>().range,style: const TextStyle(fontSize: 24),),
                                            Expanded(
                                              child: SfRangeSlider(
                                                min: 0.0,
                                                max: 100000.0,
                                                values: _values,
                                                interval: 20000,
                                                showTicks: true,
                                                showLabels: true,
                                                enableTooltip: true,
                                                minorTicksPerInterval: 1,
                                                onChanged: (SfRangeValues values) {
                                                  setState(() {
                                                    filter_1 = values.start.toString() + "-" + values.end.toString();
                                                    _values = values;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 30,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                if (filter_1 != null)
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setstate(() {});
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(context.read<LocaleBloc>().apply)),
                                                if (filter_1 != null)
                                                  ElevatedButton(
                                                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                                      onPressed: () {
                                                        setState(() {
                                                          filter_1 = null;
                                                        });
                                                        filter_1 == null;
                                                        setstate(() {
                                                          filter_1 == null;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(context.read<LocaleBloc>().remove))
                                              ],),
                                            const SizedBox(height: 20,)
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: filter_1 == null ? Colors.grey : Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                                  width: 85,
                                  height: 40,
                                  child: Center(child: Text(context.read<LocaleBloc>().price,style: const TextStyle(color: Colors.white,fontSize: 20),)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).brightness == Brightness.light ?Colors.white:Colors.grey.shade900,
                                          borderRadius: const BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))),
                                      height: MediaQuery.of(context).size.height / 3,
                                      child: StatefulBuilder(builder: (context, setState) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 5,),
                                            Container(
                                              width: 150,
                                              height: 5,
                                              decoration: BoxDecoration( color: Colors.grey,borderRadius: BorderRadius.circular(30)),
                                            ), const SizedBox(height: 20,),
                                            Text(context.read<LocaleBloc>().city,style: const TextStyle(fontSize: 24),),
                                            const SizedBox(height: 20,),
                                            Expanded(
                                              child: FutureBuilder(
                                                  future: dio.get_data(url:"/dash/city"),
                                                  builder: (context,snap) {
                                                    print(snap.data?.data);
                                                    print(snap.data);
                                                    if(snap.connectionState == ConnectionState.waiting){
                                                      return Center(child: CircularProgressIndicator(color: main_red,));
                                                    }else {
                                                      var citys_list = snap.data?.data as List;
                                                      return ListView.separated(
                                                          itemBuilder: (context,index){
                                                            return Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: InkWell(
                                                                  onTap: (){
                                                                    setState((){
                                                                      filter_2= citys_list[index]["namecity"];
                                                                    });
                                                                  },
                                                                  child: Center(child: Text(citys_list[index]["namecity"],style: TextStyle(color:citys_list[index]["namecity"]==filter_2?Colors.red:Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),))),
                                                            );
                                                          }, separatorBuilder: (context,index){
                                                        return Container(
                                                          width: double.infinity,
                                                          height: 1,
                                                          color: Colors.grey,
                                                        );
                                                      }, itemCount: citys_list.length);
                                                    }
                                                  }
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                if (filter_2 != null)
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setstate(() {});
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(context.read<LocaleBloc>().apply)),
                                                if (filter_2 != null)
                                                  ElevatedButton(
                                                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                                      onPressed: () {
                                                        setState(() {
                                                          filter_2 = null;
                                                        });
                                                        filter_2 == null;
                                                        setstate(() {
                                                          filter_2 == null;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(context.read<LocaleBloc>().remove))
                                              ],),
                                            const SizedBox(height: 20,)
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: filter_2 == null ? Colors.grey : Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                                  width: 85,
                                  height: 40,
                                  child: Center(child: Text(context.read<LocaleBloc>().city_str,style: const TextStyle(color: Colors.white,fontSize: 20),)),
                                ),
                              ),
                              // InkWell(
                              //   onTap: (){
                              //
                              //   },
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: filter_2 == null ? Colors.grey : Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                              //     width: 85,
                              //     height: 40,
                              //     child: Center(child: Text("city",style: TextStyle(color: Colors.white,fontSize: 20),)),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(child: list_auction_widget(list_model!, aa)),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }


  Widget list_auction_widget(List<list_auction_model> snap, ss) {
    return Builder(builder: (context) {
      return ListView.separated(
        itemCount: snap.length,
        itemBuilder: (context, index) {
          list_auction_model model = snap[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // context.read<StreamBloc>().update(model,model.id,"okkkk");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Test2(
                              id: model.id,
                              type: type,
                              from: false,
                            )));
              },
              child: StatefulBuilder(builder: (context, setstate) {
                var a;
                if (ss == model.id) {
                  setstate(() {
                    a = Colors.red.withOpacity(0.4);
                  });
                  Future.delayed(const Duration(seconds: 2)).then((value) {
                    setstate(() {
                      ss = "";
                      a = Colors.transparent;
                    });
                  });
                } else {
                  a = Colors.transparent;
                }
                if(is_plate) {
                  return Container(
                    decoration: BoxDecoration(
                        color: a,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 0.9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 75,
                            child: ClipRRect(
                                borderRadius: context.read<LocaleBloc>().lang
                                    ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                                    : const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                child: Image(
                                  image: NetworkImage(model.photo!.toString()),
                                  height: 120,
                                )),
                          ),

                        // Expanded(child: Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,image: DecorationImage(image: NetworkImage(model.photo!))),)),
                        const SizedBox(
                          height: 10,
                        ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   const SizedBox(
                                     width: 15,
                                   ),
                                   Text(
                                    "تجربة",
                                     style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                                   ),
                                   Spacer(),
                                   Text(
                                     context.read<LocaleBloc>().test2_id + model.id!,
                                     style: const TextStyle(color: Colors.grey),
                                   ),
                                   const SizedBox(
                                     width: 7,
                                   ),
                                 ],
                               ),
                               const SizedBox(
                                 height: 5,
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       Text(context.read<LocaleBloc>().price+": " , style: const TextStyle(color: Colors.grey)),
                                       ImageFiltered(
                                           enabled: (model.is_hide??false)&&model.user_id!=cache.get_data("id").toString(),
                                           imageFilter: ImageFilter.blur(sigmaY: 3,sigmaX: 3),
                                           child: Text(((model.is_hide??false)&&model.user_id!=cache.get_data("id").toString()?"000000" : model.price!) + context.read<LocaleBloc>().curunce, style: const TextStyle(color: Colors.grey))),
                                     ],
                                   ),
                                   Spacer(),
                                   CircleAvatar(
                                     radius: 12,
                                     backgroundColor: main_red,
                                     child: Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Image.asset("assets/img/1.png"),
                                     ),
                                   ),
                                   const SizedBox(
                                     width: 4,
                                   ),
                                   Text(model.num_add ?? "0"),
                                   const SizedBox(
                                     width: 20,
                                   ),
                                   Spacer(),
                                   CircleAvatar(
                                     radius: 12,
                                     backgroundColor: main_red,
                                     child: Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Image.asset("assets/img/2.png"),
                                     ),
                                   ),
                                   const SizedBox(
                                     width: 5,
                                   ),
                                   Timer_widget(model.time, context, Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                 ],
                               ),
                             ],
                           ),
                         ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                  decoration: BoxDecoration(
                      color: a,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 0.9)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: ClipRRect(
                              borderRadius: context.read<LocaleBloc>().lang
                                  ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                                  : const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                              child: Image(
                                image: NetworkImage(model.photo!.toString()),
                                height: 120,
                              )),
                        ),
                      ),
                      // Expanded(child: Container(width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,image: DecorationImage(image: NetworkImage(model.photo!))),)),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.name!,
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                context.read<LocaleBloc>().test2_id + model.id!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: main_red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset("assets/img/1.png"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(model.num_add ?? "0"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: main_red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset("assets/img/2.png"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Timer_widget(model.time, context, Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(context.read<LocaleBloc>().price+": " , style: const TextStyle(color: Colors.grey)),
                                  ImageFiltered(
                                    enabled: (model.is_hide??false)&&model.user_id!=cache.get_data("id").toString(),
                                      imageFilter: ImageFilter.blur(sigmaY: 3,sigmaX: 3),
                                      child: Text(((model.is_hide??false)&&model.user_id!=cache.get_data("id").toString()?"000000" : model.price!) + context.read<LocaleBloc>().curunce, style: const TextStyle(color: Colors.grey))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                }
              }),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
      );
    });
  }
}
