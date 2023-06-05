import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/layout/Home_page_new.dart';
import 'package:auction_app/layout/add_auction_main_data.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/enums/dropdown_align.dart';
import 'package:cool_dropdown/enums/dropdown_animation.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:cool_dropdown/options/dropdown_options.dart';
import 'package:cool_dropdown/options/dropdown_triangle_options.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../bloc/add/add_bloc.dart';
import '../bloc/home_page/home_page_list_bloc.dart';
import '../main.dart';
import '../models/main_list_model.dart';
import 'Terms_page.dart';
import 'package:auction_app/dio.dart';
import 'package:http/http.dart' as http;

List<String> all_num = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
List<String> all_latter = [
  "أ / A",
  "ب / B",
  "د / D",
  "ع / E",
  "ق / G",
  "ھ / H",
  "ح / J",
  "ك / K",
  "ل / L",
  "ن / N",
  "ر / R",
  "س / S",
  "ط / T",
  "و / U",
  "ى / V",
  "ص / X",
  "م / Z",
];
List<String> all_latter_val = ["A", "B", "D", "E", "G", "H", "J", "K", "L", "N", "R", "S", "T", "U", "V", "X", "Z"];
//List city_list = ["جدة", "الرياض"];
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

bool is_terms_check = false;


class add_auction extends StatelessWidget {
  const add_auction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var name_add_con = TextEditingController();
    var des_add_con = TextEditingController();
    var city_con = TextEditingController();
    var price_add_con = TextEditingController();
    var min_price_add_con = TextEditingController();
    var num_day_add_con = TextEditingController();
    var text_slot_0_add_con = TextEditingController();
    var text_slot_1_add_con = TextEditingController();
    var text_slot_2_add_con = TextEditingController();
    var plate_drop1 = DropdownController();
    var plate_drop2 = DropdownController();
    var plate_drop3 = DropdownController();
    var plate_drop4 = DropdownController();
    var plate_drop5 = DropdownController();
    var plate_drop6 = DropdownController();
    var plate_drop7 = DropdownController();
    var plate_drop1_val = "";
    var plate_drop2_val = "";
    var plate_drop3_val = "";
    var plate_drop4_val = "";
    var plate_drop5_val = "";
    var plate_drop6_val = "";
    var plate_drop7_val = "";
    List<DropdownController> all_plate = [plate_drop1, plate_drop2, plate_drop3, plate_drop4];
    List<String> all_plate_val = [plate_drop1_val, plate_drop2_val, plate_drop3_val, plate_drop4_val];
    List<DropdownController> all_plate2 = [plate_drop5, plate_drop6, plate_drop7];
    List<String> all_plate2_val = [plate_drop5_val, plate_drop6_val, plate_drop7_val];
    var city;
    String? location;
    List<int> f1 = [];
    List<int> f2 = [];
    List<int> f3 = [];
    List a = [];
    List b = [];
    List all_kind = [];
    List all_kind_time = [];
    List all_kind_main_data = [];
    List citys_list = [];
    bool init_add = false;
    bool is_hide = false;
    String? type;
    String? kind;
    main_list_model? slot;
    String name_text_1 = "";
    String name_text_2 = "";
    String name_text_3 = "";
    String file_slot_1_url = "";
    String file_slot_2_url = "";
    String file_slot_3_url = "";
    String main_photo_url = "";
    String list_photo_url = "";
    FilePickerResult? file_slot_1;
    FilePickerResult? file_slot_2;
    FilePickerResult? file_slot_3;
    String main_data_empty = "";
    String main_data = "";
    PickedFile? main_image;
    List<PickedFile?> list_image = [];
    int my_price = 100;
    Uint8List? plate_link ;
    init_add = false;
    bool start_uplode = false;
    var number_of_uploade = 0;
    double presint = 0;
    String name_of_porsses = "";

