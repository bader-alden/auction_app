
import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auction_app/bloc/home_page/home_page_list_bloc.dart';
import 'package:auction_app/layout/Setting.dart';
import 'package:auction_app/layout/auction_details.dart';
import 'package:auction_app/layout/auction_list.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../bloc/locale/locale_bloc.dart';
import '../bloc/stram/stream_bloc.dart';
import '../bloc/theme/theme.dart';
import '../models/list_auction_model.dart';
import '../const.dart';
import '../models/main_list_model.dart';
import 'Shimmer.dart';
import 'package:auction_app/cache.dart';
var scafold = GlobalKey<ScaffoldState>();
GlobalKey container_key = GlobalKey();
ScrollController scon = ScrollController();
ScrollController _scrollController = ScrollController();
list_auction_model? model;
List<main_list_model>? main_list = [];
Widget Home_page_new(BuildContext context, home_tab_con) {
  return BlocProvider(
      create: (context) => HomePageListBloc()..get_main_list(),
      child: Builder(builder: (context) {
        return Directionality(
          textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            key: scafold,
            drawer: drawer_widget(context,scafold),
              body: SafeArea(
            child: Column(
              children: [
              //  if (cache.get_data("sqr") != null) Expanded(flex: 4, child: sqr_widget(context, home_tab_con)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
                            scafold.currentState?.openDrawer();
                          },icon: const Icon(Icons.menu,size: 25,)),
                          //SizedBox(width: 5,)
                         // Text(context.read<LocaleBloc>().home_page_middle, style: const TextStyle(fontSize: 30)),
                          Spacer(),
                          Image(image: AssetImage("assets/img/18.png"),height: 70),
                          //Text("اوكشن السعودية", style: const TextStyle(fontSize: 30)),
                          Spacer(),
                          SizedBox(width: 30,)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: BlocConsumer<HomePageListBloc, HomePageListState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                          child: context.read<HomePageListBloc>().state.list!.isEmpty
                              ? GridView.builder(
                                  itemBuilder: (context, index) {
                                    return home_list_shimmer(context);
                                  },
                              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.3),
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics())
                          :GridView.builder(
                              shrinkWrap: true,
                              itemCount:context.read<HomePageListBloc>().state.list?.length ,
                              padding: EdgeInsets.all(0),
                              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1), itemBuilder: (context,index){
                          return  home_page_item(index, context, context.read<HomePageListBloc>().state.list![index]);
                          })

                        //       :GridView.count(crossAxisCount: 2,children:
                        //   context.read<HomePageListBloc>().state.list!.map((e) => home_page_item(context.read<HomePageListBloc>().state.list!.indexOf(e), context, e),)
                        // .toList<Widget>()
                        //   )

                          // : ListView.separated(
                              //     itemBuilder: (context, index) {
                              //       return Column(
                              //         children: [
                              //           home_page_item(index, context, context.read<HomePageListBloc>().state.list![index]),
                              //         ],
                              //       );
                              //     },
                              //     separatorBuilder: (context, index) {
                              //       return const SizedBox(
                              //         height: 16,
                              //       );
                              //     },
                              //     itemCount: context.read<HomePageListBloc>().state.list!.length,
                              //     //itemCount:  1,
                              //     shrinkWrap: true,
                              //     physics: const BouncingScrollPhysics()),
                        );
                      },
                    ))
              ],
            ),
          )),
        );
      }));
}


Widget tabbs(a) => Text(
      a,
      style: const TextStyle(color: Colors.black),
    );

