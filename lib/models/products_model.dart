class ProductModel {
  String? image;
  String? name;
  String? price;
  String? category;
  String? serial;
  String? discount;
  String? stock;
  String? description;
  String? rating;
  String? brand;

  ProductModel(
      {
      this.image,
      this.name,
      this.category,
      this.price,
      this.serial,
      this.discount,
      this.description,
      this.rating,
      this.stock,
      this.brand
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    serial = json['serial'];
    discount = json['discount'];
    stock = json['stock'];
    rating = json['rating'];
    description = json['description'];
    brand = json['brand'];
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'category': category,
      'price': price,
      'serial': serial,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'description': description,
      'brand': brand,
    };
  }
}
