import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static init() {
    // no need to use init method
  }

// method from get data from API
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    return await dio.get(url,
        queryParameters: query,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'lang': lang,
          'Authorization': token ?? '',
        }));
  }

// method from post data from API
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    return await dio.post(url,
        data: data,
        queryParameters: query,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'lang': lang,
          'Authorization': token ?? '',
        }));
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    return await dio.put(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'lang': lang,
          'Authorization': token ?? '',
        }));
  }
}
