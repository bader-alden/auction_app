import 'package:auction_app/cache.dart';
import 'package:auction_app/layout/next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../bloc/add/add_bloc.dart';
import '../bloc/home_page/home_page_list_bloc.dart';
import '../models/main_list_model.dart';
import 'map_picker.dart';

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
String? location;
List a = [];
List b = [];
bool init_add = false;
String? type;
main_list_model? slot;

class add_auction extends StatelessWidget {
  const add_auction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    init_add = false;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddBloc(),
        ),
        BlocProvider(
          create: (context) => HomePageListBloc()..get_main_list(),
        ),
      ],
      child: BlocConsumer<AddBloc, AddState>(listener: (context, state) {
        if (state is next) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Next()));
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("إضافة المزاد"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<HomePageListBloc, HomePageListState>(
              listener: (context, states) {},
              builder: (context, states) {
                if (context.read<HomePageListBloc>().state.list!.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return StatefulBuilder(builder: (contex, setstate) {
                    print(a);
                    print(a.length);
                    if (!init_add && context.read<HomePageListBloc>().state.list!.length != a.length) {
                      a.clear();
                      b.clear();
                      init_add = true;
                      context.read<HomePageListBloc>().state.list?.forEach((element) {
                        print(element.ar_name);
                        a.add(element.ar_name);
                        b.add(element.type);
                      });
                      type = a[0]!;
                      slot = context.read<HomePageListBloc>().state.list![0];
                    }

                    return ListView(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white)),
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: "name", border: InputBorder.none),
                            controller: name_add_con,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white)),
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: "des", border: InputBorder.none),
                            controller: des_add_con,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white)),
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: "price", border: InputBorder.none),
                            controller: price_add_con,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white)),
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: "min_price", border: InputBorder.none),
                            controller: min_price_add_con,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white)),
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: "num_day", border: InputBorder.none),
                            controller: num_day_add_con,
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            DropdownButton(
                                items: city_list.map(drop_item).toList(),
                                value: city,
                                onChanged: (value) {
                                  setstate(() {
                                    city = value;
                                  });
                                }),
                            const Spacer(),
                            DropdownButton(
                                items: a.map(drop_item).toList(),
                                value: type ?? "",
                                hint: Text("faa"),
                                onChanged: (value) {
                                  setstate(() {
                                    type = value!;
                                    slot = context.read<HomePageListBloc>().state.list?.firstWhere((element) => element.ar_name == value);
                                  });
                                  print(slot?.file_slot);
                                  print(slot?.file_slot?[0] == "");
                                  print(slot?.file_slot?.isEmpty);
                                  print(slot?.file_slot?.length);
                                }),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (slot?.text_slot != null && slot!.text_slot!.isNotEmpty) Center(child: Text("معلومات إضافية")),
                        if (slot?.text_slot != null && slot!.text_slot!.isNotEmpty)
                          for (int i = 0; i < slot!.text_slot!.length; i++)
                            Builder(
                              builder: (context) {
                                TextEditingController con ;
                                if(i == 0){
                                  con = text_slot_0_add_con;
                                }else if(i == 1){
                                  con = text_slot_1_add_con;
                                }else{
                                  con = text_slot_2_add_con;
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return add_rout_home(context, i,setstate);
                                                    });
                                              },
                                              child: Text("إضافة")),
                                          if(con.text != "")
                                            Icon(Icons.check),
                                          Spacer(),
                                          Text(slot!.text_slot![i]),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey.shade700,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              }
                            ),
                        if (slot!.file_slot!.isNotEmpty && slot?.file_slot?[0] != "") Center(child: Text("ملفات إضافية")),
                        if (slot!.file_slot!.isNotEmpty && slot?.file_slot?[0] != "")
                          for (int i = 0; i < slot!.file_slot!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(onPressed: () {}, child: Text("إضافة")),
                                      Spacer(),
                                      Text(slot!.file_slot![i]),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey.shade700,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                        if (slot?.with_location ?? false)
                          ElevatedButton(
                              onPressed: () async {
                                var _ = await showSimplePickerLocation(
                                  context: context,
                                  isDismissible: true,
                                  title: "أختر الموقع",
                                  textConfirmPicker: "إختيار",
                                  initCurrentUserPosition: true,
                                  textCancelPicker: "إلغاء",
                                  initZoom: 19,
                                );
                                location = "${_!.latitude.toString()} , ${_.longitude}";
                                //print(await location?.latitude);
                                print(location);
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>map_picker()));
                              },
                              child: Text("map")),
                        ElevatedButton(
                            onPressed: () {
                              AddBloc.get(context).add_void(cache.get_data("id"), name_add_con.text, des_add_con.text, price_add_con.text,
                                  min_price_add_con.text, num_day_add_con.text, city, b[a.indexOf(type)]);
                            },
                            child: const Text("إضافة"))
                      ],
                    );
                  });
                }
              },
            ),
          ),
        );
      }),
    );
  }

  DropdownMenuItem drop_item(item) => DropdownMenuItem(value: item, child: Center(child: Text(item)));
}

Widget add_rout_home(context, index,setstate) {
  TextEditingController con ;
  if(index == 0){
    con = text_slot_0_add_con;
  }else if(index == 1){
    con = text_slot_1_add_con;
  }else{
    con = text_slot_2_add_con;
  }
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    actionsPadding: EdgeInsets.all(20),
    content: Container(
      width: double.maxFinite,
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Center(
              child: Text(
            slot!.text_slot![index],
            style: TextStyle(fontSize: 30, fontFamily: "adobe", color: Colors.white),
          )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade400,
              ),
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextFormField(
                  controller: con,
                  scrollPadding: EdgeInsets.all(0),
                  style: TextStyle(fontSize: 16),
                  maxLines: null,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 17, 10, 64), borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setstate((){});
// if (title_con.text != "" && body_con.text != "") {
//   is_edit
//       ? app_bloc.get(acontext).updatesecdata(title_con.text, body_con.text, app_bloc.get(acontext).secdetails[old_title])
//       : app_bloc.get(acontext).insertsecdb(title_con.text, body_con.text, "no", DateTime.now().toString());
//   title_con.text = "";
//   body_con.text = "";
//   Navigator.pop(context);
// } else {
//   tost(msg: "يرجى ملئ الفراغات", color: Colors.red);
// }
                    },
                    child: Center(
                        child: Text(
                      "موافق",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "adobe"),
                    )),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 30,
              // ),
//               Expanded(
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(color: Color.fromARGB(255, 17, 10, 64), borderRadius: BorderRadius.circular(10)),
//                   child: Center(
//                       child: TextButton(
//                     onPressed: () {
// //body_con.text = "";
// //title_con.text = "";
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "إلغاء",
//                       style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "adobe"),
//                     ),
//                   )),
//                 ),
//               ),
            ],
          )
        ],
      ),
    ),
  );
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
