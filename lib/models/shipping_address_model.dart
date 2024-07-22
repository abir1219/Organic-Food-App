class ShippingAddressModel {
  List<ShippingAddressResult>? result;

  ShippingAddressModel({this.result});

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ShippingAddressResult>[];
      json['result'].forEach((v) {
        result!.add(ShippingAddressResult.fromJson(v));
      });
    }
  }
}

class ShippingAddressResult {
  String? sId;
  String? city;
  String? state;
  String? address;
  String? pincode;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ShippingAddressResult(
      {this.sId,
        this.city,
        this.state,
        this.address,
        this.pincode,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ShippingAddressResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
