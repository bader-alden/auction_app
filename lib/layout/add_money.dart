import 'package:auction_app/bloc/locale/locale_bloc.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/dio.dart';
import 'package:auction_app/layout/payment.dart';
import 'package:auction_app/models/add_model.dart';
import 'package:flutter/material.dart';
var add_mony_price_con = TextEditingController();
int add_mony_price = 0;
var user_mouny=-1;
class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
@override
  void initState() {
    dio.get_data(url: "pay/get_wallet",quary: {
    "user_id":cache.get_data("id")
    }).then((value) => {
      setState((){
        print(value?.data[0]);
        user_mouny=int.parse(value?.data[0]['balance']);
    })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("محفظتي"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleBloc().curunce),
                SizedBox(width: 20,),
                if(user_mouny==-1)
                  SizedBox(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.white,))
                else
                  Text(user_mouny.toString()),
                SizedBox(
                  width: 20,
                ),
                Text(":لديك في حسابك "),
              ],
            ),
            SizedBox(height: 50,),
            Text("يرجى كتابة سعر المزاد الذي تريد دخوله"),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width/1.2,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(prefix: Text(LocaleBloc().curunce),border: InputBorder.none, hintTextDirection: TextDirection.rtl),
                  controller: add_mony_price_con,
                  onChanged: (value){
                    setState(() {
                      add_mony_price=(int.parse(value)*0.1).round();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("المبلغ الواجب دفعه"+add_mony_price.toString()),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(model: add_model.fromjson("a|a|mix|a", {"name":"a","price":add_mony_price.toString(),"time":"a"}), pay_type: "add")));
            }, child: Text("دفع"))
          ],
        ),
      ),
    );
  }
}
