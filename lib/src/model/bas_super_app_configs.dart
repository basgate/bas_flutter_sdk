import 'dart:convert';
import 'bas_mode.dart';



class BasSuperAppConfigs {
  int? status;
  String? locale;
  bool? isInBasSuperApp;
  List<String>? messages;
  BasMode? envType;

  BasSuperAppConfigs({
    this.status,
    this.messages,
    this.locale,
    this.isInBasSuperApp = false,
    this.envType = BasMode.live,
  });

  static BasSuperAppConfigs fromString(String text) =>
      BasSuperAppConfigs.fromJson(json.decode(text));

  @override
  String toString() => json.encode(toJson());

  factory BasSuperAppConfigs.fromJson(Map<String, dynamic> json) {
    return BasSuperAppConfigs(
      status: int.tryParse(json['status'].toString()) ?? 0,
      locale: json['locale']?.toString(),
      isInBasSuperApp: json['isInBasSuperApp'] ?? false,
      messages: json['messages']?.map<String>((e) => e.toString())?.toList(),
      envType: BasMode.values.firstWhere(
        (e) => e.name == json['envType'],
        orElse: () => BasMode.live,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'locale': locale,
      'isInBasSuperApp': isInBasSuperApp ?? false,
      'messages': messages,
      'envType': envType?.name,
    };
  }
}
