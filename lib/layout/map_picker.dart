// import 'package:flutter/material.dart';
// import 'package:google_map_location_picker_flutter/google_map_location_picker_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class map_picker extends StatelessWidget {
//   const map_picker({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(onPressed: () async {
//       AddressResult result = await  showGoogleMapLocationPicker(
//           pinWidget: Icon(Icons.location_pin,color: Colors.red,size: 55,),
//       pinColor: Colors.blue,
//       context: context,
//       addressPlaceHolder: "حرك الخريطة",
//       addressTitle: "عنوان التوصيل",
//           appBarTitle: "حدد موقع التوصيل",
//           confirmButtonColor: Colors.blue,
//           confirmButtonText: "تأكيد الموقع",
//           confirmButtonTextColor: Colors.black,
//           language:"ar" ,
//           searchHint: "ابحث عن موقع", initialLocation: LatLng(26,39)
//         , apiKey: 'AIzaSyCqchf2DwHinNmTS1QMcJQVftUVpEYyM0Y'
//         , country: '',
//
//         //  outOfBoundsMessage: "الخدمة غير متوفرة حاليا في هذه المنطقة"
//       );
//       if(result!=null){
//         print(result.address.toString()*500);
//       }
//     }, child: Text("child"));
//   }
//
// }
