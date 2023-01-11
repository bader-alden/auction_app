import 'package:auction_app/bloc/Main/Main_bloc.dart';
import 'package:auction_app/bloc/Main/Main_state.dart';
import 'package:auction_app/bloc/locale/locale_bloc.dart';
import 'package:auction_app/layout/Account.dart';
import 'package:auction_app/layout/Home_page.dart';
import 'package:auction_app/layout/auction.dart';
import 'package:auction_app/layout/my_auction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;
import '../bloc/stram/stream_bloc.dart';
import '../bloc/theme/theme.dart';
import 'favotite.dart';

var con = PageController();

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var home_tab_con = useTabController(initialLength: 1);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => main_bloc()),
          BlocProvider(create: (context) => LocaleBloc()),
          BlocProvider(create: (context) => StreamBloc()..init_stream_void()),
        ],
        child: BlocListener<StreamBloc, StreamState>(
          listener: (context, state) {
            if (state is disconect_state) {
              showDialog(
                  context: context,
                  builder: (contextk) {
                    return AlertDialog(
                      title: const Text("dissconect"),
                      actions: [ElevatedButton(onPressed: (){
                        context.read<StreamBloc>().init_stream_void();
                        Navigator.pop(contextk);
                      }, child: const Text("retry"))],
                    );
                  });
            }
          },
          child: BlocConsumer<main_bloc, main_state>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: PageView(
                  reverse: !context.read<LocaleBloc>().lang,
                  children: [Home_page(context, home_tab_con), const Auctions(), const Favoraite(), const main_acount()],
                  physics: const BouncingScrollPhysics(),
                  controller: con,
                  onPageChanged: (index) {
                    main_bloc.get(context).change_nav_index(index);
                  },
                ),
                bottomNavigationBar: Transform(
                  alignment: Alignment.center,
                  transform: context.read<LocaleBloc>().lang ? Matrix4.rotationX(0) : Matrix4.rotationY(math.pi),
                  child: BottomNavigationBar(
                    currentIndex: main_bloc.get(context).nav_bar_index,
                    onTap: (index) {
                      main_bloc.get(context).change_nav_index(index);
                      con.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                    backgroundColor:  Theme.of(context).brightness ==Brightness.light?Colors.white:Colors.black,
                    selectedItemColor: main_red,
                    elevation: 0,
                    unselectedItemColor: Colors.grey,
                    iconSize: 30,
                    type: BottomNavigationBarType.fixed,
                    items: [
                      const BottomNavigationBarItem(icon: Icon(Icons.home),label: ""),
                      BottomNavigationBarItem(
                          icon: const Image(image: AssetImage("assets/img/14.png"),color: Colors.grey,height: 25,width: 25,),
                          activeIcon: Image(image: const AssetImage("assets/img/14.png"),color: main_red,height: 25,width: 25,),
                          label: ""),
                      BottomNavigationBarItem(
                          icon: const Image(image: AssetImage("assets/img/17.png"),color: Colors.grey,height: 25,width: 25,),
                          activeIcon: Image(image: const AssetImage("assets/img/17.png"),color: main_red,height: 25,width: 25,),
                          label: ""),
                      const BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: ""),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
