import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/layout/next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/add/add_bloc.dart';
import '../bloc/home_page/home_page_list_bloc.dart';
import '../bloc/locale/locale_bloc.dart';
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

class add_auction extends StatelessWidget {
  const add_auction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
    List all_kind = [];
    List all_kind_time = [];
    bool init_add = false;
    String? type;
    String? kind;
    main_list_model? slot;
    String name_text_1="";
    String name_text_2="";
    String name_text_3 = "";
    int my_price=100;
    init_add = false;
bool is_loading=false;
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
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);},
                icon: context
                    .read<LocaleBloc>()
                    .lang
                    ? Icon(Icons.arrow_forward_ios, color: Theme
                    .of(context)
                    .brightness == Brightness.dark ? Colors.white : Colors.black)
                    : Icon(Icons.arrow_back_ios, color: Theme
                    .of(context)
                    .brightness == Brightness.dark ? Colors.white : Colors.black)),
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
                    if (!init_add && context.read<HomePageListBloc>().state.list!.length != a.length) {
                      a.clear();
                      b.clear();
                      init_add = true;
                      context.read<HomePageListBloc>().state.list?.forEach((element) {
                        a.add(element.ar_name);
                        b.add(element.type);
                      });
                      type = a[0]!;
                      slot = context.read<HomePageListBloc>().state.list![0];
                      slot?.all_kind?.forEach((element) {
                        all_kind.add(element.kind);
                        all_kind_time.add(element.time);
                      });
                      kind=all_kind[0];
                      num_day_add_con.text=all_kind_time[0];
                    }

                    return ListView(
                      physics: BouncingScrollPhysics(),
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 15),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton(
                                    underline: Text(""),
                                    borderRadius: BorderRadius.circular(20),
                                      items: a.map(drop_item).toList(),
                                      value: type ?? "",
                                      hint: Text("faa"),
                                      onChanged: (value) {
                                        setstate(() {
                                          type = value!;
                                          slot = context.read<HomePageListBloc>().state.list?.firstWhere((element) => element.ar_name == value);
                                          all_kind.clear();
                                          all_kind_time.clear();
                                          slot?.all_kind?.forEach((element) {
                                            print(element.time);
                                            all_kind.add(element.kind);
                                            all_kind_time.add(element.time);
                                          });
                                          kind=all_kind[0];
                                          num_day_add_con.text=all_kind_time[0];
                                        });
                                      }),
                                ),
                                Spacer(),
                                Text(":النوع",style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton(
                                      underline: Text(""),
                                      borderRadius: BorderRadius.circular(20),
                                      items: all_kind.map(drop_item).toList(),
                                      value: kind ?? "",
                                      hint: Text(" "),
                                      onChanged: (value) {
                                        setstate(() {
                                          kind = value!;
                                          num_day_add_con.text=all_kind_time[all_kind.indexOf(kind)];
                                          print(all_kind);
                                          print(kind);
                                        });
                                      }),
                                ),
                                Spacer(),
                                Text(":الصنف",style: TextStyle(fontSize: 20),),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("الاسم:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                            controller: name_add_con,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text("الوصف:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
                        Container(
                          height: 150,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                            controller: des_add_con,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text("السعر المبدئي:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                            controller: min_price_add_con,
                          ),
                        ),

                        SizedBox(height: 15),
                        Text("أقل مزايدة:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (my_price - 100 >= 100) {
                                      setstate(() {
                                        my_price = my_price - 100;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    // color: Colors.red,
                                    child: Center(
                                      child: const Text(
                                        "-",
                                        style: TextStyle(fontSize: 40,height: 0.9),
                                      ),
                                    ),
                                  )),
                              AnimatedFlipCounter(
                                duration: const Duration(milliseconds: 500),
                                value: my_price,
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                  onTap: () {
                                    setstate(() {
                                      my_price = my_price + 100;
                                    });
                                  },
                                  child: const Text(
                                    "+",
                                    style: TextStyle(fontSize: 40),
                                  )),
                            ],
                          ),

                          // child: TextFormField(
                          //   textDirection: TextDirection.rtl,
                          //   decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                          //   controller: price_add_con,
                          // ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 50,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              child: TextFormField(
                                textDirection: TextDirection.rtl,
                                decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                                controller: num_day_add_con,
                                readOnly: true,
                              ),
                            ),
                            Text("عدد أيام عرض المزاد:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            DropdownButton(
                                items: city_list.map(drop_item).toList(),
                                value: city,
                                onChanged: (value) {
                                  setstate(() {
                                    city = value;
                                  });
                                }),
                            Spacer(),
                            Text(":المدينة التي يوجد بها المنتج",style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (slot?.text_slot?[0] != "" && slot!.text_slot!.isNotEmpty) Center(child: Text("معلومات إضافية",style: TextStyle(fontSize: 25),)),
                        if (slot?.text_slot?[0] != ""  && slot!.text_slot!.isNotEmpty)
                          for (int i = 0; i < slot!.text_slot!.length; i++)
                            Builder(
                              builder: (context) {
                                TextEditingController con ;
                                if(i == 0){
                                  name_text_1=slot!.text_slot![0];
                                  con = text_slot_0_add_con;
                                }else if(i == 1){
                                  name_text_2=slot!.text_slot![1];
                                  con = text_slot_1_add_con;
                                }else{
                                  name_text_3=slot!.text_slot![2];
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
                                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(con.text != "" ?Colors.green:Colors.red)),
                                              onPressed: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return add_rout_home(context, i,text_slot_0_add_con,text_slot_1_add_con,text_slot_2_add_con,slot,setstate);
                                                    });
                                              },
                                              child:
                                              con.text != ""
                                              ?Icon(Icons.check,color: Colors.white,)
                                                  :Text( "إضافة")),
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
                        if (slot!.file_slot!.isNotEmpty && slot?.file_slot?[0] != "") Center(child: Text("ملفات إضافية",style: TextStyle(fontSize: 25),)),
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
                                      if("a"=="b")
                                      ElevatedButton(onPressed: () async {
                                        final XFile? image =await  ImagePicker().pickImage(source: ImageSource.gallery);
                                      }, child: Text("إضافة")),
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
                        // if (slot?.with_location ?? false)
                        //   ElevatedButton(
                        //       onPressed: () async {
                        //         var _ = await showSimplePickerLocation(
                        //           context: context,
                        //           isDismissible: true,
                        //           title: "أختر الموقع",
                        //           textConfirmPicker: "إختيار",
                        //           initCurrentUserPosition: true,
                        //           textCancelPicker: "إلغاء",
                        //           initZoom: 19,
                        //         );
                        //         location = "${_!.latitude.toString()} , ${_.longitude}";
                        //         if(location !=null){
                        //           setstate((){});
                        //         }
                        //         //print(await location?.latitude);
                        //         print(location);
                        //         //Navigator.push(context, MaterialPageRoute(builder: (context)=>map_picker()));
                        //       },
                        //       child: Text("map")),
                        if (slot?.with_location ?? false) Center(child: Text("الموقع",style: TextStyle(fontSize: 25),)),
                        if (slot?.with_location ?? false)
                        InkWell(
                          onTap: () async {
                             showSimplePickerLocation(
                              context: context,
                              isDismissible: true,
                              title: "أختر الموقع",
                              textConfirmPicker: "إختيار",
                              initCurrentUserPosition: true,
                              textCancelPicker: "إلغاء",
                              initZoom: 19,
                            ).then((value) {
                              if(value!=null){
                                location = "${value.latitude.toString()} , ${value.longitude}";
                                  setstate((){});
                                //print(await location?.latitude);
                                print(location);
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>map_picker()));
                              }
                             });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image(image: NetworkImage("https://media.istockphoto.com/id/1306807452/vector/map-city-vector-illustration.jpg?b=1&s=612x612&w=0&k=20&c=RBfRJ1UZ4D-2F1HVkeZ0SHVmPWqj3eS9batfcKiQzW4="),),
                              Container(color: Colors.grey.withOpacity(0.3),width:double.infinity,height: 200,),
                              Column(
                                children: [
                                  if(location==null)
                                  Text("إنقر لأضافة موقع",style: TextStyle(fontSize: 25)),
                                  Icon(Icons.location_on_outlined,size: 50,color: location==null ? Colors.red: Colors.green,)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: () {
                              if(!slot!.with_location!){
                                location =" ";
                              }
                              if(name_add_con.text.isNotEmpty &&des_add_con.text.isNotEmpty&&price_add_con.text.isNotEmpty&& min_price_add_con.text.isNotEmpty&&num_day_add_con.text.isNotEmpty && num_day_add_con.text.isNotEmpty
                              &&city.isNotEmpty &&location !=null ) {
                                setstate((){
                                  is_loading= true;
                                });
                                AddBloc.get(context).add_void(cache.get_data("id"), name_add_con.text, des_add_con.text, price_add_con.text,
                                  min_price_add_con.text, num_day_add_con.text, city, b[a.indexOf(type)],location,text_slot_0_add_con.text,text_slot_1_add_con.text,text_slot_2_add_con.text,kind,name_text_1,name_text_2,name_text_3);

                              }else{
                                tost(msg: "يرجى ملئ جميع البيانات",color: Colors.red);
                              }
                            },
                            child: is_loading?Center(child: CircularProgressIndicator(color: Colors.white,),): Text("إضافة"),
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_red)),)
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

Widget add_rout_home(context, index,text_slot_0_add_con,text_slot_1_add_con,text_slot_2_add_con,slot,setstate) {
  TextEditingController con ;
  if(index == 0){
    con = text_slot_0_add_con;
  }else if(index == 1){
    con = text_slot_1_add_con;
  }else{
    con = text_slot_2_add_con;
  }
  return WillPopScope(
    onWillPop: ()async{
      setstate((){});
      return true;
    },
    child: AlertDialog(
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
              style: TextStyle(fontSize: 30, fontFamily: "adobe"),
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
