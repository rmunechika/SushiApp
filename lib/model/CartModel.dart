class CartModel {
  String? name;
  String? price;
  String? imgPath;
  String? quantity;

  CartModel({this.name, this.price, this.imgPath, this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    imgPath = json['imgPath'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['imgPath'] = this.imgPath;
    data['quantity'] = this.quantity;
    return data;
  }
}
