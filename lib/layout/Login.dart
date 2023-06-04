import 'package:auction_app/bloc/account/account_bloc.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/dio.dart';
import 'package:auction_app/layout/Terms_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';


bool is_login = true;
TextEditingController email_con = TextEditingController();
TextEditingController name_con = TextEditingController();
TextEditingController number_con = TextEditingController();
TextEditingController adress_con = TextEditingController();
TextEditingController id_num_con = TextEditingController();
// if (state is error_login_state) {
// tost(msg: "هذا الحساب غير موجود", color: Colors.red);
// setstate(() {
// is_loading = false;
// });\
// }
Widget Login(BuildContext context, state) {
  bool is_loading = false;
  final pinputController = TextEditingController();

  return Scaffold(
    backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade900,
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: StatefulBuilder(builder: (context, setstate) {
        return BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is error_login_state) {
              setstate(() {
                is_loading = false;
              });
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // const Text("اوكشن", style: TextStyle(color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold)),
                  // const Text("السعودية", style: TextStyle(color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold)),
                  Image(image: AssetImage("assets/img/18.png"),height: 150),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                      child: Builder(builder: (acontext) {

                        if (cache.get_data("otp_id") != null) {

                          return SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Center(child: Text("يرجى إدخال الرمز")),
                                SizedBox(height: 10,),
                                Pinput(controller: pinputController,length: 6),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(main_red)),
                                    onPressed: () async {
                                      if(!is_loading){
                                        setstate((){
                                          is_loading = true;
                                        });
                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(verificationId: cache.get_data("otp_id"), smsCode: pinputController.text);
                                      await FirebaseAuth.instance.signInWithCredential(credential).then((valuec) {
                                        if (cache.get_data("is_login")) {
                                          FirebaseMessaging.instance.getToken().then((value) {
                                            print(value);
                                            print(cache.get_data("num"));
                                            context.read<AccountBloc>().add(login_event(cache.get_data("num"), value));
                                             cache.remove_data("otp_id");
                                            // AccountBloc().add(login_event(number_con.text, value));
                                          });
                                        } else {
                                          FirebaseMessaging.instance.getToken().then((value) {
                                            cache.remove_data("otp_id");
                                            context.read<AccountBloc>().add(register_event( value));
                                          });
                                        }
                                      }).onError((error, stackTrace) {
                                        print(error.toString());
                                        print(stackTrace.toString());
                                        tost(msg: "الرمز خاطئ", color: Colors.red);
                                        setstate((){
                                          is_loading = false;
                                          pinputController.clear();
                                        });
                                      });

                                    }
                                  },
                                    child: SizedBox(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width / 1.5,
                                        child: Center(
                                            child: is_loading
                                                ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Center(
                                                  child: CircularProgressIndicator(color: Colors.white),
                                                ))
                                                : const Text(
                                               "تأكيد",
                                              style: TextStyle(fontSize: 20),
                                            ))),),
                                const SizedBox(height: 5,),
                                TextButton(
                                    onPressed: () {
                                      cache.remove_data("otp_id");
                                      is_loading = false;
                                      pinputController.clear();
                                      setstate(() {});
                                    },
                                    child: Text("تغيير الرقم")),
                              ]),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  is_login ? "تسجيل دخول" : "إنشاء حساب",
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
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
                                      controller: number_con,
                                      maxLength: 9,
                                      textDirection: TextDirection.ltr,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                          hintText: "  الرقم",
                                          hintTextDirection: TextDirection.rtl,
                                          border: InputBorder.none,
                                          prefix: Text(" +966"),
                                          counterText: "",
                                          contentPadding: EdgeInsets.zero),
                                    ),
                                  ),
                                ),
                                if (!is_login)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (!is_login)
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
                                        controller: name_con,
                                        textDirection: TextDirection.rtl,
                                        decoration: const InputDecoration(
                                            hintText: "  الاسم", hintTextDirection: TextDirection.rtl, border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                if (!is_login)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (!is_login)
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
                                        keyboardType: TextInputType.emailAddress,
                                        textDirection: TextDirection.rtl,
                                        controller: email_con,
                                        decoration: const InputDecoration(
                                            hintText: "  الايميل", hintTextDirection: TextDirection.rtl, border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                if (!is_login)
                                const SizedBox(
                                  height: 10,
                                ),
                                if (!is_login)
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
                                        textDirection: TextDirection.rtl,
                                        controller: adress_con,
                                        decoration: const InputDecoration(
                                            hintText: "  العنوان (إختياري)", hintTextDirection: TextDirection.rtl, border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                if (!is_login)
                                const SizedBox(
                                  height: 10,
                                ),
                                // if (!is_login)
                                //   Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Container(
                                //       padding: const EdgeInsets.all(4),
                                //       decoration: BoxDecoration(
                                //           border: Border.all(
                                //             color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                //           ),
                                //           borderRadius: BorderRadius.circular(10)),
                                //       child: TextFormField(
                                //         keyboardType: TextInputType.number,
                                //         textDirection: TextDirection.rtl,
                                //         controller: id_num_con,
                                //         decoration: const InputDecoration(
                                //             hintText: "  رقم الهوية (إختياري)", hintTextDirection: TextDirection.rtl, border: InputBorder.none),
                                //       ),
                                //     ),
                                //   ),
                                // if(is_login)
                                //   SizedBox(height: 20,),
                                  if(!is_login)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>Terms_page()));
                                        },
                                        child: Text("سياسة الخصوصية")),
                                   // Text(is_login ? "لا تملك حساب؟ " : "الانتقال الى"),
                                    Text("إنشاء حساب يعني الموافقة على")
                                  ],
                                ),
                                Center(
                                  child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(main_red)),
                                    onPressed: () async {

                                      //main_bloc.get(context).login(email_con.text,pass_con.text);
                                      if (!is_loading  ) {
                                        setstate(() {
                                          is_loading = true;
                                        });
                                      dio.get_data(url: "account/check_login", quary: {"mobile_id": "+966"+number_con.text}).then((value) async {
                                        print(value?.data);
                                        if (value?.data && is_login || !is_login &&!value?.data) {
                                          if(is_login){
                                            cache.save_data("num", "+966"+number_con.text);
                                            cache.save_data("is_login", true);
                                          }
                                          else{
                                            cache.save_data("reg", "${"+966"+number_con.text}|${name_con.text}|${email_con.text}|${adress_con.text!=""?adress_con.text:"......"}|${id_num_con.text!=""?id_num_con.text:"......"}");
                                            cache.save_data("is_login", false);
                                          }
                                          await FirebaseAuth.instance.verifyPhoneNumber(
                                          //  phoneNumber: '+963956956020',
                                            phoneNumber: "+966"+number_con.text,
                                            verificationCompleted: (PhoneAuthCredential credential) async {
                                              print("1");
                                              print(credential);
                                              await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                                                if (cache.get_data("is_login")) {
                                                  FirebaseMessaging.instance.getToken().then((value) {
                                                    context.read<AccountBloc>().add(login_event(cache.get_data("num"), value));
                                                    cache.remove_data("otp_id");
                                                    // AccountBloc().add(login_event(number_con.text, value));
                                                  });
                                                } else {
                                                  FirebaseMessaging.instance.getToken().then((value) {
                                                    cache.remove_data("otp_id");
                                                    context.read<AccountBloc>().add(register_event( value));
                                                  });
                                                }
                                              }).onError((error, stackTrace) {
                                                print(error.toString());
                                                print(stackTrace.toString());
                                                tost(msg: "الرمز خاطئ", color: Colors.red);
                                                setstate((){
                                                  is_loading = false;
                                                  pinputController.clear();
                                                });
                                              });
                                            },
                                            verificationFailed: (FirebaseAuthException e) {
                                              setstate((){
                                                is_loading = false;
                                              });
                                              print(e.message);
                                              tost(msg: e.message, color: Colors.red);
                                            },
                                            codeSent: (String verificationId, int? resendToken) {
                                              cache.save_data("otp_id", verificationId);
                                              setstate((){
                                                is_loading = false;
                                              });
                                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                                              // context.read<main_bloc>().change_nav_index(3);
                                              // con.jumpToPage(3);

                                              print("3");
                                              print(verificationId);
                                              print(resendToken);
                                            },
                                            codeAutoRetrievalTimeout: (String verificationId) {
                                              print("4");
                                              print(verificationId);
                                              cache.save_data("otp_id", verificationId);
                                              tost(msg: "تمت إعادة إرسال رمز التفعيل",color: Colors.grey);
                                            },
                                          );
                                        } else {
                                          if(is_login){
                                            tost(msg: "الرقم غير موجود", color: Colors.red);
                                          }
                                          else{
                                            tost(msg: "الرقم مستخدم", color: Colors.red);
                                          }
                                          setstate(() {
                                            is_loading = false;
                                          });
                                        }
                                      });

                                      }
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width / 1.5,
                                        child: Center(
                                            child: is_loading
                                                ? const SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: Center(
                                                      child: CircularProgressIndicator(color: Colors.white),
                                                    ))
                                                : Text(
                                                    is_login ? "تسجيل دخول" : "إنشاء حساب",
                                                    style: const TextStyle(fontSize: 20),
                                                  ))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          setstate(() {
                                            is_login = !is_login;
                                          });
                                        },
                                        child: Text(!is_login ? "تسجيل الدخول" : "إنشاء حساب")),
                                    Text(is_login ? "لا تملك حساب؟ " : "الانتقال الى"),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                  if(!is_login)
                    SizedBox(height: 80,)
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}
