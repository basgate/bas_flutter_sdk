import 'dart:convert';

class LunchUrl {
  static LunchUrl fromString(String text) =>
      LunchUrl.fromJson(json.decode(text));

  int? status;

  List<String>? messages;

  LunchUrl({this.status, this.messages});

  LunchUrl.fromJson(Map<String, dynamic> json) {
    status = int.tryParse(json['status'].toString());
    messages = json['messages']?.map<String>((e) => e.toString())?.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    return data;
  }

  @override
  String toString() => json.encode(toJson());
}
