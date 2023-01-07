import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/dio.dart';
import 'package:auction_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locale/locale_bloc.dart';
bool update_init = true;
var email_update_con = TextEditingController();
var number_id_update_con = TextEditingController();
var address_update_con = TextEditingController();

class Update_account extends StatelessWidget {
  const Update_account({Key? key, required this.user}) : super(key: key);
  final user_models user;
  @override
  Widget build(BuildContext context) {
    bool is_update_loading = false;
    if(update_init){
      update_init=false;
      email_update_con.text = user.email ?? "";
      number_id_update_con.text = user.id_number ?? "";
      address_update_con.text = user.address ?? "";
    }

    return Directionality(
      textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(leading: IconButton( onPressed: (){
          Navigator.pop(context);
        },icon: context
            .read<LocaleBloc>()
            .lang
            ? Icon(Icons.arrow_forward_ios, color: Theme
            .of(context)
            .brightness == Brightness.dark ? Colors.white : Colors.black)
            : Icon(Icons.arrow_back_ios, color: Theme
            .of(context)
            .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text("تعديل الملف الشخصي"), elevation: 0),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "العنوان:",
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: address_update_con,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "رقم الهوية:",
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: number_id_update_con,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "الايميل:",
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: email_update_con,
                      textDirection: TextDirection.rtl,

                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                StatefulBuilder(
                  builder: (context,setstate) {
                    return ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(main_red)),
                        onPressed: () {
                          if(email_update_con.text.isNotEmpty &&address_update_con.text.isNotEmpty&&number_id_update_con.text.isNotEmpty) {
                           if (!is_update_loading) {
                             setstate((){
                               is_update_loading=true;
                             });
                             dio.post_data(
                            url: "/account/update_account",
                            quary: {
                              "id":user.id,
                              "email":email_update_con.text,
                              "address":address_update_con.text,
                              "id_number":number_id_update_con.text,
                            },
                          ).then((value) {
                            print(value);
                            if (value?.data) {
                              tost(msg: "تم تعديل البيانات بنجاح",color: Colors.green);
                              Navigator.pop(context);
                            }
                            });
                           }else{
                             setstate((){
                               is_update_loading=false;
                             });
                             tost(msg: "حدث خطأ",color: Colors.red);
                           }
                          }else{
                            tost(msg: "يجب ملئ جميع الفراغات",color: Colors.red);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          child: Center(
                              child:is_update_loading
                          ?SizedBox(width: 25,height: 25,child: CircularProgressIndicator(color: Colors.white,))
                          :Text("تعديل")),
                        ));
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
