import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/dio.dart';
import 'package:auction_app/models/serach_tag_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import '../bloc/locale/locale_bloc.dart';
import 'package:xml/xml.dart' as xml;

List main_data_list = [];
List<serach_tag_model> serach_tag_list = [];
List<TextEditingController> con_list = [];
TextEditingController con_make = TextEditingController();
TextEditingController con_model = TextEditingController();
List<String> make_list = [];
List<String> model_list = [];
bool model_loading=false;
String? Model;
String? Make;
Map<int, String> row_map = {};

class add_auction_main_data extends StatefulWidget {
  const add_auction_main_data({Key? key, this.row, this.old, this.is_car}) : super(key: key);
  final row;
  final old;
  final is_car;
  @override
  _add_auction_main_dataState createState() => _add_auction_main_dataState(row, old);
}

class _add_auction_main_dataState extends State<add_auction_main_data> {
  final row;
  final old;

  _add_auction_main_dataState(this.row, this.old);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text("في حال عدم وجود المنتج \n يرجى التواصل مع الدعم الفني",textDirection:TextDirection.rtl ,),
        actions: [
          Center(child: TextButton(onPressed: ()=>Navigator.of(context).pop(),child: Text("موافق"),),)
        ],
      ));

      main_data_list.clear();
      serach_tag_list.clear();
      make_list.clear();
   //   model_list.clear();
     // con_list.clear();
      main_data_list = row.toString().split("^");
      try {
        main_data_list.forEach((element) async {
          await dio.get_data(url: "/account/serach_tag", quary: {"id": element}).then((value) async {
          //  print(value?.data[0]);
            con_list.add(TextEditingController());
            try {
              serach_tag_list.add(serach_tag_model.fromjson(value?.data[0]));
            } catch (e) {
              print(e);
              serach_tag_list.add(serach_tag_model.fromjson(value?.data));
            } finally {
              if (serach_tag_list.length == main_data_list.length) {
                for (int i = 0; i < main_data_list.length; i++) {
               //   print(con_list);
                  if(old != "" ){
                    row_map[i] = old.toString().split("^")[i].toString().split("**")[1];
                    con_list[i].text = old.toString().split("^")[i].toString().split("**")[1];
                  }else{
                    row_map[i]=" ";
                  }
              }
                setState(() {
                //  print(serach_tag_list);
                });
              }
              if(widget.is_car&&value?.data[0]['name']=="الاسم"){
                 await http.get(Uri.parse("https://services.mobile.de/refdata/sites/GERMANY/classes/${serach_tag_list[0].tag[0]}/makes")).then((value) {
                    print(value.body);
                    final document = xml.XmlDocument.parse(value.body);
                    //print(document.children);
                    print(document.children.length);
                    document.findElements("reference:reference").forEach((element) {
                      make_list.addAll(element.children.map((p0) => p0.text.toString()));
                    });
                    print(make_list);
                    setState(() {

                    });
                    // final studentsNode = document.findElements('reference').first;
                    // print(studentsNode);
                  });
              }
            }
          });
        });

      } catch (e) {
        print(e);
      } finally {
        setState(() {
      //    print(serach_tag_list);
        });
      }

    });


      // row_map[i] =
      //     ? old.toString().split("^")[i].toString().split("**")[1]
      //     : " ";

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            SizedBox(width: 20,),
            TextButton(onPressed: (){
              showCupertinoDialog(context: context, builder: (context)=>Center(child: Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(10)),width: 75,height: 75,child: Center(child: CircularProgressIndicator(color: main_red,),),),));
              dio.get_data(url: "/terms_and_conditions").then((value) {
                Navigator.pop(context);
                print(value?.data[0]["the_support"]);
                launchUrl(Uri.parse(value?.data[0]["the_support"]),mode:LaunchMode.externalApplication );
              });
            }, child: Text("التواصل مع الدعم الفني"))
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: context.read<LocaleBloc>().lang ? Icon(Icons.arrow_forward_ios, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black) : Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
          title: Text("المعلومات الأساسية"),
        ),
        body: serach_tag_list.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  if(widget.is_car)
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: make_list.isEmpty
                    ?CircularProgressIndicator()
                    :CustomDropdown.search(
                        fillColor: Theme.of(context).brightness == Brightness.dark
                            ? Make==null
                            ? Colors.grey.shade900
                            : Colors.green.shade300
                            : Make==null
                            ? Colors.grey.shade300
                            : Colors.green.shade300,
                        items:make_list,
                        hintText: "    الماركة التجارية",
                        hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                        errorText: "غير موجود",
                        onChanged: (value) {
                          setState(() {
                            Make=value;
                           // row_map[index] = value;
                            print(row_map);
                            model_loading=true;
                          });
                          model_list.clear();
                          Model=null;
                          http.get(Uri.parse("https://services.mobile.de/refdata/sites/GERMANY/classes/${serach_tag_list[0].tag[0]}/makes/$Make/models")).then((value) {
                            print(value.body);
                            if(value.body != ""){
                              final document = xml.XmlDocument.parse(value.body);
                              //print(document.children);
                              print(document.children.length);
                              document.findElements("reference:reference").forEach((element) {
                                model_list.addAll(element.children.map((p0) => p0.text.toString()));
                              });
                              print(model_list);
                              setState(() {
                                // row_map[index] = value;
                                // print(row_map);
                                model_loading=false;
                              });
                              // final studentsNode = document.findElements('reference').first;
                              // print(studentsNode);
                            }else{
                              Model=" ";
                              setState(() {
                                model_loading=false;
                              });
                            }

                          });
                        },
                        listItemBuilder: (context, text) {
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                            ),
                          );
                        },
                       controller: con_make
                    ),
                  ),
                  if(widget.is_car&&model_list.isNotEmpty ||model_loading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: model_loading
                      ?CircularProgressIndicator()
                      :CustomDropdown.search(
                          fillColor: Theme.of(context).brightness == Brightness.dark
                              ? Model==null
                              ? Colors.grey.shade900
                              : Colors.green.shade300
                              : Model==null
                              ? Colors.grey.shade300
                              : Colors.green.shade300,
                          items:model_list.isNotEmpty ?model_list:["a","b"],
                          hintText: "   الفئة",
                          hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                          errorText: "غير موجود",
                          onChanged: (value) {

                            setState(() {
                              Model=value;
                              // row_map[index] = value;
                            });
                            // model_loading=true;
                          },
                          listItemBuilder: (context, text) {
                            return Center(
                              child: Text(
                                text,
                                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                              ),
                            );
                          },
                          controller: con_model
                      ),
                    ),
                  Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: main_data_list.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 5,
                              color: Colors.white,
                            );
                          },
                          itemBuilder: (context, index) {
                            if(widget.is_car&&index ==0){
                              return SizedBox();
                            }
                            serach_tag_model model = serach_tag_list.firstWhere((element) => element.id.toString() == main_data_list[index]);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomDropdown.search(
                                  fillColor: Theme.of(context).brightness == Brightness.dark
                                      ? row_map[index] == " "
                                          ? Colors.grey.shade900
                                          : Colors.green.shade300
                                      : row_map[index] == " "
                                          ? Colors.grey.shade300
                                          : Colors.green.shade300,
                                  items: model.tag as List<String>,
                                  hintText: "  "+(model.name??""),
                                  hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                  errorText: "غير موجود",
                                  onChanged: (value) {
                                    setState(() {
                                      row_map[index] = value;
                                      print(row_map);
                                    });
                                  },
                                  listItemBuilder: (context, text) {
                                    return Center(
                                      child: Text(
                                        text,
                                        style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                      ),
                                    );
                                  },
                                  controller: con_list[index]),
                            );
                            // return Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(
                            //     children: [
                            //       Text(main_data_list[index]),
                            //       Spacer(),
                            //       if(row_map[index]!=" ")
                            //       Text(row_map[index]!),
                            //       IconButton(onPressed: (){
                            //         var con = TextEditingController(text:row_map[index]==" "?null:row_map[index] );
                            //         showDialog<void>(
                            //                       context: context,
                            //                       builder: (BuildContext dialogContext) {
                            //                         return AlertDialog(
                            //                           title: Text(main_data_list[index]),
                            //                           content:  TextFormField(controller: con,),
                            //                           actions: <Widget>[
                            //                             TextButton(
                            //                               child:Text("موافق"),
                            //                               onPressed: () {
                            //                                 print(row_map);
                            //                                 setState(() {
                            //                                   row_map[index]=con.text;
                            //                                   print(row_map);
                            //                                 });
                            //                                 Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                            //                               },
                            //                             ),
                            //                           ],
                            //                         );
                            //                       },
                            //                     );
                            //                   }, icon: Icon(Icons.edit))
                            //     ],
                            //   ),
                            // );
                          })),
                  if (check_is_ok())
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_red)),
                        onPressed: () async {
                          bool is_ok = true;
                          row_map.forEach((key, value) {
                            if (value == " " || value == "") {
                              is_ok = false;
                            }
                          });
                          if (is_ok) {
                            String s = "";
                            for (int i = 0; i < main_data_list.length; i++) {
                              s = s + (serach_tag_list.where((e) => e.id==main_data_list[i]).first.name??"" )+ "**" + row_map[i]!;
                              if (i + 1 != main_data_list.length) {
                                s = s + "^";
                              }
                            }
                            if (s != "") {
                              Navigator.pop(context, s);
                            }
                            print(s);

                          } else {
                            tost(msg: "يجب تعبئة جميع الفراغات", color: Colors.red);
                          }
                          // Navigator.of(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(width: double.infinity, child: Center(child: Text("حفظ"))),
                        )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }

  bool check_is_ok() {
    var _ = true;
    if(widget.is_car&&Model!=null &&Make!=null){
      row_map[0]=Make! +" "+Model!;
    }
    print("======");
    print(row_map[0]);
    print("======");
    row_map.forEach((key, value) {
      if (value == " " || value == "") {
        _ = false;
      }
    });
    return _;
  }
}
