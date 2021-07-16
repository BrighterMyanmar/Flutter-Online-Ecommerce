class Product {
  List<dynamic>? images, features, imgcolors, colors;
  int? discount, price;
  int count = 1;
  bool? status;
  String? id,
      name,
      brand,
      category,
      subcat,
      childcat,
      tag,
      desc,
      detail,
      delivery,
      warranty,
      size;

  Product(
      {this.images,
      this.features,
      this.imgcolors,
      this.colors,
      this.discount,
      this.price,
      this.status,
      this.id,
      this.name,
      this.brand,
      this.category,
      this.subcat,
      this.childcat,
      this.tag,
      this.desc,
      this.detail,
      this.delivery,
      this.warranty,
      this.size});

  factory Product.fromJson(dynamic data) {
    List<dynamic> images = data["images"] as List;
    List<dynamic> features = data["features"] as List;
    List<dynamic> imgcolors = data["imgcolors"] as List;
    List<dynamic> colors = data["colors"] as List;
    return Product(
      images: images,
      features: features,
      imgcolors: imgcolors,
      colors: colors,
      discount: data["discount"],
      price: data["price"],
      status: data["status"],
      id: data["_id"],
      name: data["name"],
      brand: data["brand"],
      category: data["category"],
      subcat: data["subcat"],
      childcat: data["childcat"],
      tag: data["tag"],
      desc: data["desc"],
      detail: data["detail"],
      delivery: data["delivery"],
      warranty: data["warranty"],
      size: data["size"],
    );
  }
}
