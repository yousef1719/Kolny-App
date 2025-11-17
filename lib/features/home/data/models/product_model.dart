class ProductModel {
  int id;
  String name;
  String desc;
  String image;
  String rating;
  String price;

  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      desc: json['description'],
      image: json['image'],
      rating: json['rating'],
      price: json['price'],
    );
  }
}
