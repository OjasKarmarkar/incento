class Product {
  int? id;
  String? name;
  String? imageUrl;
  int? price;
  String? title;

  Product({id, name, imageUrl, price, title});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['title'] = title;
    return data;
  }
}
