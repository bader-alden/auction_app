import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locale/locale_bloc.dart';
import '../bloc/stram/stream_bloc.dart';
import '../bloc/theme/theme_bloc.dart';
import '../const.dart';
import '../models/list_auction_model.dart';




class confirm_pay extends StatelessWidget {
  const confirm_pay({Key? key, this.model, this.type}) : super(key: key);
final list_auction_model? model;
final type;
  @override
  Widget build(BuildContext context) {
    int my_price =int.parse(model!.num_price!);
    bool is_check =false;
    bool is_click =false;
    return  BlocProvider(
  create: (context) => ThemeBloc(),
  child: Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).brightness ==Brightness.light?Colors.grey.shade300:Colors.grey.shade900,elevation: 0,title: Text("placement",style: TextStyle(color: Theme.of(context).brightness ==Brightness.light?Colors.grey.shade700:Colors.grey.shade400),),centerTitle: true,),
      backgroundColor: Theme.of(context).brightness ==Brightness.light?Colors.grey.shade300:Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 450 ,
                        width: 400* MediaQuery.of(context).size.width/350,
                        decoration: BoxDecoration(color: Theme.of(context).brightness ==Brightness.light?Colors.white:Colors.black,borderRadius: BorderRadius.circular(30)),
                      ),
                      Container(
                        height: 450 ,
                        width: 410* MediaQuery.of(context).size.width/350,
                        child: Column(children: [
                          Expanded(child: Column(
                            children: const [
                             Spacer(flex: 5,),
                              Center(child: Text(" مزايدة",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),)),
                              Spacer(),
                            ],
                          )),
                         // SizedBox(height: 100,),
                          Expanded(
                            child: Row(
                              children: [
                                Container(height: 35,width: 25,decoration: BoxDecoration(color:Theme.of(context).brightness ==Brightness.light?Colors.grey.shade300:Colors.grey.shade900,borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),),
                               Expanded(child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text("-"*2400,style: const TextStyle(color: Colors.grey,fontSize: 40),maxLines: 1,),
                               )),
                                Container(height: 35,width: 25,decoration: BoxDecoration(color:Theme.of(context).brightness ==Brightness.light?Colors.grey.shade300:Colors.grey.shade900,borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: StatefulBuilder(
                                        builder: (context,setstate) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if(my_price - 500 >= int.parse( model!.num_price!)){
                                                    setstate((){
                                                      my_price = my_price - 500;
                                                    });

                                                      }
                                                    },
                                                  child: const Text("-",style: TextStyle(fontSize: 50,color: Colors.red),)),
                                          AnimatedFlipCounter(duration: const Duration(milliseconds: 500),

                                                value: my_price
                                          ,textStyle: TextStyle(fontSize: 40,color: Theme.of(context).brightness ==Brightness.light?Colors.black:Colors.white,fontWeight: FontWeight.w600),),

                                              InkWell(
                                                  onTap: (){
                                                    setstate((){
                                                      my_price = my_price + 500;
                                                    });
                                                  },
                                                  child: const Text("+",style: TextStyle(fontSize: 50,color: Colors.red),)),
                                            ],
                                          );
                                        }
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Text(model!.name!,style: const TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w600),),
                                    const SizedBox(height:20,),
                                    Expanded(
                                      child: StatefulBuilder(
                                        builder: (context,setcheckstatea) {
                                          return InkWell(
                                            borderRadius: BorderRadius.circular(100),
                                            onTap: (){
                                              setcheckstatea((){
                                                is_check =!is_check;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("أوافق على سياسة الخصوصية",style: TextStyle(fontSize: 15,color:Theme.of(context).brightness ==Brightness.light?Colors.black:Colors.white,fontWeight: FontWeight.w600),),
                                                const SizedBox(width: 5,),
                                                if(is_check)
                                                  const Icon(Icons.check),
                                              ],
                                            ),
                                          );
                                        }
                                      ),
                                    ),

                                    StatefulBuilder(
                                      builder: (context,setclickstate) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: TextButton(
                                            onPressed: (){
                                              if(!is_click && is_check){
                                                setclickstate((){
                                                  is_click = true;
                                                });
                                                StreamBloc().update(model!, type,my_price.toString());
                                                Future.delayed(const Duration(seconds: 2)).then((value) {
                                                  Navigator.pop(context);
                                                });
                                              }
                                              if(!is_check){
                                                tost(msg: "يجيب الموافقة على الشروط",color: Colors.red);
                                              }
                                            },
                                            child: Container(
                                              width: 350,
                                              height: 40,
                                              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(50)),
                                            child: Center(child: is_click
                                            ?Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(height: 20,width: 20,child: const CircularProgressIndicator(color: Colors.white, )),
                                            )
                                            :const Text("! دفع",style: TextStyle(color: Colors.white,fontSize: 30),)),
                                            ),
                                          ),
                                        );
                                      }
                                    )
                                  ],
                                )
                              )),
                      //    SizedBox(height: 50,),
                        ],),
                      ),
                    ],
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Container(height: 480,color: Colors.transparent,width: 200,child: Column(
                      children: [
                        CircleAvatar(backgroundColor: Theme.of(context).brightness ==Brightness.light?Colors.white:Colors.black,radius: 30,
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.check,color: Colors.white,),
                          ),
                        )
                      ],
                    ),),
                  )
                ],
              ),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.read<LocaleBloc>().time_lift),
              Timer_widget(model?.time, context,Theme.of(context).brightness == Brightness.light ? Colors.black:Colors.white),
            ],
          )
        ],
      ),
    ),
);
  }

}
