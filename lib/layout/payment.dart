import 'dart:convert';

import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/layout/map_picker.dart';
import 'package:flutter/material.dart';
import 'package:auction_app/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../main.dart';
import '../models/add_model.dart';
InAppWebViewController? webViewController;

class Payment extends StatefulWidget {
  const Payment({Key? key, required this.model, required this.pay_type}) : super(key: key);
final add_model model;
final String pay_type;

  @override
  _PaymentState createState() => _PaymentState(model,pay_type);
}

class _PaymentState extends State<Payment> {
  final add_model model;
  final String pay_type;

  _PaymentState(this.model, this.pay_type);

  @override
  void dispose() {
    super.dispose();
    webViewController?.clearCache();
    webViewController?.clearFocus();
    webViewController?.clearMatches();
    webViewController?.removeAllUserScripts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: back_boutton(context),
      ),
      body: FutureBuilder(
        future: dio.post_data(url: "/pay",quary: {
                "user_id":cache.get_data("id"),
                "id":model.id,
                "type":model.type,
                "pay_type":pay_type,
                "price":model.price,
                "discount":model.time
                }),
        builder: (context,snapshot){
          print(model.time);
          print(snapshot.data);
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            // return WebViewX(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height,
            //   onWebViewCreated: (controller){
            //   webviewController = controller;
            //   webviewController.loadContent(
            //    // snapshot.data.toString(),
            //     "https://saudisauctions.com:3000/",
            //     SourceType.url,
            //   );},
            //
            // onPageStarted: (url){
            //     print("="*20);
            //     if(url.contains(base_url)){
            //       showDialog<void>(
            //           context: context,
            //           barrierDismissible: false,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               title: Center(child: Text("سيتم التأكد من الدفعة خلال فترة يومان")),
            //               actions: <Widget>[
            //                 Center(child: CircularProgressIndicator()),
            //               ],
            //             );
            //           },
            //         );
            //       Future.delayed(Duration(seconds: 3)).then((value) {
            //         Navigator.pop(context);
            //         webviewController.dispose();
            //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false);
            //       });
            //       }
            // }
            // );
            return InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(json.decode(snapshot.data.toString())!['url'].toString(),)),
          onWebViewCreated: (controller){
            webViewController = controller;
          },
          onReceivedHttpAuthRequest: (controller, challenge) async {
            //Do some checks here to decide if CANCELS or PROCEEDS
            return HttpAuthResponse(action:HttpAuthResponseAction.PROCEED );
          },
              onReceivedClientCertRequest: (controller , challenge)async{
              return ClientCertResponse(action: ClientCertResponseAction.IGNORE, certificatePath: '');
              },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
          //Do some checks here to decide if CANCELS or PROCEEDS
          return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
          },
              onUpdateVisitedHistory: (con,url,c){
                print("="*20);
                print(webViewController?.getTitle());
                if(url!.host.contains("saudisauctions")){
                  //dio.post_data()
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text("سيتم التأكد من الدفعة خلال فترة يومان")),
                        actions: <Widget>[
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    },
                  );
                  print(json.decode(snapshot.data.toString())!['tran_ref']);
                  print("start");
                  dio.post_data(url: "/pay/check",data: {
                    'tranRef':json.decode(snapshot.data.toString())!['tran_ref']
                  },quary: { 'tranRef':json.decode(snapshot.data.toString())!['tran_ref']}).then((value){
                    print(value?.data);
                    Navigator.pop(context);
                 //   webviewController.dispose();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>App()), (route) => false);
                  }).onError((error, stackTrace)  {print(error.toString());});
                  // Future.delayed(Duration(seconds: 3)).then((value) {

                  // });
                }
              },
          );
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
