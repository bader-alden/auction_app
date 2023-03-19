import 'package:dio/dio.dart';

class dio {
  static Dio? dios;
  static init() {
    dios = Dio(BaseOptions(
        baseUrl: "http://31.220.50.200:3000/",
      //  baseUrl: "https://faceted-dull-evening.glitch.me/",
        receiveDataWhenStatusError: true,
        followRedirects: true,
        validateStatus: (status) { return status! < 500;},
        headers: {'Content-Type': 'application/json','Accept':'application/json'}));
  }

  static Future<Response?> get_data({url, quary}) async {
    dios?.options.headers = { 'Accept':'application/json'};
    return await dios?.get(url,queryParameters: quary ??{});
  }

  static Future<Response?> post_data(
      {url, quary, data, token,onsend}) async {
    dios?.options.headers = {'Accept':'application/json'};

    return dios?.post(url, queryParameters: quary, data: data,onSendProgress:onsend);
  }

}
