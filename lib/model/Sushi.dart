class Sushi {
  String? name;
  String? description;
  int? price;
  String? imgPath;
  double? rating;

  Sushi({this.name, this.description, this.price, this.imgPath, this.rating});

  Sushi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imgPath = json['img_path'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['img_path'] = this.imgPath;
    data['rating'] = this.rating;
    return data;
  }
}
