import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../bloc/locale/locale_bloc.dart';

class pdf extends StatelessWidget {
  const pdf({Key? key, this.name, this.link}) : super(key: key);
  final name;
  final link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
                Navigator.pop(context);
            },
            icon: context.read<LocaleBloc>().lang
                ? Icon(Icons.arrow_forward_ios, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                : Icon(Icons.arrow_back_ios, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
        title: Text(name),
      ),
        body: Container(
            child: Center(child: Image.network(link))));
  }
}
//https://tatbeky01.000webhostapp.com/sample.pdf