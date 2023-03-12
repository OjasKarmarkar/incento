class Coupons {
  String? sId;
  String? companyName;
  String? creatorEmail;
  List<String>? productCategories;
  bool? expired;
  String? code;
  int? redeemCount;
  int? verifyCount;
  int? maxCount;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Coupons(
      {sId,
      companyName,
      creatorEmail,
      productCategories,
      users,
      expired,
      code,
      redeemCount,
      verifyCount,
      maxCount,
      expiresAt,
      createdAt,
      updatedAt,
      iV});

  Coupons.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyName = json['company_name'];
    creatorEmail = json['creator_email'];
    productCategories = json['product_categories'].cast<String>();
    expired = json['expired'];
    code = json['code'];
    redeemCount = json['redeem_count'];
    verifyCount = json['verify_count'];
    maxCount = json['max_count'];
    expiresAt = json['expires_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
