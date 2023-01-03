import 'package:flutter/material.dart';

import '../models/list_auction_model.dart';

class option_details extends StatelessWidget {
  const option_details({Key? key,required auction_details_list_model this.model}) : super(key: key);
  final auction_details_list_model model;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(model.name!),),
      body: ListView.separated(
          itemBuilder: (context,index){
        print(model.details!.length);
        print(model.details!);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(model.details![index])),
        );
      }, separatorBuilder: (context,index){
        return Container(
          height: 2,
          width: double.infinity,
          color: Colors.grey,
        );
      }, itemCount: model.details!.length),
    );
  }
}
