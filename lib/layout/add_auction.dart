
import 'package:auction_app/cache.dart';
import 'package:auction_app/layout/next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add/add_bloc.dart';
import '../bloc/home_page/home_page_list_bloc.dart';
import '../models/main_list_model.dart';
List city_list = ["جدة", "الرياض"];
// List type_list = [
//   "المركبات"
//   , "العقارات"
//   , "المنوعات"
//   , "لوحات السيارات"
//   , "أرقام الجوال"
// ];
// List typess = [
//   "vehicles"
//   , "real_estates"
//   , "mix"
//   , "vehicle_plates"
//   , "mobile_numbe"
// ];
var name_add_con = TextEditingController();
var des_add_con = TextEditingController();
var photo_add_con = TextEditingController();
var price_add_con = TextEditingController();
var min_price_add_con = TextEditingController();
var num_day_add_con = TextEditingController();
var text_slot_0_add_con = TextEditingController();
var text_slot_1_add_con = TextEditingController();
var text_slot_2_add_con = TextEditingController();
var city = "جدة";
var type ;
List a = [];
List b = [];
bool init_add = false;
main_list_model? slot;

class add_auction extends StatelessWidget {
  const add_auction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => AddBloc(),
),
    BlocProvider(
      create: (context) => HomePageListBloc()..get_main_list(),
    ),
  ],
  child: BlocConsumer<AddBloc, AddState>(
        listener: (context, state) {
          if(state is next){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Next()));
          }
        },
        builder: (context, state) {
            return Scaffold(
            appBar: AppBar(
              title: const Text("إضافة المزاد"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<HomePageListBloc,HomePageListState>(
                listener: (context,states){},
                builder: (context, states) {
          if(context.read<HomePageListBloc>().state.list!.isEmpty){
          return CircularProgressIndicator();
          }else {
                  return StatefulBuilder(
                    builder: (contex,setstate) {
                      return Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(hintText: "name"),
                            controller: name_add_con,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "des"),
                            controller: des_add_con,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "price"),
                            controller: price_add_con,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "min_price"),
                            controller: min_price_add_con,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(hintText: "num_day"),
                            controller: num_day_add_con,
                          ),
                          Builder(
                              builder: (context) {

                                if(!init_add &&context.read<HomePageListBloc>().state.list!.length != a.length ){

                                  init_add=true;
                                  context.read<HomePageListBloc>().state.list?.forEach((element) {
                                    a.add(element.ar_name);
                                    b.add(element.type);

                                  });
                                  type = a[0];
                                  slot=context.read<HomePageListBloc>().state.list?[0];
                                }

                                return Row(
                                  children: [const Spacer(),
                                    DropdownButton(items: city_list.map(drop_item).toList(), value: city, onChanged: (value) {
                                    setstate(() {
                                      city = value;
                                    });
                                  }),
                                    const Spacer(),
                                    DropdownButton(items: a.map(drop_item).toList(), value: type,hint: Text(""), onChanged: (value) {
                                      setstate(() {
                                        type = value!;
                                        slot =  context.read<HomePageListBloc>().state.list?.firstWhere((element) => element.ar_name == value);
                                      });
                                    }),
                                    const Spacer(),
                                  ],
                                );
                              }
                          ),
                          if(slot?.text_slot !=null)
                          for(int i =0; i < slot!.text_slot!.length ;i++)
                            Column(
                              children: [
                                SizedBox(height: 10,),
                                Text(slot!.text_slot![i]),
                                Container(width: double.infinity,height: 1,color: Colors.grey.shade700,),
                                SizedBox(height: 10,)
                              ],
                            ),

                          if(slot?.file_slot !=null)
                            for(int i =0; i < slot!.file_slot!.length ;i++)
                              Text(slot!.file_slot![i]),
                          ElevatedButton(onPressed: () {
                          AddBloc.get(context).add_void(cache.get_data("id"), name_add_con.text, des_add_con.text, price_add_con.text, min_price_add_con.text, num_day_add_con.text, city, b[a.indexOf(type)]);
                          }, child: const Text("إضافة"))
                        ],
                      );
                    }
                  );
                }
                },),
            ),
          );
          }

      ),
);
  }

  DropdownMenuItem drop_item(item) =>
      DropdownMenuItem(value: item, child: Center(child: Text(item)));
}
// map_picker()
//  TextButton(onPressed: (){
//    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
//    Navigator.push(
//    context,
//    MaterialPageRoute(
//      builder: (context) => PlacePicker(
//          apiKey: "AIzaSyCqchf2DwHinNmTS1QMcJQVftUVpEYyM0Y",
//          onPlacePicked: (result) {
//    print(result.adrAddress);
//    print(result);
//    print(result.name);
//    Navigator.of(context).pop();
//    },
//
//      initialPosition: LatLng(26,39),
//      useCurrentLocation: true,
//      resizeToAvoidBottomInset: false, // only works in page mode, less flickery, remove if wrong offsets
//    ),
//  ),
//    );}, child: Text("sss"))