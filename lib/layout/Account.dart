import 'package:auction_app/bloc/account/account_bloc.dart';
import 'package:auction_app/layout/FAQ_page.dart';
import 'package:auction_app/layout/Login.dart';
import 'package:auction_app/layout/Setting.dart';
import 'package:auction_app/layout/Terms_page.dart';
import 'package:auction_app/layout/add_money.dart';
import 'package:auction_app/layout/my_auction.dart';
import 'package:auction_app/layout/social_page.dart';
import 'package:auction_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/locale/locale_bloc.dart';
import '../bloc/theme/theme.dart';
import '../const.dart';
import 'Update_account.dart';
import 'package:auction_app/dio.dart';
bool? is_login_bool;
PageController? account_con;



class main_acount extends StatelessWidget {
  const main_acount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>AccountBloc()..add(Accountlodaded()),
        child: BlocConsumer<AccountBloc,AccountState>(
          listener: (context,state){
            if(state is is_login_state){
              is_login_bool = true;
            }
            if (state is error_login_state) {
              tost(msg: "هذا الحساب غير موجود", color: Colors.red);
              //AccountBloc().emit(is_not_login_state());
              context.read<AccountBloc>().add(Accountlodaded());
            }
          },
          builder: (context,state)  {
            // print("email is ${cache.get_data("email")}");
            // print("user_data ${main_bloc.get(context).user}");
            if(state is AccountInitial){
              return  const CircularProgressIndicator();
            }
            if(state is app_check){
              return  Center(child: Image(
                image: Theme.of(context).brightness==Brightness.dark
                    ?AssetImage("assets/img/dark_loading.gif")
                    :AssetImage("assets/img/loading.gif")
                ,height: 125,width: 125,));
            }
            if(state is is_not_login_state){
              return Login(context, state);
            }
            if(state is is_login_state ) {
              return Account(context,state.user);
            } else {
              return const Text("something went wrong");
            }
          },
        )
    );
  }

}



  Widget Account(BuildContext context ,user_models user) {
    return Scaffold(
      appBar: AppBar(title: Text(context.read<LocaleBloc>().profile, style: TextStyle(color: Colors.grey.shade600)), elevation: 0, centerTitle: true),
      body: Directionality(
        textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr:TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
           // physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.account_circle, size: 80, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.read<LocaleBloc>().welcom,
                          style: const TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          user.name!,
                          style: const TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_account(user:user)));
                        },
                        iconSize: 35,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                    // IconButton(onPressed: (){},iconSize: 30, icon: Image(image: AssetImage("assets/img/16.png"),height: 40,color: Colors.white,)),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),



            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Theme.of(context).brightness ==Brightness.light?Colors.grey.shade200:Colors.grey.shade900,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMoney()));
                        }, child: account_list_item("محفظتي", const Icon(Icons.wallet,color: Colors.white,)),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>My_action()));
                        },
                        child: account_list_item(context.read<LocaleBloc>().my_auction,
                          const Image(
                            image: AssetImage("assets/img/1.png"),
                            height: 25,
                            color: Colors.white,
                          ),),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(onTap: (){
                        showCupertinoDialog(context: context, builder: (context)=>Center(child: Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(10)),width: 75,height: 75,child: Center(child: CircularProgressIndicator(color: main_red,),),),));
                        dio.get_data(url: "/terms_and_conditions").then((value) {
                          Navigator.pop(context);
                          print(value?.data[0]["the_support"]);
                            launchUrl(Uri.parse(value?.data[0]["the_support"]),mode:LaunchMode.externalApplication );
                        });
                      },
                        child:  account_list_item(
                            context.read<LocaleBloc>().support,
                            const Icon(
                            Icons.support_agent,
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms_page(with_init: true,)));
                        },
                        child: account_list_item(context.read<LocaleBloc>().terms, const Icon(Icons.list_alt_sharp,color: Colors.white,)),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ_page()));
                    }, child: account_list_item(context.read<LocaleBloc>().faq, const Icon(Icons.question_answer_outlined,color: Colors.white,)),
                    ),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Social_page()));
                        },
                          child: account_list_item(context.read<LocaleBloc>().social,
                          const Image(
                            image: AssetImage("assets/img/21.png"),
                            height: 25,
                            color: Colors.white,
                          )
                      ),
),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      // context.read<AccountBloc>()..add(logout_event());
                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Setting()));
                      },
                      child:  account_list_item(
                          context.read<LocaleBloc>().setting,
                         const Icon(Icons.settings,color: Colors.white,),
                        )),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(onTap: (){
                       showDialog(context: context, builder: (context)=>AlertDialog(
                         title: Text("يرجى التحدث مع الدعم الفني لألغاء الحساب و التأكد من عدم وجود مستحقات أو رد أموال",textDirection: TextDirection.rtl,),
                       actions: [
                         TextButton(onPressed: (){
                           showCupertinoDialog(context: context, builder: (context)=>Center(child: Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(10)),width: 75,height: 75,child: Center(child: CircularProgressIndicator(color: main_red,),),),));
                           dio.get_data(url: "/terms_and_conditions").then((value) {
                             Navigator.pop(context);
                             Navigator.pop(context);
                             launchUrl(Uri.parse(value?.data[0]["the_support"]),mode:LaunchMode.externalNonBrowserApplication );
                           });
                         },  child: Text("موافق")),
                         TextButton(onPressed: (){
                           Navigator.pop(context);
                         },  child: Text("إلغاء")),
                       ],));
                      },
                        child:  account_list_item(
                            "حذف الحساب",
                            const Icon(Icons.delete,color: Colors.white,)),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      InkWell(onTap: (){
                        context.read<AccountBloc>().add(logout_event());
                      },
                        child:  account_list_item(
                            context.read<LocaleBloc>().log_out,
                            const Image(
                              image: AssetImage("assets/img/15.png"),
                              height: 20,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey.shade200,
              //     child: ListView.separated(
              //         shrinkWrap: true,
              //         itemBuilder: (context,index){
              //       return Container(
              //         padding: EdgeInsets.all(15),
              //         child: Row(
              //           children: [
              //             CircleAvatar(radius: 25,child: Icon(Icons.add,color: Colors.white),backgroundColor: Colors.red) ,
              //             SizedBox(width: 20,),
              //             Text("aaaaaaa",style: TextStyle(fontSize: 20),),
              //           ],
              //         ),
              //       );
              //     }, separatorBuilder: (context,index){
              //       return Container(height: 2,color: Colors.grey.shade400,);
              //     }, itemCount: 5),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  account_list_item(text, icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(radius: 25, child: icon, backgroundColor: Colors.red),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }



//
//   Widget Account_mangment(BuildContext context,is_login_state state) {
//     return  Column(
//       children: [
//         Container(
//           child: Center(child: Text("you are loging in")),
//         ),
//         ElevatedButton(onPressed: (){
//           context.read<AccountBloc>()..add(logout_event());
//         }, child: Text("logout")),
//         Text("name: ${state.user.name!}"),
//         Text("email: ${state.user.email!}"),
//         Text("password: ${state.user.pass!}"),
//         Text("number: ${state.user.mobile_id}"),
//         Text("national id: ${state.user.national_id}"),
//       ],
//     );
//   }
