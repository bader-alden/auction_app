import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/dio.dart';
import 'package:flutter/material.dart';
bool is_repo_loading=false;
var number_con=TextEditingController();
var title_con=TextEditingController();
var body_con=TextEditingController();
class Repo extends StatefulWidget {
  const Repo({Key? key}) : super(key: key);
  @override
  _RepoState createState() => _RepoState();
}

class _RepoState extends State<Repo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("إرسال شكوى"),
        centerTitle: true,
        leading: back_boutton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
         // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("رقم التواصل:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                textDirection: TextDirection.ltr,
                maxLength: 9,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl,prefix: Text(("+966"))),
                controller: number_con,
              ),
            ),
            Text("عنوان المشكلة:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
                controller: title_con,
              ),
            ),
            SizedBox(height: 15),
            Text("نص المشكلة:",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 20),),
            Container(
              height: 150,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ?Colors.grey.shade900:Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration( border: InputBorder.none,hintTextDirection: TextDirection.rtl),
               controller: body_con,
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_red)),
                  onPressed: (){
                setState(() {
                  is_repo_loading=true;
                });
                  dio.post_data(url: "/complaint",quary: {
                    "title":title_con.text,
                    "number":number_con.text,
                    "text":body_con.text,
                  }).then((value) {
                    if(value?.data=="ok"){
                      setState(() {
                        is_repo_loading=false;
                      });
                      showDialog(context: context, builder: (context)=>AlertDialog(title: Text("شكرا لك\n سيتم مراجعة الشكوى بأقرب فرصة"),actions: [ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("موافق"))],));
                    }
                  });
              }, child:is_repo_loading? Container(height: 50,width: MediaQuery.of(context).size.width/2,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator(color: Colors.white,)),
              )) : Container(height: 50,width: MediaQuery.of(context).size.width/2,child: Padding(
    padding: const EdgeInsets.all(8.0),
    child:Center(child: Text("إرسال"))))),
            )
          ],
        ),
      ),
    );
  }
}
