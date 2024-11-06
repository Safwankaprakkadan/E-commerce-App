
class Product {
  int? id;
  int? partsCat;
  String? partimage;
  int? vbrand;
  int? vcategory;
  String? price;
  String? partsname;
  String? description;
  String? offerprice;
  bool? isoffer;
  String? productrating;

  Product({
    this.id,
    this.partsCat,
    this.partimage,
    this.vbrand,
    this.vcategory,
    this.price,
    this.partsname,
    this.description,
    this.offerprice,
    this.isoffer,
    this.productrating,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partsCat = json['parts_Cat'];
    partimage = json['part_image'];
    vbrand = json['v_brand'];
    vcategory = json['v_category'];
    price = json['price'];
    partsname = json['parts_name'] ?? '';
    description = json['description'];
    offerprice = json['offer_price'];
    isoffer = json['is_offer'];
    productrating = json['product_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = id;
    data['parts_Cat'] = partsCat;
    data['part_image'] = partimage;
    data['v_brand'] = vbrand;
    data['v_category'] = vcategory;
    data['price'] = price;
    data['parts_name'] = partsname ?? '';
    data['description'] = description;
    data['offer_price'] = offerprice;
    data['is_offer'] = isoffer;
    data['product_rating'] = productrating;
    return data;
  }

  static List<Product> listFromJson(List<dynamic> list) {
    List<Product> rows = list.map((i) => Product.fromJson(i)).toList();
    return rows;
  }
}

class Category {
  int? id;
  String? cat_name;

  Category({
    this.id,
    this.cat_name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cat_name = json['Cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = id;
    data['Cat_name'] = cat_name;
    return data;
  }

  static List<Category> listFromJson(List<dynamic> list) {
    List<Category> rows = list.map((i) => Category.fromJson(i)).toList();
    return rows;
  }
}
