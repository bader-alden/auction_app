import 'dart:async';

import 'package:auction_app/bloc/locale/locale_bloc.dart';
import 'package:auction_app/bloc/theme/theme_bloc.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/dio.dart';
import 'package:auction_app/layout/auction_details.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:uni_links/uni_links.dart';
import 'bloc/observ.dart';
import 'bloc/theme/theme.dart';
import 'layout/Home.dart';
import 'package:firebase_core/firebase_core.dart';

// ...


bool _initialURILinkHandled = false;
Uri? _initialURI;
Uri? _currentURI;
Object? _err;

StreamSubscription? _streamSubscription;
Future<void> _initURIHandler(context) async {
  if (!_initialURILinkHandled) {
    _initialURILinkHandled = true;
      final initialURI = await getInitialUri();
      // 4
      if (initialURI != null) {
        debugPrint("Initial URI received $initialURI");
        showDialog(context: context, builder: (context){
          return const AlertDialog(title: Center(child: CircularProgressIndicator()),);
        });
        if(initialURI.queryParameters["id"] != null &&initialURI.queryParameters["type"] != null){
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Test2(type: initialURI.queryParameters["type"],id:initialURI.queryParameters["id"],)));
          });
        }else{
          Navigator.pop(context);
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const App()), (route) => false);
        }
      } else {
        debugPrint("Null Initial URI received");
      }
      debugPrint('Malformed Initial URI received');
    }
  }

void _incomingLinkHandler(context) {
    _streamSubscription = uriLinkStream.listen((Uri? uri) {
      // showDialog(context: context, builder: (context){
      //   return const AlertDialog(title: Center(child: CircularProgressIndicator()),);
      // });
      if(uri?.queryParameters["id"] != null &&uri?.queryParameters["type"] != null){
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Test2(type: uri?.queryParameters["type"],id:uri?.queryParameters["id"],)));
        });

      }else{
        Navigator.pop(context);
       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const App()), (route) => false);
      }
    }, onError: (Object err) {
      debugPrint('Error occurred: $err');
    });
  }

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'high_importance_channel', // id
  'High Importance Notifications', // description
  importance: Importance.max,
);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message,flutterLocalNotificationsPlugin) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null ) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            enableLights: true,
            playSound: true,
            channel.id,
            channel.name,
             channel.description,
            icon: 'app_icon',
            // other properties...
          ),
            iOS: IOSNotificationDetails(
              subtitle:notification?.title,
            )
        ));
  }
}
main()async{
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // // await Firebase.initializeApp(
  // //   options: DefaultFirebaseOptions.currentPlatform,
  // // ).then((value) => print(value.name)).onError((error, stackTrace)
  // // {print(error);});
  // // print("aaaaaaa");
  // //
  //
  // await Future.delayed(Duration(seconds:3));
  // await dio.init();
  // print("aaaaaaa");
  // await cache.init();
  // if(cache.get_data("theme") == null){
  //   cache.save_data("theme", "system");
  // }
  // if(cache.get_data("locale") == null){
  //   cache.save_data("locale", "system");
  // }
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(const InitializationSettings(android: AndroidInitializationSettings('app_icon'),iOS: IOSInitializationSettings()));
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  // // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  //
  // FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandler(message,flutterLocalNotificationsPlugin));
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   if (notification != null ) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channel.description,
  //               icon: 'app_icon',
  //             ),
  //             iOS: IOSNotificationDetails(
  //               subtitle:notification.body,
  //             )
  //         ));
  //   }
  // });
  //
  //
  //
  // Bloc.observer =  MyBlocObserver();
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp().then((value) => print(value.name)).onError((error, stackTrace) {print(error);});
  // }else {
  //   Firebase.app();
  // }
  // try{
  //   final fcmToken = await FirebaseMessaging.instance.getToken().onError((error, stackTrace) {print(error);});
  //   print(fcmToken);
  // }catch(e){
  //
  // }
  // final fcmToken = await FirebaseMessaging.instance.getToken().onError((error, stackTrace) {print(error);});
  // print(fcmToken);
  runApp(const First());

}
class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/img/back.png", height: double.infinity, width: double.infinity, fit: BoxFit.fill),
                Image.asset("assets/img/intro.gif", ),
              ],
            ),
          );
        }
        else {
          // else if(snapshot.data.toString() =="ok") {
          return App();
          // } else {
          //   return Container(color: Colors.cyan,);
          // }
        }
      });
  }
}

