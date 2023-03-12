import 'dart:convert';

class CommonResponse<T> {
  bool? success;
  String? message;
  T? data;
  List<T>? listData;
  int? errCode;

  // Meta meta;

  CommonResponse(
      {this.success, this.message, this.data, this.listData, this.errCode
      /*this.meta*/
      });

  CommonResponse.fromEncString(String encData) {
    Map<String, dynamic> json = jsonDecode(encData);
    if (json['status'] == false) {
      message = json['error_msg'].toString();
      errCode = json['error_code'];
    }

    // // debugPrint(json.toString() , wrapWidth: 1024);
    success = json['status'];
    data = json['data'];

    // try {
    //   errors = json['errors'];
    //   if (json.containsKey("errors") && json["errors"] != null) {
    //         errors = Errors.fromJson(json['errors']);
    //       }
    // } catch (e) {
    //   print(e);
    // }
    //
    // if (json.containsKey("meta") && json["meta"] != null) {
    //   meta = Meta.fromJson(json['meta']);
    // }
  }

  CommonResponse.fromJson(Map<String, dynamic> json) {
    //json = decryptData(json);
    success = json['status'];
    message = json['message'];
    data = json['data'];

    // try {
    //   errors = json['errors'];
    //   if (json.containsKey("errors") && json["errors"] != null) {
    //         errors = Errors.fromJson(json['errors']);
    //       }
    // } catch (e) {
    //   print(e);
    // }
    //
    // if (json.containsKey("meta") && json["meta"] != null) {
    //   meta = Meta.fromJson(json['meta']);
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['response'] = this.data;

    // try {
    // } catch (e) {
    //   print(e);
    // }
    // if (this.meta != null) {
    //   data['meta'] = this.meta.toJson();
    // }
    return data;
  }
}
