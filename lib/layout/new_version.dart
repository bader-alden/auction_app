import 'package:auction_app/bloc/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewVersion extends StatelessWidget {
  const NewVersion({Key? key, this.link}) : super(key: key);
  final link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("يتوفر إصدار جديد "),),
            SizedBox(height: 20,),
            Center(child: Text("يرجى تحديث التطبيق إلى اخر إصدار من الموقع الرسمي"),),
            SizedBox(height: 20,),
            InkWell(onTap: () async {
              Uri url = Uri.parse(link);
              if (await canLaunchUrl(url)) {
                await launchUrl(url,mode: LaunchMode.externalApplication);
              } else {
                throw "Could not launch $url";
              }
            },child: Container(width: MediaQuery.of(context).size.width/1.5,height:60,decoration:BoxDecoration(color: main_red,borderRadius: BorderRadius.circular(10)),child: Center(child: Text("تحميل",style:TextStyle(color: Colors.white,fontSize: 22), )),),)
          ],
        ),
      ),
    );
  }
}
