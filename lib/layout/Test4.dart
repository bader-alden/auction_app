import 'package:flutter/material.dart';
import 'package:auction_app/cache.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
class Test4 extends StatefulWidget {
  const Test4({Key? key}) : super(key: key);

  @override
  State<Test4> createState() => _Test4State();
}

class _Test4State extends State<Test4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        if(cache.get_data("uid")=="a")
          const Text("انت تستخدم الحساب 1"),
        if(cache.get_data("uid")=="b")
          const Text("انت تستخدم الحساب 2"),
        if(cache.get_data("uid")=="c")
          const Text("انت تستخدم الحساب 3"),
        if(cache.get_data("uid")== null)
          const Text("انت لم تسجل دخول بعد"),
        const SizedBox(height: 50,),
        ElevatedButton(onPressed: (){
          cache.save_data("uid", "a");
          Phoenix.rebirth(context);
        }, child: const Text("تسجيل دخول الحساب 1")),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          cache.save_data("uid", "b");
          Phoenix.rebirth(context);
        }, child: const Text("تسجيل دخول الحساب 2")),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          cache.save_data("uid", "c");
          Phoenix.rebirth(context);
        }, child: const Text("تسجيل دخول الحساب 3")),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          cache.remove_data("uid");
          Phoenix.rebirth(context);
        }, child: const Text("تسجل الخروج")),
      ],
    );
  }
}
