import 'dart:io';
import 'package:dio/dio.dart';

class DioHelper {
  static final String _baseUrl = "https://suhailonline.com/app/index.php?route=api/";
  static final String _apiKey = "wZpnZKfMES8QfluVpxgUhNtmsbfCharLeT8k3B84vjOgkoRJ5iEohLPxXnyK7JDtvAowKckDaK7oNTaDwaLhd9TvFBmxPq5Vh1OgIbGiRDAkF8uYDBr2mdcGGek9L7UIbVtGfxkJ2v3dKtJzmoVYexqsTb6BA6oD6OM8Bcfy8JhPXPba4Bf2NsVVZBpcjtBaGwWX4ZQvgw6awvmiWLstDbdrKsTJXxawa7u47hBexB7Cu56SmNAnmqxx5MV6JhUj";

  static late Dio _dio;

  static void init(){
    HttpOverrides.global = _MyHttpOverrides();
    _dio = Dio()..options.baseUrl = _baseUrl;
  }

  static Future<Response<dynamic>> get(String path) async {
    // _dio.options.headers = {
    //   // if(AppStorage.isLogged)
    //   //   'Authorization': AppStorage.userInfo.token
    // };
    return await _dio.get(path);
  }

  static Future<Response<dynamic>> post(String path, {Map<String, dynamic>? data, FormData? formData}) async {
    // _dio.options.headers = {
    //   'lang': 'en',
    //   // if(AppStorage.isLogged)
    //   //   'Authorization': AppStorage.userInfo.token
    // };
    if (data == null) {
      data = {};
    }
    if (formData != null) {
      formData.fields.add(MapEntry('key', _apiKey));
    }
    data.addAll({'key': _apiKey});
    return await _dio.post(path, data: formData ?? FormData.fromMap(data));
  }

  static Future<Response<dynamic>> put(String path, {var data}) async {
    _dio.options.headers = {
      'lang': 'en',
      // if(AppStorage.isLogged)
      //   'Authorization': AppStorage.userInfo.token
    };
    return await _dio.put(path, data: data);
  }

  static Future<Response<dynamic>> delete(String path, {var data}) async {
    _dio.options.headers = {
      'lang': 'en',
      // if(AppStorage.isLogged)
      //   'Authorization': AppStorage.userInfo.token
    };
    return await _dio.delete(path, data: data);
  }
}


class _MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

