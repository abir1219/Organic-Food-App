class ProductsModel {
  List<ProductResult>? result;

  ProductsModel({this.result});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProductResult>[];
      json['result'].forEach((v) {
        result!.add(ProductResult.fromJson(v));
      });
    }
  }
}

class ProductResult {
  String? sId;
  Productvariant? productvariant;
  String? inventoryId;
  int? quantity;

  ProductResult({this.sId, this.productvariant, this.inventoryId, this.quantity});

  ProductResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productvariant = json['productvariant'] != null
        ? Productvariant.fromJson(json['productvariant'])
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
    json['product'] != null ? Product.fromJson(json['product']) : null;
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
