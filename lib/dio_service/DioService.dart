import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  //klklkkl
  static Dio? _dio;
  static SharedPreferences? prefs;
  static final DioService _singleton = DioService._internal();
  static var _token = "";
  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    initializeDio();
  }

  static Future<String?> getToken() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    _token = prefs!.getString("accessToken") ?? "F";
    return _token;
  }

  static getHeader() async {
    var token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<void> initializeDio() async {
    _dio = Dio(
      BaseOptions(
        baseUrl:
            'https://api.infogird.com/prod/api/', //'https://api.infogird.com/prod/api/',
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 90),
        headers: await getHeader(),
        // followRedirects: false,
        // validateStatus: (status) => true,
      ),
    );

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response != null) {
            if (e.response!.statusCode == 401) {
              if (await refreshToken()) {
                var requestOptions = e.requestOptions;
                _dio!.options.headers = await getHeader();
                final opts = new Options(method: requestOptions.method);
                final response = await _dio!.request(requestOptions.path,
                    options: opts,
                    cancelToken: requestOptions.cancelToken,
                    onReceiveProgress: requestOptions.onReceiveProgress,
                    data: requestOptions.data,
                    queryParameters: requestOptions.queryParameters);
                return handler.resolve(response);
              } else {
                return handler.next(e);
              }
            } else if (e.response!.statusCode == 403) {
              e.response!.data = {"errors": "Access Denied"};
              e.response!.statusCode = 403;
              return handler.resolve(e.response!);
            }
            return handler.next(e);
          }
          return handler.next(e);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return await _dio!.get(url, queryParameters: params);
  }

  Future<Response> getApi(context, String url,
      {Map<String, dynamic>? params}) async {
    //this.context = context;
    return await _dio!.get(url, queryParameters: params);
  }

  Future<Response> post(String url, data) async {
    return await _dio!.post(url, data: data);
  }

  Future<Response> delete(String url, {dynamic data}) async {
    return await _dio!.delete(url, data: data);
  }

  Future<Response> patch(String url, data) async {
    return await _dio!.patch(url, data: data);
  }

  Future<Response> postMultipart(String url, dynamic data,
      {bool isContentTypeJson = false}) async {
    if (!isContentTypeJson) {
      _dio!.options.headers["Content-Type"] = "multipart/form-data";
    }

    //_dio!.options.headers["Content-Type"] = "multipart/form-data";
    var res = await _dio!.post(url, data: data);
    _dio!.options.headers = await getHeader();
    return res;
  }

  Future<Response> patchMultipart(String url, dynamic data,
      {bool isContentTypeJson = false}) async {
    if (!isContentTypeJson) {
      _dio!.options.headers["Content-Type"] = "multipart/form-data";
    }
    //_dio!.options.headers["Content-Type"] = "multipart/form-data";
    var res = await _dio!.patch(url, data: data);
    _dio!.options.headers = await getHeader();
    return res;
  }

  static refreshToken() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    Response response;
    var dio = Dio();
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    var refreshtoken = prefs!.getString('refreshToken');
    Map<String, dynamic> body = {'token': refreshtoken, 'is_mobile': true};
    try {
      response = await dio.post("", data: body);
      if (response.statusCode == 200) {
        var data = response.data;
        if (data["status"].toString() == "true") {
          prefs!.setString('accessToken', data["accessToken"].toString());
          if (data.toString().contains("refreshToken")) {
            prefs!.setString('refreshToken', data["refreshToken"].toString());
            return true;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

// Add other methods like put, delete, etc. as needed
}
