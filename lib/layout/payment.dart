import 'package:auction_app/cache.dart';
import 'package:flutter/material.dart';
import 'package:auction_app/dio.dart';
import 'package:webviewx/webviewx.dart';
import '../main.dart';
import '../models/add_model.dart';
late WebViewXController webviewController;

class Payment extends StatefulWidget {
  const Payment({Key? key, required this.model}) : super(key: key);
final add_model model;
  @override
  _PaymentState createState() => _PaymentState(model);
}

class _PaymentState extends State<Payment> {
  final add_model model;

  _PaymentState(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: dio.post_data(url: "/pay",quary: {
                "user_id":cache.get_data("id"),
                "id":model.id,
                "type":model.type,
                }),
        builder: (context,snapshot){
          print(snapshot.data);
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return WebViewX(width: double.infinity, height: MediaQuery.of(context).size.height, onWebViewCreated: (controller){
              webviewController = controller;
              webviewController.loadContent(
                snapshot.data.toString(),
                SourceType.url,
              );},);
          }
        },
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("الدفع"),
      //       ElevatedButton(onPressed: (){
      //         // dio.post_data(url: "/approval/pay",quary: {
      //         //   "user_id":cache.get_data("id"),
      //         //   "auction_id":model.id,
      //         //   "auction_type":model.type,
      //         //   "id_of_transforms":"000",
      //         //   "amount":"2500",
      //         // }).then((value) {
      //         dio.post_data(url: "/pay",quary: {
      //         "user_id":cache.get_data("id"),
      //         "id":model.id,
      //         "type":model.type,
      //         }).then((value) {
      //
      //           // if(value?.data =="yes"){
      //           //   showDialog<void>(
      //           //     context: context,
      //           //     barrierDismissible: false,
      //           //     builder: (BuildContext dialogContext) {
      //           //       return AlertDialog(
      //           //         content: Text('ستتم مراجعة الدفعة خلال مدة اقصاها يومان'),
      //           //         actions: <Widget>[
      //           //           TextButton(
      //           //             child: Text('موافق'),
      //           //             onPressed: () {
      //           //               Navigator.of(dialogContext).pop(); // Dismiss alert dialog
      //           //               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false);
      //           //             },
      //           //           ),
      //           //         ],
      //           //       );
      //           //     },
      //           //   );                }
      //         });
      //       }, child: Text("ادفع"))
      //     ],
      //   ),
      // ),
    );
  }
}
