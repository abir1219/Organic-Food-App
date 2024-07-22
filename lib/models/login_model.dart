class LoginModel {
  String? accessToken;
  Data? data;

  LoginModel({this.accessToken, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Result? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }
}

class Result {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Result(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
