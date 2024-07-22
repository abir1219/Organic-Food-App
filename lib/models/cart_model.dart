class CartModel {
  List<CartResult>? result;

  CartModel({this.result});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <CartResult>[];
      json['result'].forEach((v) {
        result!.add(CartResult.fromJson(v));
      });
    }
  }
}

class CartResult {
  String? sId;
  String? name;
  String? description;
  List<String>? imageUrl;
  String? key;
  String? value;
  String? pricePerUnit;
  int? inStock;
  int? cartQuantity;

  CartResult(
      {this.sId,
        this.name,
        this.description,
        this.imageUrl,
        this.key,
        this.value,
        this.pricePerUnit,
        this.inStock,
        this.cartQuantity});

  CartResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'].cast<String>();
    key = json['key'];
    value = json['value'];
    pricePerUnit = json['pricePerUnit'];
    inStock = json['inStock'];
    cartQuantity = json['cartQuantity'];
  }
}