Widget home_page_item(int index, BuildContext context, main_list_model model) {
  return InkWell(
    onTap: model.is_soon??true ?null:() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Test3(type: model.type, type_name: context.read<LocaleBloc>().lang ? model.eng_name! : model.ar_name!, kind: model.all_kind)));
    },
    borderRadius: BorderRadius.circular(20),
    child: Container(
      foregroundDecoration:
      model.is_soon??true ? BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
      )
      :BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

    Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: context.read<LocaleBloc>().lang ? Alignment.topRight : Alignment.topLeft,
                    children: [
                      Padding(
                        // padding: EdgeInsets.only(right: context.read<LocaleBloc>().lang ? 8 : 0, left: context.read<LocaleBloc>().lang ? 0 : 8, top: 2),
                        padding: EdgeInsets.zero,
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: main_red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                height: 60,
                                width: 60,
                                image: NetworkImage(base_url+"/file/${model.type!}.png"),
                              ),
                            )),
                      ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Container(
                      //       height: 23,
                      //       width: 23,
                      //       decoration: BoxDecoration(
                      //           color: sec_color,
                      //           borderRadius: BorderRadius.circular(20),
                      //           border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white, width: 2.5)),
                      //       padding: const EdgeInsets.symmetric(horizontal: 6),
                      //     ),
                      //     Text(
                      //       model.is_soon??true?"0":model.count!,
                      //       style: const TextStyle(color: Colors.black, fontSize: 12),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                //  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(context.read<LocaleBloc>().lang ? model.eng_name! : model.ar_name!,style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                //  SizedBox(height: 5,),
                  // Text(context.read<LocaleBloc>().lang ? model.detail! : model.text!)
                ],
              ),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: sec_color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white, width: 2.5)),
              padding: const EdgeInsets.symmetric(horizontal: 6),
            ),
            Text(
              model.is_soon??true?"0":model.count!,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ],
    ),
          SizedBox(height: 10,),
          //const Spacer(),
          Container(
            child:model.is_soon??true
            ?Text("قريبا...")
            :Timer_widget_home(model.time, context,Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.black),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    ),
  );
}

Widget one(list_auction_model model,BuildContext context) {
  return ClipRRect(
    borderRadius: context.read<LocaleBloc>().lang
    ?const BorderRadius.only(topLeft: Radius.circular(20))
    :const BorderRadius.only(topRight: Radius.circular(20)),
  child: Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border:  context.read<LocaleBloc>().lang
          ?const Border(
            bottom: BorderSide(color: Colors.white,width: 1),
            right: BorderSide(color: Colors.white,width:1),
          )
          :const Border(
        bottom: BorderSide(color: Colors.white,width: 1),
        left: BorderSide(color: Colors.white,width:1),
      )
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Expanded(
              child: Image(
            image: AssetImage("assets/img/1.png"),
          )),
          Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedFlipCounter(
              textStyle: const TextStyle(fontSize: 23,color: Colors.white),
              duration: const Duration(milliseconds: 500),
              value: int.parse(model.num_add!),
            ),
          ),
          // Text(
          //   model.num_add!,
          //   style: TextStyle(fontSize: 25,color: Colors.white),
          // ),

          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ),
  );
}

Widget two(list_auction_model model,BuildContext context) {
  return ClipRRect(
    borderRadius: context.read<LocaleBloc>().lang
      ?const BorderRadius.only(topRight: Radius.circular(20))
      :const BorderRadius.only(topLeft: Radius.circular(20)),
    child: Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border:  context.read<LocaleBloc>().lang
              ?const Border(
            bottom: BorderSide(color: Colors.white,width: 1),
            left: BorderSide(color: Colors.white,width:1),
          )
              :const Border(
            bottom: BorderSide(color: Colors.white,width: 1),
            right: BorderSide(color: Colors.white,width:1),
          )
      ),

      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Expanded(
              child: Image(
            image: AssetImage("assets/img/2.png"),
          )),
          Timer_widget(model.time!, context,Colors.white),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ),
  );
}

