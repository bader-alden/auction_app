
import 'package:auction_app/bloc/fav/fav_bloc.dart';
import 'package:auction_app/bloc/theme/theme.dart';
import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/layout/Home.dart';
import 'package:auction_app/layout/Map.dart';
import 'package:auction_app/layout/auction_option_details.dart';
import 'package:auction_app/layout/confirm_pay.dart';
import 'package:auction_app/layout/pdf.dart';
import 'package:auction_app/models/list_auction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:share/share.dart';
import '../bloc/locale/locale_bloc.dart';
import '../bloc/stram/stream_bloc.dart';

import 'favotite.dart';

var long_text =
    """Lorem Ipsum és un text de farciment usat per la indústria de la tipografia i la impremta. Lorem Ipsum ha estat el text estàndard de la indústria des de l'any 1500, quan un impressor desconegut va fer servir una galerada de text i la va mesclar per crear un llibre de mostres tipogràfiques. romanent essencialment sense canvis. Es va popularitzar l'any 1960 amb el llançament de fulls Letraset que contenien passatges de Lorem Ipsum, i més recentment amb programari d'autoedició com Aldus Pagemaker que inclou versions de Lorem Ipsum.""";
bool is_add = false;
bool from_go = false;
bool from_fav = false;
var img_page_con = PageController();
var text_con = TextEditingController();

//Map(lat: "37.759392",lng: "-122.5107336")
class Test2 extends StatelessWidget {
  const Test2({Key? key, this.id, this.type, this.from}) : super(key: key);
  final id;
  final type;
  final from;

