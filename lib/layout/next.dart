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
              Navigator.pop(context);
            }, child: const Text("إضافة"))
          ],
        ),
      ),
    );
  }
}
