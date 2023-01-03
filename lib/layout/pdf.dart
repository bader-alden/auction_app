import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdf extends StatelessWidget {
  const pdf({Key? key, this.name, this.link}) : super(key: key);
  final name;
  final link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
        body: Container(
            child: SfPdfViewer.network(
                link)));
  }
}
//https://tatbeky01.000webhostapp.com/sample.pdf