  @override
  Widget build(BuildContext context) {
    print(id);
    print(type);
    var a = 1;
    if (from == "sqr") {
      from_go = true;
    } else {
      from_go = false;
    }
    if (from == "fav") {
      from_fav = true;
    } else {
      from_fav = false;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          StreamBloc()
            ..init_stream_void()
            ..get_one_void(id, type)
            ..get_fav(id, type),
        ),
        BlocProvider(  create: (context) => FavBloc()..check(type, id),
        ),
        BlocProvider(
          create: (context) => LocaleBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return StreamBuilder(
            stream: context
                .read<StreamBloc>()
                .get_one_stream_controller
                .stream,
            builder: (context, snapshot) {
              if (snapshot.data.toString() == "NOTFOUND") {
                return const Scaffold(
                    body: Center(
                      child: Text("العنصر المطلوب غير متاح"),
                    ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else {
                list_auction_model? model;
                snapshot.data.runtimeType == list_auction_model ? model = snapshot.data : model = list_auction_model.fromjson(snapshot.data);
                print(model!.is_auction);
                if(model.status=="2"){
                  return  Scaffold(
                    appBar: AppBar(),
                      body: Center(
                        child: Text("العنصر المطلوب غير متاح"),
                      ));
                }
                return Directionality(
                  textDirection: context
                      .read<LocaleBloc>()
                      .lang ? TextDirection.ltr : TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      title: Text("${context
                          .read<LocaleBloc>()
                          .test2_id}${model.id!}"),
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (from_go&& cache.get_data("sqr") ==null) {
                              Phoenix.rebirth(context);
                            }
                            if(from_fav){
                              print("sta");
                              is_change=true;
                            }
                          },
                          icon: context
                              .read<LocaleBloc>()
                              .lang
                              ? Icon(Icons.arrow_forward_ios, color: Theme
                              .of(context)
                              .brightness == Brightness.dark ? Colors.white : Colors.black)
                              : Icon(Icons.arrow_back_ios, color: Theme
                              .of(context)
                              .brightness == Brightness.dark ? Colors.white : Colors.black)),
                    ),
                    body: WillPopScope(
                      onWillPop: () async {
                        if (from_go) {
                          Phoenix.rebirth(context);
                        }
                        if(from_fav){
                          is_change=true;
                        }
                        return true;
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: 250,
                                    child: StatefulBuilder(builder: (context, setstate) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          PageView.builder(
                                              onPageChanged: (index) {
                                                setstate(() {
                                                  a = index + 1;
                                                });
                                              },
                                              itemCount: model?.photos?.length,
                                              controller: img_page_con,
                                              physics: const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Image(
                                                    image: NetworkImage(model?.photos?.length == 1 ? model!.photo! : model!.photos![index]),
                                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                          value: loadingProgress.expectedTotalBytes != null
                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    });
                                              }),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 60,
                                                      height: 30,
                                                      color: Colors.red,
                                                      child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text("${a}",
                                                                    style: TextStyle(
                                                                      color:
                                                                      Theme
                                                                          .of(context)
                                                                          .brightness == Brightness.dark ? Colors.black : Colors.white,
                                                                    )),
                                                                Text(context
                                                                    .read<LocaleBloc>()
                                                                    .of,
                                                                    style: TextStyle(
                                                                      color:
                                                                      Theme
                                                                          .of(context)
                                                                          .brightness == Brightness.dark ? Colors.black : Colors.white,
                                                                    )),
                                                                Text(" ${model?.photos?.length}",
                                                                    style: TextStyle(
                                                                      color:
                                                                      Theme
                                                                          .of(context)
                                                                          .brightness == Brightness.dark ? Colors.black : Colors.white,
                                                                    )),
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    borderRadius:
                                                    const BorderRadius.only(bottomRight: Radius.circular(1000), topRight: Radius.circular(1000)),
                                                    onTap: () {
                                                      if (img_page_con.page != 0) {
                                                        img_page_con.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 30,
                                                      decoration: context
                                                          .read<LocaleBloc>()
                                                          .lang
                                                          ? const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.only(
                                                              bottomRight: Radius.circular(1000), topRight: Radius.circular(1000)))
                                                          : const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(1000), topLeft: Radius.circular(1000))),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Theme
                                                            .of(context)
                                                            .brightness == Brightness.dark ? Colors.black : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return SimpleDialog(
                                                                    insetPadding: EdgeInsets.zero,
                                                                    contentPadding: EdgeInsets.zero,
                                                                    titlePadding: EdgeInsets.zero,
                                                                    backgroundColor: Colors.transparent,
                                                                    children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        child: Image(
                                                                          image: NetworkImage(model?.photos?.length == 1
                                                                              ? model!.photo!
                                                                              : model!.photos![img_page_con.page!.toInt()]),
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      )
                                                                    ]);
                                                              });
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 30,
                                                          color: Colors.red,
                                                          child: Icon(
                                                            Icons.fullscreen,
                                                            color: Theme
                                                                .of(context)
                                                                .brightness == Brightness.dark ? Colors.black : Colors.white,
                                                          ),
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(1000), topLeft: Radius.circular(1000)),
                                                onTap: () {
                                                  if (img_page_con.page != model!.photos!.length - 1) {
                                                    img_page_con.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                                                  }
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 30,
                                                  decoration: context
                                                      .read<LocaleBloc>()
                                                      .lang
                                                      ? const BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                      BorderRadius.only(bottomLeft: Radius.circular(1000), topLeft: Radius.circular(1000)))
                                                      : const BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                      BorderRadius.only(bottomRight: Radius.circular(1000), topRight: Radius.circular(1000))),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Theme
                                                        .of(context)
                                                        .brightness == Brightness.dark ? Colors.black : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(255, 184, 60, 60),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 60,
                                            padding: const EdgeInsets.all(13),
                                            color: const Color.fromARGB(255, 184, 60, 60),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // StatefulBuilder(builder: (context, setrstate) {
                                                //   is_add = false;
                                                //   if (cache.get_data("sqr") != null) {
                                                //     if (cache.get_data("sqr").toString().split("-")[0] == model?.id &&
                                                //         cache.get_data("sqr").toString().split("-")[1] == type) {
                                                //       setrstate(() {
                                                //         is_add = true;
                                                //       });
                                                //     }
                                                //   }
                                                //   return IconButton(
                                                //       iconSize: 20,
                                                //       onPressed: () {
                                                //         if (is_add) {
                                                //           cache.remove_data("sqr");
                                                //           setrstate(() {
                                                //             is_add = false;
                                                //           });
                                                //         } else {
                                                //           cache.save_data("sqr", "${model!.id!}-$type");
                                                //           StreamBloc().sqr_void();
                                                //           setrstate(() {
                                                //             is_add = true;
                                                //           });
                                                //           Navigator.pushAndRemoveUntil(
                                                //               context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                                                //         }
                                                //       },
                                                //       icon: Icon(
                                                //         is_add ? Icons.delete : Icons.add,
                                                //         color: Colors.white,
                                                //       ));
                                                // }),
                                                IconButton(
                                                    onPressed: () {
                                                      Share.share(
                                                          'إضغط على الرابط لمشاهدة المزاد\n https://faceted-dull-evening.glitch.me/?id=$id&type=$type');
                                                    },
                                                    iconSize: 20,
                                                    icon: const Icon(
                                                      Icons.share,
                                                      color: Colors.white,
                                                    )),
                                                Fav_icon(type,id),
                                                //Image(image: AssetImage("assets/img/17.png"),height: 18,),
                                                //Image(image: AssetImage("assets/img/20.png"),height: 22,color: Colors.white,),
                                                IconButton(
                                                    onPressed: () {
                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => pdf()));
                                                    },
                                                    iconSize: 20,
                                                    icon: const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: context
                                                  .read<LocaleBloc>()
                                                  .lang
                                                  ? const BorderRadius.only(topLeft: Radius.circular(50))
                                                  : const BorderRadius.only(topRight: Radius.circular(50))),
                                          width: 170,
                                          height: 60,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              const Image(
                                                image: AssetImage("assets/img/2.png"),
                                                height: 35,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Timer_widget(
                                                  model.time, context, Colors.white)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Center(
                                          child: Text(
                                            model.name!,
                                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                          ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(padding: const EdgeInsets.all(8), child: Center(child: Text(model.des!))),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  end_test_2(model, context),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  option_list(model, context)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  if (cache.get_data("id") != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                confirm_pay(
                                                  model: model,
                                                  type: type,
                                                )));
                                  } else {
                                    tost(msg: "يلزم تسجيل الدخول", color: Colors.red);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                      child: Text(
                                        context
                                            .read<LocaleBloc>()
                                            .test2_end,
                                        style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                      )),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            });
      }),
    );
  }

  Widget end_test_2(list_auction_model model, BuildContext context) {
    var paid = model.sub!.firstWhere((element) => element.contains("-${cache.get_data("id") ?? "]'/[;."}|"), orElse: () => "not|0");
    var rank = model.sub?.indexOf(paid);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: main_red,
                            radius: 15,
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Image(
                                image: AssetImage("assets/img/1.png"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context
                                .read<LocaleBloc>()
                                .a + " : ${model.num_add!}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: main_red,
                          radius: 15,
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Image(
                              image: AssetImage("assets/img/4.png"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${context
                              .read<LocaleBloc>()
                              .q} : ${rank! + 1 == 0 ? context
                              .read<LocaleBloc>()
                              .not : rank + 1}",
                          style: TextStyle(
                              fontSize: 12,
                              color: rank + 1 == 1
                                  ? Colors.amber.shade900
                                  : Theme
                                  .of(context)
                                  .brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: main_red,
                            radius: 15,
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Image(
                                image: AssetImage("assets/img/2.png"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context
                                .read<LocaleBloc>()
                                .w + " : ${model.time!.substring(0, 10)}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 15,
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Image(
                                  image: AssetImage("assets/img/0.png"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${context
                                  .read<LocaleBloc>()
                                  .z} : ${model.price!}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 37,
                            decoration: BoxDecoration(border: Border.all(color: main_red), borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: main_red,
                            radius: 15,
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Image(
                                image: AssetImage("assets/img/3.png"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context
                                .read<LocaleBloc>()
                                .x + " : ${paid.split("|")[1] == "0" ? context
                                .read<LocaleBloc>()
                                .not : paid.split("|")[1]}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 15,
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Image(
                                  image: AssetImage("assets/img/0.png"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              context
                                  .read<LocaleBloc>()
                                  .s + " : ${model.num_price!}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 37,
                            decoration: BoxDecoration(border: Border.all(color: main_red), borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget option_list(list_auction_model model, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(40),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (model.text_1 != null) option_list_details(context, model.text_1!, null),
        if (model.text_2 != null) option_list_details(context, model.text_2!, null),
        if (model.text_3 != null) option_list_details(context, model.text_3!, null),
        if (model.file_1 != null) option_list_details(context, null, model.file_1!),
        if (model.file_2 != null) option_list_details(context, null, model.file_2!),
        if (model.file_3 != null) option_list_details(context, null, model.file_3!),
        if (model.location != null)
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Map_screen(
                                lat: model.location![0],
                                lng: model.location![1],
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 75,
                  color: Colors.grey.withOpacity(0.2),
                  child: Row(
                    children: [const Text("الموقع"), const Spacer(), const Icon(Icons.arrow_forward_ios)],
                  ),
                ),
              ),
              Container(
                height: 2,
                color: Colors.grey,
              )
            ],
          )
      ],
    );
  }

  option_list_details(context, auction_details_list_model? model, auction_details_list_model_file? file) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (model == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          pdf(
                            name: file!.name!,
                            link: file.link!,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          option_details(
                            model: model,
                          )));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 75,
            color: Colors.grey.withOpacity(0.2),
            child: Row(
              children: [Text(model?.name ?? file!.name!), const Spacer(), const Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey,
        )
      ],
    );
  }

}

  Widget Fav_icon(type,id) {
    return BlocConsumer<FavBloc,FavState>(
        listener: (context,state){
         if(state is loadin_state){
           print("loading.....");
         }
        },
        builder: (context,state) {
          if(state is loadin_state){
            return const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.white,));
          }
          else if(FavBloc.get(context).is_fav  == true){
            return InkWell(onTap: (){
              FavBloc.get(context).delet_fav(type, id);
            },child: const Image(image: AssetImage("assets/img/17.png"),height: 18,));
          }
          else if( FavBloc.get(context).is_fav  == false){
            return InkWell(onTap:
                (){
              if(cache.get_data("id")!=null){
                FavBloc.get(context).add_to_fav_void(type, id);
              }else{
                tost(msg: "يجب تسجيل الدخول أولا",color: Colors.red);
              }
            },child: const Image(image: AssetImage("assets/img/20.png"),height: 22,color: Colors.white,));
          }
          else{
            return const SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.red,));
          }
        },
      );
  }