Future<String?> init() async{
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then((value) => print(value.name)).onError((error, stackTrace)
  // {print(error);});
  // print("aaaaaaa");
  //

  await Future.delayed(Duration(seconds:3));
  await dio.init();
  print("aaaaaaa");
  await cache.init();
  if(cache.get_data("theme") == null){
    cache.save_data("theme", "system");
  }
  if(cache.get_data("locale") == null){
    cache.save_data("locale", "system");
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(const InitializationSettings(android: AndroidInitializationSettings('app_icon'),iOS: IOSInitializationSettings()));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

  FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandler(message,flutterLocalNotificationsPlugin));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null ) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: 'app_icon',
            ),
            iOS: IOSNotificationDetails(
              subtitle:notification.body,
            )
          ));
    }
  });



  Bloc.observer =  MyBlocObserver();
  if (Firebase.apps.isEmpty) {
   await Firebase.initializeApp().then((value) => print(value.name)).onError((error, stackTrace) {print(error);});
  }else {
    Firebase.app();
  }
  try{
    final fcmToken = await FirebaseMessaging.instance.getToken().onError((error, stackTrace) {print(error);});
    print(fcmToken);
  }catch(e){

  }
  // final fcmToken = await FirebaseMessaging.instance.getToken().onError((error, stackTrace) {print(error);});
  // print(fcmToken);


 return "ok";
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc(),),
       BlocProvider(create: (context) => LocaleBloc(),)
      ],
      child: Phoenix(child: const app()),
    );
  }
}

class app extends StatefulWidget {
  const app({super.key});
  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> with WidgetsBindingObserver {
  @override
  void initState() {
   // cache.save_data("auto_theme",true);


    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void didChangeLocales(List<Locale>? locales) {
    context.read<LocaleBloc>().change_local_void();
    super.didChangeLocales(locales);
  }
  @override
  void didChangePlatformBrightness() {
    context.read<ThemeBloc>().change_theme();
    super.didChangePlatformBrightness();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build (BuildContext context) {
    return
      MaterialApp(
          theme: theme_light(),
          darkTheme: theme_dark(),
          themeMode: context.select((ThemeBloc theme) => theme.state.theme),
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          home: const tt());
  }
}
class tt extends StatefulWidget {
  const tt({Key? key}) : super(key: key);

  @override
  State<tt> createState() => _ttState();
}

class _ttState extends State<tt> {

@override
  void initState() {
  _initURIHandler(context);
  _incomingLinkHandler(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context)  {
  return const Home();
  // return FutureBuilder(
  //     future: http.get(Uri.parse("http://saudisauctions.com:3000/main/version")),
  //     builder: (context,snapshot)   {
  //       if(snapshot.connectionState == ConnectionState.waiting){
  //         return Container(color: Colors.red,);
  //       }
  //       else{
  //         PackageInfo.fromPlatform().then((value) {
  //           if(snapshot.data?.body == value.version){
  //             return const Home();
  //           }else{
  //             return Container(color: Colors.black,);
  //           }
  //         });
  //         return Container(color: Colors.green,);
  //       }
  // });
   }
}
// Builder(builder: (context)  {
// dio.get_data(url: "http://saudisauctions.com:3000/main/version").then((value) async {
// var v = await PackageInfo.fromPlatform();
// print(v.version);
// print(value?.data);
// print(value?.data.toString()== v.version);
// if(value?.data.toString()== v.version){
// return App();
// }else{
// return Container(color: Colors.cyan,);
// }
//
// });
// return Container(color: Colors.red,);
// });
// }
// return Container(color: Colors.red,);



