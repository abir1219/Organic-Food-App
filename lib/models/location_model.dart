class LocationModel {
  List<LocationResult>? result;

  LocationModel({this.result});

  LocationModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <LocationResult>[];
      json['result'].forEach((v) {
        result!.add(new LocationResult.fromJson(v));
      });
    }
  }
}

class LocationResult {
  String? sId;
  String? name;
  String? state;
  String? city;
  String? address;
  String? pincode;
  Null? lat;
  Null? lng;
  String? createdAt;
  String? updatEdAt;
  int? iV;
  String? updatedAt;

  LocationResult(
      {this.sId,
        this.name,
        this.state,
        this.city,
        this.address,
        this.pincode,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatEdAt,
        this.iV,
        this.updatedAt});

  LocationResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    pincode = json['pincode'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
    updatEdAt = json['updat¯edAt'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }
}
