import 'dart:convert';

class AuthCode {
  static AuthCode fromString(String text) =>
      AuthCode.fromJson(json.decode(text));

  int? status;
  AuthCodeData? data;
  List<String>? messages;
  AuthCode({ this.status, this.data, this.messages});

  AuthCode.fromJson(Map<String, dynamic> json) {
    status = int.tryParse(json['status'].toString());
    data = AuthCodeData.fromJson(json['data']);
    messages = json['messages']?.map<String>((e) => e.toString())?.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] =  this.data?.toJson();
    data['messages'] = this.messages;
    return data;
  }

  String toString()=>json.encode(toJson());
}
class AuthCodeData {
  static AuthCodeData fromString(String text) =>
      AuthCodeData.fromJson(json.decode(text));

  String? authId;
  String? openId;

  AuthCodeData({this.authId,this.openId});

  AuthCodeData.fromJson(Map<String, dynamic> json) {
    authId = json['authId'].toString();
    openId = json['openId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authId'] = authId;
    data['openId'] = openId;
    return data;
  }

  @override
  String toString()=>json.encode(toJson());
}