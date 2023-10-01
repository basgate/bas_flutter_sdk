import 'dart:convert';

class SDKConfig {

  String? locale;
  SDKConfig({ this.locale});

  SDKConfig.fromJson(Map<String, dynamic> json) {
    locale = json['locale']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locale'] = locale;
    return data;
  }

  static SDKConfig fromString(String text) =>
      SDKConfig.fromJson(json.decode(text));

  @override
  String toString()=>json.encode(toJson());
}
