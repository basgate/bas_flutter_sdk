import 'dart:convert';

class AuthCode {
  static AuthCode fromString(String text) =>
      AuthCode.fromJson(json.decode(text));

  int? status;
  AuthCodeData? data;
  List<String>? messages;

  AuthCode({this.status, this.data, this.messages});

  factory AuthCode.fromJson(Map<String, dynamic> json) {
    return AuthCode(
      status: int.tryParse(json['status'].toString()) ?? 0,
      messages: json['messages']?.map<String>((e) => e.toString())?.toList(),
      data: json['data'] == null ? null : AuthCodeData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data?.toJson();
    data['messages'] = messages;
    return data;
  }

  @override
  String toString() => json.encode(toJson());
}

class AuthCodeData {
  static AuthCodeData fromString(String text) =>
      AuthCodeData.fromJson(json.decode(text));

  String? authId;
  String? openId;

  AuthCodeData({this.authId, this.openId});

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
  String toString() => json.encode(toJson());
}
