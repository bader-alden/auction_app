import 'package:dio/dio.dart';

class dio {
  static Dio? dios;
  static init() {
    dios = Dio(BaseOptions(
        baseUrl: "https://faceted-dull-evening.glitch.me/",
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
      {url, quary, data, lang = "ar", token}) async {
    dios?.options.headers = {'Accept':'application/json'};

    return dios?.post(url, queryParameters: quary, data: data);
  }

  static Future<Response?> put_data(
      {url, quary, data, lang = "ar", token}) async {
    dios?.options.headers = {'lang': lang, 'Authorization': token};

    return dios?.put(url, queryParameters: quary, data: data);
  }
}
