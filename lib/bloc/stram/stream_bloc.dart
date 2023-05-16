import 'dart:async';
import 'dart:convert';
import 'package:auction_app/cache.dart';
import 'package:auction_app/const.dart';
import 'package:auction_app/models/list_auction_model.dart';
import 'package:auction_app/models/main_list_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart'as IO;
import 'package:socket_io_client/socket_io_client.dart'hide cache;
part 'stream_event.dart';
part 'stream_state.dart';
IO.Socket? socket;

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  StreamBloc() : super(StreamInitial()) {
   // on<get_one_event>(((event, emit) async {
   //   // emit(loading_list_auction_state());
   //   socket?.emit("get_one",int.parse(event.id));
   //   socket?.on("res_one", (data) {
   //     if(jsonDecode(data)['data'] != "NOTFOUND"){
   //       aa = data;
   //       emit(scss_list_auction_state());
   //     }else{
   //       emit(faild_list_auction_state());
   //     }
   //
   //   });
   // }));

  }
var aa;
  StreamController get_stream_controller = StreamController.broadcast();
  StreamController get_one_stream_controller = StreamController.broadcast();
  StreamController sqr_stream_controller = StreamController.broadcast();

  Future init_stream_void()async {
    //emit(loading_init_stream_state());
     socket = IO.io(base_url,<String, dynamic>{
     'transports': ['websocket'],
     'force new connection': true,
     'query': {
     'timeStamp': new DateTime.now().millisecondsSinceEpoch
     }
     },
     //socket = IO.io('https://faceted-dull-evening.glitch.me',
        );
   // socket?.connect();
     socket?.onConnect((_) {
      //  emit(scss_init_stream_state());
      // socket?.emit("a",socket.id);
    });
    socket?.onDisconnect((_)  {
      // socket?.disconnect();
      // socket?.dispose();
      // socket?.destroy();
      print("desconect");
      socket = IO.io(base_url,<String, dynamic>{
        'transports': ['websocket'],
        'force new connection': true,
        'query': {
          'timeStamp': new DateTime.now().millisecondsSinceEpoch
        }
      },

        //socket = IO.io('https://faceted-dull-evening.glitch.me',
      );

    emit(disconect_state());
    });
    socket?.onConnectError((err) {
      emit(disconect_state());
      print(err);
       });
    // socket?.on("hello", (data) => print(data));
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }
  List<list_auction_model>? list_auction=[];
  void get_all(type){
    socket?.emit("get_all",{"type":type});
    socket?.on("res_all", (data) {
      print(data);
      if(data["type"].toString() == type ) {
        list_auction = [];
        var datas = jsonDecode(data["data"]);
        datas.forEach((element) {
          list_auction?.add(list_auction_model.fromjson(element));
        });
        //print(list_auction?[0].name);
        get_stream_controller.add(list_auction);
        // aa=data;}
      } });
  }


  void get_one_void(id,type) async {
    // emit(loading_list_auction_state());
    socket?.emit("get_one",{"id":int.parse(id),"type":type});
    socket?.on("res_one", (data) {
      try {
        var adata ;
        adata =  json.decode(data["data"].toString().substring(1,data["data"].toString().length-1));
        if(adata["id"]==int.parse(id)&& data["type"]==type){
          print("here");
          get_one_stream_controller.add(adata);
        }
      }catch(e) {
        get_one_stream_controller.add("NOTFOUND");
      }
    });
  }
  void sqr_void() async {
    // emit(loading_list_auction_state());
    if(cache.get_data("sqr") != null){
      socket?.emit("get_one",{"id":int.parse(cache.get_data("sqr").toString().split("-")[0]),"type":cache.get_data("sqr").toString().split("-")[1]});
      socket?.on("res_one", (data) {
        try {
          var adata ;
          adata =  json.decode(data["data"].toString().substring(1,data["data"].toString().length-1));
          if(adata["id"]==int.parse(cache.get_data("sqr").toString().split("-")[0])&& data["type"]==cache.get_data("sqr").toString().split("-")[1]){
            sqr_stream_controller.add(adata);
          }
        }catch(e) {
          sqr_stream_controller.add("NOTFOUND");
        }
      });
    }
  }

  void update(list_auction_model model,type,my_price){
    // log  num_add  sub  price
    print (model.sub);
    var r_price= (int.parse(model.price!) + int.parse(my_price)).toString();
    var user_id = cache.get_data("id");
    socket?.emit("update",{"id":int.parse(model.id!),"name":user_id,"type":type!,"sub_price":r_price});
    // var b = list_auction_model.fromjson({
    //   "id":model.id,
    //   "name":model.name,
    //   "price":r_price,
    //   "num_price":model.num_price,
    //   "num_add":r_num_add,
    //   "num":model.num,
    //   "log":model.log,
    //   "sub":model.sub,
    //   "kind":model.kind,
    //   "min_price":model.time,
    //   "photo":model.photo,
    //   "photos":model.photos,
    //
    // });
   // list_auction?.add(b);
    // get_one_void(model.id, type);
    // get_stream_controller.add(list_auction!);
    // get_one_stream_controller.add(b);
    if(cache.get_data("sqr")!=null){
      if(cache.get_data("sqr").toString().split("-")[0]==model.id&&cache.get_data("sqr").toString().split("-")[1]==type){
       // sqr_stream_controller.add(b);
      }
    }

  }
  bool is_fav = false;
void get_fav (id,type){}
}
