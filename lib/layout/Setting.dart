import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../bloc/locale/locale_bloc.dart';
import '../bloc/theme/theme_bloc.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);},
              icon: context
                  .read<LocaleBloc>()
                  .lang
                  ? Icon(Icons.arrow_forward_ios, color: Theme
                  .of(context)
                  .brightness == Brightness.dark ? Colors.white : Colors.black)
                  : Icon(Icons.arrow_back_ios, color: Theme
                  .of(context)
                  .brightness == Brightness.dark ? Colors.white : Colors.black)),
          title: Text("إعدادت التطبيق"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))),
                      height: MediaQuery.of(context).size.height / 3,
                      child: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: (){
                              //context.read<LocaleBloc>().change_local_void("system");
                              cache.save_data("locale", "system");
                              Phoenix.rebirth(context);
                            }, child:  Text("لغة النظام",style: TextStyle(fontSize: 24,color: cache.get_data("locale") == "system" ?Colors.red :Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, ),)),
                            const SizedBox(width: 10,),
                            TextButton(onPressed: (){
                              //context.read<LocaleBloc>().change_local_void("ar");
                              cache.save_data("locale", "ar");
                              Phoenix.rebirth(context);
                            }, child:  Text("اللغة العربية",style: TextStyle(fontSize: 24,color: cache.get_data("locale") == "ar" ?Colors.red :Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, ),)),
                            const SizedBox(width: 10,),
                            TextButton(onPressed: (){
                              //context.read<LocaleBloc>().change_local_void("en");
                              cache.save_data("locale", "en");
                              Phoenix.rebirth(context);
                            }, child:  Text("اللغة الإنكليزية",style: TextStyle(fontSize: 24,color: cache.get_data("locale") == "en" ?Colors.red :Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, ),)),
                          ],
                        );
                      }),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(color: main_red,borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 8),
                      child: Text("إعدادات اللغة",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                  ),
                )),
            SizedBox(height: 50,),
            InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))),
                      height: MediaQuery.of(context).size.height / 3,
                      child: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          TextButton(onPressed: (){
                            //context.read<LocaleBloc>().change_local_void("system");
                            cache.save_data("theme", "system");
                            context.read<ThemeBloc>().change_theme();
                            Navigator.pop(context);
                          }, child:  Text("شكل النظام",style: TextStyle(fontSize: 24,color: cache.get_data("theme") == "system" ?Colors.red :Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, ),)),
                          const SizedBox(width: 10,),
                          TextButton(onPressed: (){
                            //context.read<LocaleBloc>().change_local_void("ar");
                            cache.save_data("theme", "light");
                            context.read<ThemeBloc>().change_theme();
                            Navigator.pop(context);
                          }, child:  Text("الشكل الفاتح",style: TextStyle(fontSize: 24,color: cache.get_data("theme") == "light" ?Colors.red :Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, ),)),
                          const SizedBox(width: 10,),
                          TextButton(onPressed: (){
                            //context.read<LocaleBloc>().change_local_void("en");
                            cache.save_data("theme", "dark");
                            context.read<ThemeBloc>().change_theme();
                            Navigator.pop(context);
                          }, child:  Text("الشكل الغامق",style: TextStyle(fontSize: 24,color: cache.get_data("theme") == "dark" ?Colors.red :Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, ),)),
                         ],
                        );
                      }),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(color: main_red,borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 8),
                      child: Text("شكل التطبيق",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                  ),
                )),
          ],
        ));
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("الشكل"),
//           const SizedBox(height: 10,),
//           Builder(
//               builder: (context) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(onPressed: (){
//                       cache.save_data("theme", "system");
//                       context.read<ThemeBloc>().change_theme();
//                     }, child: const Text("شكل النظام")),
//                     const SizedBox(width: 10,),
//                     ElevatedButton(onPressed: (){
//                       cache.save_data("theme", "light");
//                       context.read<ThemeBloc>().change_theme();
//                     }, child: const Text("الفاتح")),
//                     const SizedBox(width: 10,),
//                     ElevatedButton(onPressed: (){
//                       cache.save_data("theme", "dark");
//                       context.read<ThemeBloc>().change_theme();
//                     }, child: const Text("الغامق")),
//                   ],
//                 );
//               }
//           ),
//           const SizedBox(height: 30,),
//           const Text("اللغة"),
//           const SizedBox(height: 10,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(onPressed: (){
//                 //context.read<LocaleBloc>().change_local_void("system");
//                 cache.save_data("locale", "system");
//                 Phoenix.rebirth(context);
//               }, child: const Text("لغة النظام")),
//               const SizedBox(width: 10,),
//               ElevatedButton(onPressed: (){
//                 //context.read<LocaleBloc>().change_local_void("ar");
//                 cache.save_data("locale", "ar");
//                 Phoenix.rebirth(context);
//               }, child: const Text("اللغة العربية")),
//               const SizedBox(width: 10,),
//               ElevatedButton(onPressed: (){
//                 //context.read<LocaleBloc>().change_local_void("en");
//                 cache.save_data("locale", "en");
//                 Phoenix.rebirth(context);
//               }, child: const Text("English")),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }
