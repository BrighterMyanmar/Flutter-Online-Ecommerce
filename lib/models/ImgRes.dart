class ImgRes {
  String? id, name, originalname, mimetype, link, created;
  int? size;

  ImgRes(
      {this.id,
      this.name,
      this.originalname,
      this.mimetype,
      this.link,
      this.created,
      this.size});

  factory ImgRes.fromJson(dynamic data) {
    return ImgRes(
      id: data["_id"],
      name: data["name"],
      originalname: data["originalname"],
      mimetype: data["mimetype"],
      link: data["link"],
      size: data["size"],
    );
  }
}
