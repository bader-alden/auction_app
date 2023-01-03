import 'package:auction_app/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../bloc/theme/theme_bloc.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("الشكل"),
            const SizedBox(height: 10,),
            Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      cache.save_data("theme", "system");
                      context.read<ThemeBloc>().change_theme();
                    }, child: const Text("شكل النظام")),
                    const SizedBox(width: 10,),
                    ElevatedButton(onPressed: (){
                      cache.save_data("theme", "light");
                      context.read<ThemeBloc>().change_theme();
                    }, child: const Text("الفاتح")),
                    const SizedBox(width: 10,),
                    ElevatedButton(onPressed: (){
                      cache.save_data("theme", "dark");
                      context.read<ThemeBloc>().change_theme();
                    }, child: const Text("الغامق")),
                  ],
                );
              }
            ),
            const SizedBox(height: 30,),
            const Text("اللغة"),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  //context.read<LocaleBloc>().change_local_void("system");
                  cache.save_data("locale", "system");
                  Phoenix.rebirth(context);
                }, child: const Text("لغة النظام")),
                const SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  //context.read<LocaleBloc>().change_local_void("ar");
                  cache.save_data("locale", "ar");
                  Phoenix.rebirth(context);
                }, child: const Text("اللغة العربية")),
                const SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  //context.read<LocaleBloc>().change_local_void("en");
                  cache.save_data("locale", "en");
                  Phoenix.rebirth(context);
                }, child: const Text("English")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
