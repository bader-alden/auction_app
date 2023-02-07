import 'package:auction_app/layout/payment.dart';
import 'package:auction_app/models/add_model.dart';
import 'package:flutter/material.dart';
var add_mony_price_con = TextEditingController();
int add_mony_price = 0;
class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("ليدك في حسابك"+"500"),
          SizedBox(height: 50,),
          Text("يرجى كتابة سعر المزاد الذي تريد دخوله"),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none, hintTextDirection: TextDirection.rtl),
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
    );
  }
}
