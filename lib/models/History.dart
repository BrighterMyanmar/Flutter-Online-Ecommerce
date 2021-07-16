class History {
  bool? status;
  int? count, total;
  String? created;
  List<Item>? items;

  History({this.status, this.count, this.total, this.created, this.items});

  factory History.fromJson(dynamic data) {
    var iList = data['items'] as List;
    var itemList = iList.map((e) => Item.fromJson(e)).toList();
    return History(
      items: itemList,
      status: data['status'],
      count: data['count'],
      total: data['total'],
      created: data['created'],
    );
  }
}

class Item {
  List<dynamic>? images;
  int? count, price;
  String? name;

  Item({this.images, this.count, this.price, this.name});

  factory Item.fromJson(dynamic data) {
    List<dynamic> imgs = data['images'] as List;
    return Item(
        images: imgs,
        count: data["count"],
        price: data["price"],
        name: data["name"]);
  }
}