    bool is_loading = false;
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
          showDialog<void>(
            context: context,
            barrierDismissible: false, // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                content: Text('ستتم مراجعة مزادك خلال مدة اقصاها يومان'),
                actions: <Widget>[
                  TextButton(
                    child: Text('موافق'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => App()), (route) => false);
                    },
                  ),
                ],
              );
            },
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("إضافة المزاد"),
            leading: back_boutton(context),
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
                      is_terms_check = false;
                      context.read<HomePageListBloc>().state.list?.forEach((element) {
                        if (!(element.is_soon ?? true)) {
                          a.add(element.ar_name);
                          b.add(element.type);
                        }
                      });
                      type = a[0]!;
                      slot = context.read<HomePageListBloc>().state.list!.where((element) => !element.is_soon!).first;
                      slot?.all_kind?.forEach((element) {
                        all_kind.add(element.kind);
                        all_kind_time.add(element.time);
                        all_kind_main_data.add(element.main_data);
                      });
                      kind = all_kind[0];
                      num_day_add_con.text = all_kind_time[0];
                      main_data_empty = all_kind_main_data[0];
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
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
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
                                          all_kind_main_data.clear();
                                          main_data = "";
                                          slot?.all_kind?.forEach((element) {
                                            print(element.main_data);
                                            all_kind.add(element.kind);
                                            all_kind_time.add(element.time);
                                            all_kind_main_data.add(element.main_data);
                                          });
                                          kind = all_kind[0];
                                          num_day_add_con.text = all_kind_time[0];
                                          main_data_empty = all_kind_main_data[0];
                                        });
                                      }),
                                ),
                                Spacer(),
                                Text(
                                  ":النوع",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton(
                                      underline: Text(""),
                                      borderRadius: BorderRadius.circular(20),
                                      items: all_kind.map(drop_item).toList(),
                                      value: kind ?? "",
                                      hint: Text(" "),
                                      onChanged: (value) {
                                        setstate(() {
                                          kind = value!;
                                          main_data = "";
                                          num_day_add_con.text = all_kind_time[all_kind.indexOf(kind)];
                                          main_data_empty = all_kind_main_data[all_kind.indexOf(kind)];
                                          print(all_kind);
                                          print(kind);
                                        });
                                      }),
                                ),
                                Spacer(),
                                Text(
                                  ":الصنف",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "الاسم:",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration(border: InputBorder.none, hintTextDirection: TextDirection.rtl),
                            controller: name_add_con,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "الوصف:",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 150,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration(border: InputBorder.none, hintTextDirection: TextDirection.rtl),
                            controller: des_add_con,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "السعر المبدئي:",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(border: InputBorder.none, hintTextDirection: TextDirection.rtl),
                            controller: price_add_con,
                          ),
                        ),
                        // SizedBox(height: 15),
                        // Text(
                        //   "أقل مزايدة:",
                        //   textDirection: TextDirection.rtl,
                        //   style: TextStyle(fontSize: 20),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(15),
                        //   decoration: BoxDecoration(
                        //       color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                        //       borderRadius: BorderRadius.circular(8)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       InkWell(
                        //           onTap: () {
                        //             if (my_price - 100 >= 100) {
                        //               setstate(() {
                        //                 my_price = my_price - 100;
                        //               });
                        //             }
                        //           },
                        //           child: Container(
                        //             height: 35,
                        //             width: 35,
                        //             // color: Colors.red,
                        //             child: Center(
                        //               child: const Text(
                        //                 "-",
                        //                 style: TextStyle(fontSize: 40, height: 0.9),
                        //               ),
                        //             ),
                        //           )),
                        //       AnimatedFlipCounter(
                        //         duration: const Duration(milliseconds: 500),
                        //         value: my_price,
                        //         textStyle: TextStyle(
                        //             fontSize: 30,
                        //             color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       InkWell(
                        //           onTap: () {
                        //             setstate(() {
                        //               my_price = my_price + 100;
                        //             });
                        //           },
                        //           child: const Text(
                        //             "+",
                        //             style: TextStyle(fontSize: 40),
                        //           )),
                        //     ],
                        //   ),
                        //
                        //   // child: TextFormField(
                        //   //   textDirection: TextDirection.rtl,
                        //   //   decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                        //   //   controller: price_add_con,
                        //   // ),
                        // ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              " مخفي",
                              style: TextStyle(color: is_hide ? main_red : Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                            ),
                            SizedBox(width: 5),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: CupertinoSwitch(
                                    activeColor: main_red,
                                    value: is_hide,
                                    onChanged: (value) => setstate(() {
                                          is_hide = value;
                                        }))),
                            SizedBox(width: 5),
                            Text(
                              "غير مخفي",
                              style: TextStyle(color: !is_hide ? main_red : Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "حالة السعر:",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "ريال سعودي",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              slot?.price ?? "",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "تكاليف عرض المزاد:",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 50,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              child: TextFormField(
                                textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(border: InputBorder.none, hintTextDirection: TextDirection.rtl),
                                controller: num_day_add_con,
                                readOnly: true,
                              ),
                            ),
                            Text(
                              "عدد أيام عرض المزاد:",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            // FutureBuilder(
                            //     future: dio.get_data(url:"/dash/city"),
                            //     builder: (context,snap) {
                            //       print(snap.data?.data);
                            //       print(snap.data);
                            //       if(snap.connectionState == ConnectionState.waiting  ){
                            //       return Center(child: CircularProgressIndicator(color: main_red,));
                            //   //    DropdownMenuItem drop_item(item) => DropdownMenuItem(value: item, child: Center(child: Text(item)));
                            //       }else {
                            //         var citys_list = snap.data?.data as List;
                            //       return DropdownButton(
                            //         items: citys_list.map((e)=>DropdownMenuItem(value: e["namecity"],child: Center(child: Text(e["namecity"]),),)).toList(),
                            //         value: city,
                            //         onChanged: (value) {
                            //           setstate(() {
                            //             city = value.toString();
                            //           });
                            //         });
                            //     }
                            //   }
                            // ),
                            Expanded(
                              child: FutureBuilder(
                                  future: dio.get_data(url: "/dash/city"),
                                  builder: (context, snap) {
                                    if (snap.connectionState == ConnectionState.waiting && citys_list.isEmpty) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: main_red,
                                      ));
                                      //    DropdownMenuItem drop_item(item) => DropdownMenuItem(value: item, child: Center(child: Text(item)));
                                    } else if (snap.data?.data != null) {
                                      citys_list = snap.data?.data as List;
                                      return CustomDropdown.search(
                                          fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                                          items: citys_list.map((e) => e["namecity"].toString()).toList(),
                                          hintText: ":المدينة التي يوجد بها المنتج",
                                          hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                          errorText: "غير موجود",
                                          onChanged: (value) {
                                            setstate(() {
                                              city = value.toString();
                                              city_con.text = value.toString();
                                            });
                                          },
                                          controller: city_con,
                                          listItemBuilder: (context, text) {
                                            return Center(
                                              child: Text(
                                                text,
                                                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                              ),
                                            );
                                          });
                                    } else {
                                      return Center();
                                    }
                                  }),
                            ),
                            // Spacer(),
                            // Text(
                            //   ":المدينة التي يوجد بها المنتج",
                            //   style: TextStyle(fontSize: 20),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          "معلومات الأساسية",
                          style: TextStyle(fontSize: 25),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                              onPressed: () async {
                                final main_data_pop = await Navigator.push(context, MaterialPageRoute(builder: (context) => add_auction_main_data(row: main_data_empty, old: main_data)));
                                if (main_data_pop != null) {
                                  setstate(() {
                                    main_data = main_data_pop;
                                  });
                                }
                              },
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_data != "" ? Colors.green : main_red)),
                              child: main_data != ""
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : Text("تعبئة")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (slot?.text_slot?[0] != "" && slot!.text_slot!.isNotEmpty)
                          Center(
                              child: Text(
                            "معلومات إضافية",
                            style: TextStyle(fontSize: 25),
                          )),
                        if (slot?.text_slot?[0] != "" && slot!.text_slot!.isNotEmpty)
                          for (int i = 0; i < slot!.text_slot!.length; i++)
                            Builder(builder: (context) {
                              TextEditingController con;
                              if (i == 0) {
                                name_text_1 = slot!.text_slot![0];
                                con = text_slot_0_add_con;
                              } else if (i == 1) {
                                name_text_2 = slot!.text_slot![1];
                                con = text_slot_1_add_con;
                              } else {
                                name_text_3 = slot!.text_slot![2];
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
                                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(con.text != "" ? Colors.green : Colors.red)),
                                            onPressed: () {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return add_rout_home(context, i, text_slot_0_add_con, text_slot_1_add_con, text_slot_2_add_con, slot, setstate);
                                                  });
                                            },
                                            child: con.text != ""
                                                ? Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  )
                                                : Text("إضافة")),
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
                            }),
                        if (slot!.file_slot!.isNotEmpty && slot?.file_slot?[0] != "")
                          Center(
                              child: Text(
                            "ملفات إضافية",
                            style: TextStyle(fontSize: 25),
                          )),
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
                                      if(i == 0 && f1.isEmpty || i == 1 && f2.isEmpty || i == 2 && f3.isEmpty)
                                      ElevatedButton(
                                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(i == 0 && f1.isNotEmpty || i == 1 && f2.isNotEmpty || i == 2 && f3.isNotEmpty ? Colors.green : Colors.red)),
                                          onPressed: () async {
                                            if (i == 0) {
                                              showDialog(context: context, builder: (context)=>AlertDialog(
                                                title: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await ImagePicker.platform.pickImage(source: ImageSource.camera).then((value) async {
                                                          await value?.readAsBytes().then((value) => f1 = value.toList());
                                                          setstate(() {});
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: Text("إختيار من الكمرة"),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.camera,color: main_red,)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    InkWell(
                                                      onTap: () async {
                                                        await ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value) async {
                                                          await value?.readAsBytes().then((value) => f1 = value.toList());
                                                          setstate(() {});
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: Text("إختيار من الصور"),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.photo,color: main_red,)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                              // file_slot_1 = await FilePicker.platform.pickFiles(allowMultiple: false, allowedExtensions: ["pdf"], type: FileType.custom);
                                              // File(file_slot_1!.files.first.path!).readAsBytes().then((value) => f1 = value.toList());

                                            }
                                            if (i == 1) {
                                              showDialog(context: context, builder: (context)=>AlertDialog(
                                                title: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await ImagePicker.platform.pickImage(source: ImageSource.camera).then((value) async {
                                                          await value?.readAsBytes().then((value) => f2 = value.toList());
                                                          setstate(() {});
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: Text("إختيار من الكمرة"),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.camera,color: main_red,)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    InkWell(
                                                      onTap: () async {
                                                        await ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value) async {
                                                          await value?.readAsBytes().then((value) => f2 = value.toList());
                                                          setstate(() {});
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: Text("إختيار من الصور"),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.photo,color: main_red,)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                              // file_slot_1 = await FilePicker.platform.pickFiles(allowMultiple: false, allowedExtensions: ["pdf"], type: FileType.custom);
                                              // File(file_slot_1!.files.first.path!).readAsBytes().then((value) => f1 = value.toList());

                                            }
                                            if (i == 2) {
                                              showDialog(context: context, builder: (context)=>AlertDialog(
                                                title: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await ImagePicker.platform.pickImage(source: ImageSource.camera).then((value) async {
                                                          await value?.readAsBytes().then((value) => f3 = value.toList());
                                                          setstate(() {});
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: Text("إختيار من الكمرة"),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.camera,color: main_red,)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    InkWell(
                                                      onTap: () async {
                                                        await ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value) async {
                                                          await value?.readAsBytes().then((value) => f3 = value.toList());
                                                          setstate(() {});
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                            child: Text("إختيار من الصور"),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.photo,color: main_red,)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                              // file_slot_1 = await FilePicker.platform.pickFiles(allowMultiple: false, allowedExtensions: ["pdf"], type: FileType.custom);
                                              // File(file_slot_1!.files.first.path!).readAsBytes().then((value) => f1 = value.toList());

                                            }
                                          },
                                          child: i == 0 && f1.isNotEmpty || i == 1 && f2.isNotEmpty|| i == 2 && f3.isNotEmpty ? Icon(Icons.check) : Text("إضافة"))
                                      else
                                        Row(
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                                onPressed: (){
                                                  if(i==0){
                                                    f1.clear();
                                                    setstate((){});
                                                  }
                                                  if(i==1){
                                                    f2.clear();
                                                    setstate((){});
                                                  }
                                                  if(i==2){
                                                    f3.clear();
                                                    setstate((){});
                                                  }
                                                }, child: Icon(Icons.delete)),
                                            SizedBox(width: 10,),
                                            ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                                                onPressed: (){

                                                  showDialog(context: context, builder: (context)=>AlertDialog(
                                                    title: Row(
                                                      children: [
                                                        IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.close)),
                                                        Spacer(),
                                                        Text(slot!.file_slot![i]),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                    content: Image.memory(Uint8List.fromList(i==0?f1:i==1?f2:f3)),
                                                  ));
                                                }, child: Text("عرض")),
                                          ],
                                        ),
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
                        Center(
                            child: Text(
                          slot?.is_plate ?? false ? "أرقام اللوحة" : "الصور",
                          style: TextStyle(fontSize: 25),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        if (slot?.is_plate ?? false)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: all_plate
                                    .map(
                                      (con) => CoolDropdown(
                                        controller: con,
                                        dropdownList: all_num.map((e) => CoolDropdownItem(label: e, value: e)).toList(),
                                        defaultItem: null,
                                        onChange: (value) async {
                                          if (con.isError) {
                                            await con.resetError();
                                          }
                                          all_plate_val[all_plate.indexOf(con)] = value;
                                          con.close();
                                        }, dropdownItemOptions: DropdownItemOptions(
                                          selectedBoxDecoration:  BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300),
                                          boxDecoration: BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                          textStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                                        dropdownOptions: DropdownOptions(
                                          color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                                        ),
                                        resultOptions: ResultOptions(
                                          textStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          width: 60,
                                          icon: const SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CustomPaint(
                                              painter: DropdownArrowPainter(),
                                            ),
                                          ),
                                          boxDecoration: BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,borderRadius: BorderRadius.circular(7)),
                                          openBoxDecoration: BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300),
                                          render: ResultRender.all,
                                          placeholder: '',
                                          isMarquee: true,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: all_plate2
                                    .map(
                                      (con) => CoolDropdown(
                                        controller: con,
                                        dropdownList: all_latter.map((e) => CoolDropdownItem(label: e, value: all_latter_val[all_latter.indexOf(e)])).toList(),
                                        defaultItem: null,
                                        onChange: (value) async {
                                          if (con.isError) {
                                            await con.resetError();
                                          }

                                          all_plate2_val[all_plate2.indexOf(con)] = value;
                                          con.close();
                                        },
                                        dropdownItemOptions: DropdownItemOptions(
                                          selectedBoxDecoration:  BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300),
                                         boxDecoration: BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                            textStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                                        dropdownOptions: DropdownOptions(
                                          color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                                        ),
                                        resultOptions: ResultOptions(
                                          textStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          width: 100,
                                          icon: const SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CustomPaint(
                                              painter: DropdownArrowPainter(),
                                            ),
                                          ),
                                          boxDecoration: BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,borderRadius: BorderRadius.circular(7)),
                                          openBoxDecoration: BoxDecoration(color:  Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300),
                                          render: ResultRender.all,
                                          placeholder: '',
                                          isMarquee: true,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          )
                        else
                          SizedBox(
                            height: 200,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      main_image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                                      setstate(() {});
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        main_image != null
                                            ? Image.file(File(main_image!.path))
                                            : Container(
                                                color: Colors.grey.shade200,
                                                height: 200,
                                                width: 250,
                                                child: SizedBox(
                                                    width: 200,
                                                    child: Center(
                                                        child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor: Colors.grey,
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Colors.white,
                                                            )))),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(Icons.star, color: Colors.yellow.shade800),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if (list_image != [])
                                  ...list_image.map((e) => Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.file(File(e!.path)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: IconButton(
                                                onPressed: () {
                                                  list_image.remove(e);
                                                  setstate(() {});
                                                },
                                                iconSize: 30,
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          )
                                        ],
                                      )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      //  var a  = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                                      var a = await ImagePicker.platform.pickMultiImage();
                                      list_image.addAll(a!.toList());
                                      setstate(() {});
                                    },
                                    child: Container(
                                      color: Colors.grey.shade200,
                                      height: 150,
                                      width: 250,
                                      child: SizedBox(
                                          width: 200,
                                          child: Center(
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        if (slot?.with_location ?? false)
                          Center(
                              child: Text(
                            "الموقع",
                            style: TextStyle(fontSize: 25),
                          )),
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
                                if (value != null) {
                                  location = "${value.latitude.toString()} , ${value.longitude}";
                                  setstate(() {});
                                  //print(await location?.latitude);
                                  print(location);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>map_picker()));
                                }
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image(
                                  image: NetworkImage("https://media.istockphoto.com/id/1306807452/vector/map-city-vector-illustration.jpg?b=1&s=612x612&w=0&k=20&c=RBfRJ1UZ4D-2F1HVkeZ0SHVmPWqj3eS9batfcKiQzW4="),
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: double.infinity,
                                  height: 200,
                                ),
                                Column(
                                  children: [
                                    if (location == null) Text("إنقر لأضافة موقع", style: TextStyle(fontSize: 25)),
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 50,
                                      color: location == null ? Colors.red : Colors.green,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Terms_page(
                                                with_init: false,
                                                inh_terms: slot?.terms,
                                              )));
                                },
                                child: Text(
                                  " أحكام و شروط " + type.toString(),
                                  style: TextStyle(fontSize: 16),
                                )),
                            Text(
                              "الموافقة على ",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  setstate(() {
                                    is_terms_check = !is_terms_check;
                                  });
                                },
                                child: Container(decoration: BoxDecoration(border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black), borderRadius: BorderRadius.circular(5)), width: 30, height: 30, child: is_terms_check ? Icon(Icons.check) : null)),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!slot!.with_location!) {
                              location = " ";
                            }

                            if (name_add_con.text.isNotEmpty && des_add_con.text.isNotEmpty && price_add_con.text.isNotEmpty && num_day_add_con.text.isNotEmpty && city.isNotEmpty && location != null && is_terms_check && main_data != "" && slot!.is_plate! ? main_image == null:main_image!=null) {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    //   title: Center(child: Text('...جار الرفع')),
                                    actions: <Widget>[
                                      StatefulBuilder(builder: (acontext, settate) {
                                        if (!start_uplode) {
                                          try {
                                            Future.sync(() async {
                                              start_uplode = true;
                                                name_of_porsses = "الصورة الرئيسية";
                                                settate(() {});
                                                if(slot!.is_plate!){
                                                  var body = "ctype=1&posted=1&Submit=&d1=" + all_plate_val[0] + "&d2=" + all_plate_val[1] + "&d3=" + all_plate_val[2] + "&d4=" + all_plate_val[3] + "&b1=" + all_plate2_val[0] + "&b2=" + all_plate2_val[1] + "&b3=" + all_plate2_val[2] + "&radio1=1&radio2=4&radio3=6&radio4=8&radio5=10&radio6=12";
                                                await  http.post(Uri.parse("https://platesmania.com/sa/informer"), body: body, headers: {
                                                    'Host': 'platesmania.com',
                                                    'Content-Length': '115',
                                                    'Cache-Control': 'max-age=0',
                                                    'Sec-Ch-Ua': '"Not:A-Brand";v="99", "Chromium";v="112"',
                                                    'Sec-Ch-Ua-Mobile': '?0',
                                                    'Sec-Ch-Ua-Platform': '"macOS"',
                                                    'Upgrade-Insecure-Requests': '1',
                                                    'Origin': 'https://platesmania.com',
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.5615.138 Safari/537.36',
                                                    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
                                                    'Sec-Fetch-Site': 'same-origin',
                                                    'Sec-Fetch-Mode': 'navigate',
                                                    'Sec-Fetch-User': '?1',
                                                    'Sec-Fetch-Dest': 'document',
                                                    'Referer': 'https://platesmania.com/sa/informer',
                                                    'Accept-Encoding': 'gzip, deflate',
                                                    'Accept-Language': 'en-US,en;q=0.9',
                                                    'Cookie': 'lang=en',
                                                  }).then((value) async {
                                                    // log(value.body);
                                                    // log( value.body.substring(25350,25401));

                                                    var document = parse(value.body);
                                                    var a = document.getElementsByClassName("img-responsive vcenter");
                                                    print(a.first.outerHtml);
                                                    print(a.first.outerHtml.substring(10, 61));
                                                    var b = a.first.outerHtml.substring(10, 61);
                                                 await   http.get(Uri.parse(b)).then((value) => plate_link =value.bodyBytes);
                                                  });
                                                }
                                                FormData formData = FormData.fromMap({"file": MultipartFile.fromBytes(slot!.is_plate! ? plate_link!:(await main_image!.readAsBytes()), filename: Uuid().v4() + ".png")});
                                                await dio
                                                    .post_data(
                                                        url: "/uplode/uplode",
                                                        data: formData,
                                                        onsend: (start, end) {
                                                          presint = start / end;
                                                          settate(() {});
                                                        })
                                                    .then((value) {
                                                  print(value?.data);
                                                  main_photo_url = value?.data['message'];
                                                  presint = 0;
                                                  settate(() {});
                                                });

                                              for (int i = 0; i < list_image.length; i++) {
                                                name_of_porsses = "الصورة " + (i + 1).toString();
                                                settate(() {});
                                                FormData formData = FormData.fromMap({"file": MultipartFile.fromBytes(await list_image[i]!.readAsBytes(), filename: Uuid().v4() + ".png")});
                                                await dio
                                                    .post_data(
                                                        url: "/uplode/uplode",
                                                        data: formData,
                                                        onsend: (start, end) {
                                                          presint = start / end;
                                                          settate(() {});
                                                        })
                                                    .then((value) {
                                                  print(value?.data);
                                                  presint = 0;
                                                  number_of_uploade++;
                                                  settate(() {});
                                                  list_photo_url = list_photo_url + value?.data['message'] + "|";
                                                  if (i + 1 == list_image.length) {
                                                    list_photo_url = list_photo_url + main_photo_url;
                                                  }
                                                });
                                              }
                                              if (file_slot_1 != null) {
                                                name_of_porsses = "ملف " + slot!.file_slot![0];
                                                settate(() {});
                                                FormData formData = FormData.fromMap(
                                                    //    {"file": MultipartFile.fromFileSync(file_slot_1!.files.first.path!, filename: Uuid().v4()+".pdf")});
                                                    //    {"file": f1});
                                                    {"file": MultipartFile.fromBytes(f1, filename: Uuid().v4() + ".png")});
                                                //    {"file":MultipartFile(f1!.openRead(),await f1!.length(),filename: Uuid().v4()+".pdf")});
                                                await dio
                                                    .post_data(
                                                        url: "/uplode/uplode",
                                                        data: formData,
                                                        onsend: (start, end) {
                                                          presint = start / end;
                                                          settate(() {});
                                                        })
                                                    .then((value) {
                                                  print(value?.data);
                                                  file_slot_1_url = value?.data['message'];
                                                  number_of_uploade++;
                                                  presint = 0;
                                                  settate(() {});
                                                });
                                              }
                                              if (file_slot_2 != null) {
                                                name_of_porsses = "ملف " + slot!.file_slot![1];
                                                settate(() {});
                                                FormData formData = FormData.fromMap(
                                                    //    {"file": MultipartFile.fromFileSync(file_slot_2!.files.first.path!, filename: Uuid().v4()+".pdf")});
                                                    {"file": MultipartFile.fromBytes(f2, filename: Uuid().v4() + ".png")});
                                                await dio
                                                    .post_data(
                                                        url: "/uplode/uplode",
                                                        data: formData,
                                                        onsend: (start, end) {
                                                          presint = start / end;
                                                          settate(() {});
                                                        })
                                                    .then((value) {
                                                  print(value?.data);
                                                  file_slot_2_url = value?.data['message'];
                                                  number_of_uploade++;
                                                  presint = 0;
                                                  settate(() {});
                                                });
                                              }
                                              if (file_slot_3 != null) {
                                                name_of_porsses = "ملف " + slot!.file_slot![2];
                                                settate(() {});
                                                FormData formData = FormData.fromMap(
                                                    //     {"file": MultipartFile.fromFileSync(file_slot_3!.files.first.path!, filename:Uuid().v4()+".pdf")});
                                                    {"file": MultipartFile.fromBytes(f3, filename: Uuid().v4() + ".png")});
                                                await dio
                                                    .post_data(
                                                        url: "/uplode/uplode",
                                                        data: formData,
                                                        onsend: (start, end) {
                                                          presint = start / end;
                                                          settate(() {});
                                                        })
                                                    .then((value) {
                                                  print(value?.data);
                                                  number_of_uploade++;
                                                  file_slot_3_url = value?.data['message'];
                                                  presint = 0;
                                                  settate(() {});
                                                });
                                              }
                                              AddBloc.get(context).add_void(cache.get_data("id"), name_add_con.text, des_add_con.text, price_add_con.text, "100", num_day_add_con.text, city, b[a.indexOf(type)], location, text_slot_0_add_con.text, text_slot_1_add_con.text, text_slot_2_add_con.text, kind, name_text_1, name_text_2, name_text_3, main_data, file_slot_1_url, file_slot_2_url,
                                                  file_slot_3_url, main_photo_url, list_photo_url, slot!.file_slot!.length > 0 ? slot!.file_slot![0] : "", slot!.file_slot!.length > 1 ? slot!.file_slot![1] : "", slot!.file_slot!.length > 2 ? slot!.file_slot![2] : "", is_hide);
                                              Navigator.pop(dialogContext);
                                            });
                                          } catch (e) {
                                            Navigator.pop(dialogContext);
                                            start_uplode = false;
                                            setstate(() {});
                                            tost(msg: "فشل الرفع يرجى إعادى المحاولة", color: Colors.red);
                                          }
                                        } else {}
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "جار رفع " + name_of_porsses,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              LinearProgressIndicator(value: presint),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  //Text(name_of_porsses),
                                                  //  Text(number_of_uploade.toString()+"/5"),
                                                  // Text("5/10")
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  );
                                },
                              );
                            } else {
                              tost(msg: "يرجى ملئ جميع البيانات", color: Colors.red);
                            }
                            // if (!slot!.with_location!) {
                            //   location = " ";
                            // }
                            // if (name_add_con.text.isNotEmpty &&
                            //     des_add_con.text.isNotEmpty &&
                            //     price_add_con.text.isNotEmpty &&
                            //     num_day_add_con.text.isNotEmpty &&
                            //     num_day_add_con.text.isNotEmpty &&
                            //     city.isNotEmpty &&
                            //     location != null &&
                            //     is_terms_check &&
                            //     main_data != "") {
                            //   setstate(() {
                            //     is_loading = true;
                            //   });
                            //   AddBloc.get(context).add_void(
                            //       cache.get_data("id"),
                            //       name_add_con.text,
                            //       des_add_con.text,
                            //       price_add_con.text,
                            //       my_price,
                            //       num_day_add_con.text,
                            //       city,
                            //       b[a.indexOf(type)],
                            //       location,
                            //       text_slot_0_add_con.text,
                            //       text_slot_1_add_con.text,
                            //       text_slot_2_add_con.text,
                            //       kind,
                            //       name_text_1,
                            //       name_text_2,
                            //       name_text_3,
                            //       main_data);
                            // } else {
                            //   tost(msg: "يرجى ملئ جميع البيانات", color: Colors.red);
                            // }
                          },
                          child: is_loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text("إضافة"),
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_red)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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

Widget add_rout_home(context, index, text_slot_0_add_con, text_slot_1_add_con, text_slot_2_add_con, slot, setstate) {
  TextEditingController con;
  if (index == 0) {
    con = text_slot_0_add_con;
  } else if (index == 1) {
    con = text_slot_1_add_con;
  } else {
    con = text_slot_2_add_con;
  }
  return WillPopScope(
    onWillPop: () async {
      setstate(() {});
      return true;
    },
    child: AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actionsPadding: EdgeInsets.all(20),
      content: SizedBox(
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
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setstate(() {});
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
