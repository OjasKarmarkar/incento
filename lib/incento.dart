library incento;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:incento/common_response.dart';
import 'package:incento/data_source.dart';

class IncentoSDK {
  static const EVENT_VERIFY_SUCCESS = 'verify.success';
  static const EVENT_VERIFY_ERROR = 'verify.error';
  static const EVENT_REDEEM_SUCCESS = 'redeem.success';
  static const EVENT_REDEEM_ERROR = 'redeem.error';
  String _userCountry = 'NA';

  void getCountry() async {
    Response data = await http.get(Uri.parse('http://ip-api.com/json'));
    Map d = jsonDecode(data.body);
    _userCountry = d['country'];
  }

  IncentoSDK() {
    getCountry();
  }

  Future<Map<String, dynamic>> verify(Map<String, dynamic> options) async {
    options['country'] = _userCountry;
    print(options);
    Map<String, dynamic> res = {};
    await DataSource.verifyCoupon(
      options,
      successCompletion: (CommonResponse cp) {
        res['status'] = EVENT_VERIFY_SUCCESS;
        res['message'] = cp.message ?? "";

        if (cp.data != null && cp.data != {}) {
          if (res['type'] == "percent") {
            res['amt'] = options['amt'] - options['amt'] * cp.data['discount'];
          } else {
            res['amt'] = options['amt'] - cp.data['discount'];
          }
        }

        print(res);
      },
      errCompletion: (CommonResponse cp) {
        res['status'] = EVENT_VERIFY_ERROR;
        res['message'] = cp.message ?? "";
        res['amt'] = options['amt'];
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> redeem(Map<String, dynamic> options) async {
    Map<String, dynamic> res = {};
    await DataSource.redeemCoupon(
      options,
      successCompletion: (CommonResponse cp) {
        res['status'] = EVENT_REDEEM_SUCCESS;
      },
      errCompletion: (CommonResponse cp) {
        res['status'] = EVENT_REDEEM_ERROR;
      },
    );
    return res;
  }
}
