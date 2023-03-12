import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:incento_demo/Models/common_response.dart';

class BaseNetwork {
  static const String baseUrl = "https://incento-app-backend.up.railway.app/api";

  static Future<CommonResponse> get(
      String partUrl,
      String? token,
      void Function(CommonResponse) successCompletion,
      void Function(CommonResponse) errCompletion) async {
    late CommonResponse commonResponse;

    Map<String, dynamic> h = {};
    if (token != null) {
      h["Authorization"] = "Token $token";
    }

    Dio dio = initDio(partUrl, false);
    await dio
        .get(
      '',
      options: token != null
          ? Options(contentType: Headers.formUrlEncodedContentType, headers: h)
          : Options(contentType: Headers.formUrlEncodedContentType),
    )
        .then((response) {
      if (response.data != null) {
        debugPrint("res ==== " + response.data.toString());
        commonResponse = CommonResponse.fromJson(response.data);
        if (commonResponse.success!) {
          successCompletion(commonResponse);
        } else {
          errCompletion(commonResponse);
        }
      }
    }).catchError((e) {
      if (e is DioError) {
        print(e.response);
        commonResponse = CommonResponse.fromJson(e.response?.data);
        debugPrint("err ==== ${e.response}");
        errCompletion(commonResponse);
      }
    });

    return commonResponse;
  }

  static Future<CommonResponse> post(
      String partUrl,
      dynamic body,
      void Function(CommonResponse) successCompletion,
      void Function(CommonResponse) errCompletion,
      bool isMultipart,
      String? token) async {
    late CommonResponse commonResponse;
    Dio dio = initDio(partUrl, false);
    await dio
        .post("",
            options: token != null
                ? Options(
                    contentType: Headers.jsonContentType,
                    headers: {"Authorization": "Token $token"})
                : Options(contentType: Headers.jsonContentType),
            data: body)
        .then((response) {
      debugPrint("res ==== " + response.toString());
      commonResponse = CommonResponse.fromJson(response.data);

      if (commonResponse.success!) {
        successCompletion(commonResponse);
      } else {
        errCompletion(commonResponse);
      }
    }).catchError((e) {
      if (e is DioError) {
        print(e.response?.statusCode);
        commonResponse = CommonResponse.fromJson(e.response?.data);
        debugPrint("err ==== ${e.response}");
        errCompletion(commonResponse);
      }
    });
    return commonResponse;
  }

  // static Future<CommonResponse> delete(
  //     String partUrl,
  //     void Function(CommonResponse) successCompletion,
  //     void Function(CommonResponse) errCompletion,
  //     bool isMultipart) async {
  //   CommonResponse commonResponse;
  //   Dio dio = initDio(partUrl, false);

  //   await dio.delete("", options: Options()).then((response) {
  //     debugPrint("res ==== " + response.toString());
  //     commonResponse = CommonResponse.fromJson(response.data);

  //     if (commonResponse.success) {
  //       if (successCompletion != null) successCompletion(commonResponse);
  //     } else {
  //       if (errCompletion != null) errCompletion(commonResponse);
  //     }
  //     // if (!partUrl.contains("addUserActivity")) Utils.showSuccessToast(commonResponse.message);
  //   }).catchError((e) {
  //     debugPrint("err ==== ");

  //     if (e != null && e.response != null) {
  //       commonResponse = CommonResponse.fromJson(e.response.data);

  //       if (errCompletion != null) errCompletion(commonResponse);
  //     }
  //   });
  //   return commonResponse;
  // }

    static Future<CommonResponse> put(
      String partUrl,
      dynamic body,
      void Function(CommonResponse) successCompletion,
      void Function(CommonResponse) errCompletion,
      bool isMultipart,
      String? token) async {
    late CommonResponse commonResponse;
    Dio dio = initDio(partUrl, false);
    await dio
        .put("",
            options: token != null
                ? Options(
                    contentType: Headers.jsonContentType,
                    headers: {"Authorization": "Token $token"})
                : Options(contentType: Headers.jsonContentType),
            data: body)
        .then((response) {
      debugPrint("res ==== " + response.toString());
      commonResponse = CommonResponse.fromJson(response.data);

      if (commonResponse.success!) {
        successCompletion(commonResponse);
      } else {
        errCompletion(commonResponse);
      }
    }).catchError((e) {
      if (e is DioError) {
        print(e.response?.statusCode);
        commonResponse = CommonResponse.fromJson(e.response?.data);
        debugPrint("err ==== ${e.response}");
        errCompletion(commonResponse);
      }
    });
    return commonResponse;
  }

  static Dio initDio(String partUrl, bool isMultipart) {
    var dio = Dio();
    Map<String, String> headers;
    String acceptHeader;
    String contentTypeHeader;
    // dio.interceptors.add(InterceptorsWrapper(onError: (DioError error , handler) async {
    //   if (error.response?.statusCode == 403 ||
    //       error.response?.statusCode == 401) {
    //     print("handle un");
    //     await refreshToken();
    //     return _retry(error.requestOptions);
    //   }
    //   return error.response;
    // }));

    acceptHeader = 'application/json';
    contentTypeHeader =
        isMultipart ? 'multipart/form-data' : 'application/json';

    headers = {
      HttpHeaders.acceptHeader: acceptHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader,
    };
    final fullUrl = baseUrl + "/" + partUrl;
    //debugPrint(fullUrl);
    // debugPrint(Injector.prefs.getString(PrefKeys.token));
    BaseOptions options = BaseOptions(
        baseUrl: fullUrl,
        connectTimeout: 20000,
        receiveTimeout: 3000,
        headers: headers);

    dio.options = options;

    return dio;
  }
}