class ProductsModel {
  List<Result>? result;

  ProductsModel({this.result});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }
}

class Result {
  String? sId;
  Productvariant? productvariant;
  String? inventoryId;
  int? quantity;

  Result({this.sId, this.productvariant, this.inventoryId, this.quantity});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productvariant = json['productvariant'] != null
        ? new Productvariant.fromJson(json['productvariant'])
        : null;
    inventoryId = json['inventoryId'];
    quantity = json['quantity'];
  }
}

class Productvariant {
  String? sId;
  String? productId;
  String? key;
  String? value;
  String? price;
  int? iV;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Productvariant(
      {this.sId,
        this.productId,
        this.key,
        this.value,
        this.price,
        this.iV,
        this.createdAt,
        this.updatedAt,
        this.product});

  Productvariant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'];
    key = json['key'];
    value = json['value'];
    price = json['price'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class Product {
  String? sId;
  String? name;
  String? description;
  List<String>? imageUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
        this.name,
        this.description,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
