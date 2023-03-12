import 'package:incento_demo/Models/common_response.dart';
import 'networking.dart';

class DataSource {
  static DataSource instance = DataSource();
  static CommonResponse cp = CommonResponse();

  static String productsAPI = "Products/";
    static String loginAPI = "auth/login";

  static Future<CommonResponse> getProducts(
      {required void Function(CommonResponse) successCompletion,
      required void Function(CommonResponse) errCompletion}) {
    return BaseNetwork.get(
        productsAPI, null , successCompletion, errCompletion);
  }

    static Future<CommonResponse> login(Map<String, dynamic> body,
      {required void Function(CommonResponse) successCompletion,
      required void Function(CommonResponse) errCompletion}) {
    return BaseNetwork.post(
        loginAPI, body, successCompletion, errCompletion, false, null);
  }
}
