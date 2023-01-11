import 'package:auction_app/main.dart';
import 'package:flutter/material.dart';

class Next extends StatelessWidget {
  const Next({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            const Text("صفحة الدفع "),
            const Text("سيتم مراجة الطلب و تأكديه"),
            ElevatedButton(onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false);
            }, child: const Text("موافق"))
          ],
        ),
      ),
    );
  }
}
