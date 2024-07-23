class OrderHistoryModel {
  List<OrderHistoryResult>? result;

  OrderHistoryModel({this.result});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <OrderHistoryResult>[];
      json['result'].forEach((v) {
        result!.add(OrderHistoryResult.fromJson(v));
      });
    }
  }
}

class OrderHistoryResult {
  String? sId;
  String? orderNumber;
  int? totalAmount;
  int? totalItems;
  String? paymentType;
  String? paymentStatus;
  String? orderStatus;
  Address? address;
  List<OrderItems>? orderItems;

  OrderHistoryResult(
      {this.sId,
      this.orderNumber,
      this.totalAmount,
      this.totalItems,
      this.paymentType,
      this.paymentStatus,
      this.orderStatus,
      this.address,
      this.orderItems});

  OrderHistoryResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderNumber = json['orderNumber'];
    totalAmount = json['totalAmount'];
    totalItems = json['totalItems'];
    paymentType = json['paymentType'];
    paymentStatus = json['paymentStatus'];
    orderStatus = json['orderStatus'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }
}

class Address {
  String? sId;
  String? customerId;
  String? city;
  String? state;
  String? address;
  String? pincode;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Address(
      {this.sId,
      this.customerId,
      this.city,
      this.state,
      this.address,
      this.pincode,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    pincode = json['pincode'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class OrderItems {
  String? sId;
  String? customerId;
  String? orderId;
  String? productId;
  String? warehouseId;
  String? productName;
  String? productDescription;
  List<String>? imageUrl;
  String? key;
  String? value;
  String? pricePerUnit;
  int? quantity;
  int? totalPrice;
  int? iV;
  String? createdAt;
  String? updatedAt;
  WarehouseDetails? warehouseDetails;

  OrderItems(
      {this.sId,
      this.customerId,
      this.orderId,
      this.productId,
      this.warehouseId,
      this.productName,
      this.productDescription,
      this.imageUrl,
      this.key,
      this.value,
      this.pricePerUnit,
      this.quantity,
      this.totalPrice,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.warehouseDetails});

  OrderItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    orderId = json['orderId'];
    productId = json['productId'];
    warehouseId = json['warehouseId'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    imageUrl = json['imageUrl'].cast<String>();
    key = json['key'];
    value = json['value'];
    pricePerUnit = json['pricePerUnit'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    warehouseDetails = json['warehouseDetails'] != null
        ? WarehouseDetails.fromJson(json['warehouseDetails'])
        : null;
  }
}

class WarehouseDetails {
  String? sId;
  String? name;
  String? state;
  String? city;
  String? address;
  String? pincode;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  int? iV;

  WarehouseDetails(
      {this.sId,
      this.name,
      this.state,
      this.city,
      this.address,
      this.pincode,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.iV});

  WarehouseDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    pincode = json['pincode'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
