import 'common_response.dart';
import 'networking.dart';

class DataSource {
  static DataSource instance = DataSource();
  static CommonResponse cp = CommonResponse();

  static String verifyAPI = "Scoupon/verify/";
  static String getAllCouponsAPI = "Scoupon/getAllStatic";
  static String redeemAPI = "Scoupon/redeem/";

  static Future<CommonResponse> verifyCoupon(Map<String, dynamic> options,
      {required void Function(CommonResponse) successCompletion,
      required void Function(CommonResponse) errCompletion}) {
    return BaseNetwork.post(
        verifyAPI, options, successCompletion, errCompletion, false, null);
  }

  static Future<CommonResponse> getAllCoupons(String key,
      {required void Function(CommonResponse) successCompletion,
      required void Function(CommonResponse) errCompletion}) {

    return BaseNetwork.get(getAllCouponsAPI + '?company_name=$key', null,
        successCompletion, errCompletion);
  }

  static Future<CommonResponse> redeemCoupon(Map<String, dynamic> options,
      {required void Function(CommonResponse) successCompletion,
      required void Function(CommonResponse) errCompletion}) {
    return BaseNetwork.post(
        redeemAPI, options, successCompletion, errCompletion, false, null);
  }
}
