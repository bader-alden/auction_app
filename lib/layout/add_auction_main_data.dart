import 'package:auction_app/const.dart';
import 'package:flutter/material.dart';
List main_data_list=[];
Map<int,String>row_map={};
class add_auction_main_data extends StatefulWidget {
  const add_auction_main_data({Key? key, this.row, this.old}) : super(key: key);
final row;
final old;
  @override
  _add_auction_main_dataState createState() => _add_auction_main_dataState(row,old);
}

class _add_auction_main_dataState extends State<add_auction_main_data> {
  final row;
  final old;

  _add_auction_main_dataState(this.row, this.old);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    main_data_list.clear();
    main_data_list = row.toString().split("^");

    for(int i=0;i<main_data_list.length;i++){
      row_map[i]=old!=""?old.toString().split("^")[i].toString().split("**")[1]:" ";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("المعلومات الأساسية"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(child: ListView.separated(
              physics: BouncingScrollPhysics(),
                itemCount: main_data_list.length,
                separatorBuilder: (context,index){
                  return Container(height: 2,color: Colors.grey,);
                },
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(main_data_list[index]),
                    Spacer(),
                    if(row_map[index]!=" ")
                    Text(row_map[index]!),
                    IconButton(onPressed: (){
                      var con = TextEditingController(text:row_map[index]==" "?null:row_map[index] );
                      showDialog<void>(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: Text(main_data_list[index]),
                                        content:  TextFormField(controller: con,),
                                        actions: <Widget>[
                                          TextButton(
                                            child:Text("موافق"),
                                            onPressed: () {
                                              print(row_map);
                                              setState(() {
                                                row_map[index]=con.text;
                                                print(row_map);
                                              });
                                              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }, icon: Icon(Icons.edit))
                  ],
                ),
              );
            })),
            ElevatedButton(onPressed: () async {
              bool is_ok  =true;
              row_map.forEach((key, value) {
                if(value==" "||value==""){
                  is_ok=false;
                }
              });
              if(is_ok){
                String s="";
                for(int i=0;i<main_data_list.length;i++){
                  s=s+main_data_list[i]+"**"+row_map[i]!;
                  if(i+1 !=main_data_list.length){
                    s=s+"^";
                  }
                }
                if(s!=""){
                  Navigator.pop(context,s);
                }
                print(s);
              }else{
                tost(msg: "يجب تعبئة جميع الفراغات",color: Colors.red);
              }
             // Navigator.of(context);
            }, child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(width: double.infinity,child: Center(child: Text("حفظ"))),
            ))
          ],
        ),
      ),
    );
  }
}