Widget three(list_auction_model model, BuildContext context) {
  var r = model.sub!.firstWhere((element) => element.contains("-${cache.get_data("id") ?? "]'/[;."}|"), orElse: () => "not|0").split("|")[1];
  return ClipRRect(
    borderRadius: context.read<LocaleBloc>().lang
        ?const BorderRadius.only(bottomLeft: Radius.circular(20))
        :const BorderRadius.only(bottomRight: Radius.circular(20)),
    child: Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border:  context.read<LocaleBloc>().lang
              ?const Border(
            top: BorderSide(color: Colors.white,width: 1),
            right: BorderSide(color: Colors.white,width:1),
          )
              :const Border(
            top: BorderSide(color: Colors.white,width: 1),
            left: BorderSide(color: Colors.white,width:1),
          )
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Expanded(
              child: Image(
            image: AssetImage("assets/img/3.png"),
          )),
          if (r == "0")
            Text(context.read<LocaleBloc>().not,style: const TextStyle(color: Colors.white,fontSize: 10),)
          else
            Directionality(
              textDirection: TextDirection.ltr,
              child: AnimatedFlipCounter(
                textStyle: const TextStyle(color: Colors.white,fontSize: 23),
                duration: const Duration(milliseconds: 500),
                value: int.parse(r),
              ),
            ),
          // Text(r == "0"?context.read<LocaleBloc>().not:r,style: TextStyle(fontSize: 20),),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ),
  );
}

Widget four(list_auction_model model, BuildContext context) {
  var r = model.sub?.indexOf(model.sub!.firstWhere((element) => element.contains("-${cache.get_data("id") ?? "]'/[;."}|"), orElse: () => "not in"));
  return ClipRRect(
    borderRadius: context.read<LocaleBloc>().lang
        ?const BorderRadius.only(bottomRight: Radius.circular(20))
        :const BorderRadius.only(bottomLeft: Radius.circular(20)),
    child: Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border:  context.read<LocaleBloc>().lang
              ?const Border(
            top: BorderSide(color: Colors.white,width: 1),
            left: BorderSide(color: Colors.white,width:1),
          )
              :const Border(
            top: BorderSide(color: Colors.white,width: 1),
            right: BorderSide(color: Colors.white,width:1),
          )
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Image(image: const AssetImage("assets/img/4.png"), color: (r! + 1) == 1 ? Colors.amber : Colors.white),
          ),
          Text(
            (r + 1).toString() == "0" ? context.read<LocaleBloc>().not : (r + 1).toString(),
            style: TextStyle(fontSize: 10, color: (r + 1) == 1 ? Colors.amber : Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ),
  );
}
// Widget sqr_list_item(context, index, home_squer_models item) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 4),
//     width: item.id == 4 ? MediaQuery.of(context).size.width : 150,
//     child: Row(
//       children: [
//         SizedBox(
//           width: 5,
//         ),
//         Expanded(
//           child: Container(
//             width: 10,
//             height: 50,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               color: item.id == 4 ? sec_color : Colors.transparent,
//             ),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Icon(
//                   Icons.account_circle,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       test_sqr[index].name!,
//                       style: TextStyle(color: item.id == 4 ? Colors.black : Colors.white),
//                     ),
//                     Text(
//                       "is paid: ${test_sqr[index].price}",
//                       style: TextStyle(color: item.id == 4 ? Colors.black : Colors.white, fontSize: 10),
//                     )
//                   ],
//                 ),
//                 Spacer(),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       (index + 1).toString(),
//                       style: TextStyle(color: item.id == 4 ? Colors.black : Colors.white, fontSize: 15),
//                     ),
//                     Container(
//                       height: 5,
//                       width: 5,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: item.id == 4 ? Colors.black : sec_color),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Scrollbar(
// controller: _scrollController,
// thumbVisibility: true,
// scrollbarOrientation: ScrollbarOrientation.left,
// child: ImplicitlyAnimatedReorderableList<home_squer_models>(
// items: test_sqr,
// physics: BouncingScrollPhysics(),
// controller: _scrollController,
// areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
// onReorderFinished: (item, from, to, newItems) {
// // Remember to update the underlying data when the list has been
// // reordered.
// },
// itemBuilder: (context, itemAnimation, item, index) {
// return Reorderable(
// key: ValueKey(item),
// builder: (context, dragAnimation, inDrag) {
// final t = dragAnimation.value;
// final elevation = lerpDouble(0, 8, t);
// final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);
// return SizeFadeTransition(
// sizeFraction: 0.7,
// curve: Curves.easeInOut,
// animation: itemAnimation,
// child: Material(
// color: color,
// elevation: elevation!,
// type: MaterialType.transparency,
// child: sqr_list_item(context, index, item),
// ),
// );
// },
// );
// },
// shrinkWrap: true,
// )
// // ListView.separated(
// //     //physics: BouncingScrollPhysics(),
// //     controller: _scrollController,
// //     shrinkWrap: true,
// //     itemCount: test_sqr.length,
// //     itemBuilder: (context, index) {
// //       return sqr_list_item(context,index);
// //     },
// //     separatorBuilder: (context, index) {
// //       return SizedBox(
// //         height: 10,
// //       );
// //     }),
// ),
