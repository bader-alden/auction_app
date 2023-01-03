import 'package:auction_app/bloc/account/account_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


bool is_login = true;



  Widget Login(BuildContext context,state) {
    TextEditingController email_con = TextEditingController();
    TextEditingController name_con = TextEditingController();
    TextEditingController number_con = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ?Colors.grey.shade200:Colors.grey.shade900,
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StatefulBuilder(
          builder: (context,setstate) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                   const Text("اوكشن",style: TextStyle(color: Colors.red,fontSize: 50,fontWeight: FontWeight.bold)),
                   const Text("السعودية",style: TextStyle(color: Colors.red,fontSize: 50,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Theme.of(context).brightness == Brightness.light ?Colors.white:Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 10,),
                              Text(is_login ? "تسجيل دخول": "إنشاء حساب",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    controller: number_con,
                                    textDirection: TextDirection.rtl,
                                    decoration:
                                    const InputDecoration(hintText: "  الرقم",hintTextDirection: TextDirection.rtl,border: InputBorder.none),
                                  ),
                                ),
                              ),
                              if(!is_login)
                              const SizedBox(height: 10,),
                              if(!is_login)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    controller: name_con,
                                    textDirection: TextDirection.rtl,
                                    decoration:
                                    const InputDecoration(hintText: "  الاسم",hintTextDirection: TextDirection.rtl,border: InputBorder.none),
                                  ),
                                ),
                              ),
                              if(!is_login)
                              const SizedBox(height: 10,),
                              if(!is_login)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).brightness == Brightness.dark ?Colors.white:Colors.black,),borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    textDirection: TextDirection.rtl,
                                    controller: email_con,
                                    decoration:
                                    const InputDecoration(hintText: "  الايميل",hintTextDirection: TextDirection.rtl,border: InputBorder.none),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Center(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                                  onPressed: (){
                                    //main_bloc.get(context).login(email_con.text,pass_con.text);
                                    if(is_login){
                                      FirebaseMessaging.instance.getToken().then((value) {
                                        context.read<AccountBloc>().add(login_event(number_con.text,value));
                                      });
                                    }else{
                                      FirebaseMessaging.instance.getToken().then((value) {
                                        context.read<AccountBloc>().add(register_event(name_con.text,email_con.text,number_con.text,value));
                                      });

                                    }
                                  },
                                  child: Container(height: 40,width: MediaQuery.of(context).size.width/1.5,child: Center(child: Text(is_login ? "تسجيل دخول":"إنشاء حساب",style: const TextStyle(fontSize: 20),))),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(onPressed: () {
                                        setstate((){
                                          is_login = !is_login;
                                        });
                                  }, child: Text(!is_login ? "تسجيل الدخول":"إنشاء حساب")),
                                  Text(is_login ?"لا تملك حساب؟ ":"الانتقال الى"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

