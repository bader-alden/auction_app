import 'package:auction_app/cache.dart';
import 'package:auction_app/layout/next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add/add_bloc.dart';

List city_list = ["جدة", "الرياض"];
List type_list = [
  "المركبات"
  , "العقارات"
  , "المنوعات"
  , "لوحات السيارات"
  , "أرقام الجوال"
];
List typess = [
  "vehicles"
  , "real_estates"
  , "mix"
  , "vehicle_plates"
  , "mobile_numbe"
];
var name_add_con = TextEditingController();
var des_add_con = TextEditingController();
var photo_add_con = TextEditingController();
var price_add_con = TextEditingController();
var min_price_add_con = TextEditingController();
var num_day_add_con = TextEditingController();
var city = "جدة";
var type = "المركبات";


class add_auction extends StatelessWidget {
  const add_auction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBloc(),
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
              title: const Text("هذا الشكل مبدئي"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                  StatefulBuilder(
                      builder: (context, setstate) {
                        return Row(
                          children: [const Spacer(), DropdownButton(items: city_list.map(drop_item).toList(), value: city, onChanged: (value) {
                            setstate(() {
                              city = value;
                            });
                          }), const Spacer(),
                            DropdownButton(items: type_list.map(drop_item).toList(), value: type, onChanged: (value) {
                              setstate(() {
                                type = value;
                              });
                            }),
                            const Spacer(),
                          ],
                        );
                      }
                  ),
                  ElevatedButton(onPressed: () {
                  AddBloc.get(context).add_void(cache.get_data("id"), name_add_con.text, des_add_con.text, price_add_con.text, min_price_add_con.text, num_day_add_con.text, city, typess[type_list.indexOf(type)]);
                  }, child: const Text("إضافة"))
                ],
              ),
            ),
          );
        },
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