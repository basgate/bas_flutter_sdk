import 'dart:convert';

class Transaction {

  int? status;
  TransactionData? data;
  List<String>? messages;
  Transaction({ this.status, this.data, this.messages});

  Transaction.fromJson(Map<String, dynamic> json) {
    status = int.tryParse(json['status'].toString());
    data = json['data'] != null ? TransactionData.fromJson(json['data']) : null;
    messages = json['messages']?.map<String>((e) => e.toString())?.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] =  this.data?.toJson();
    data['messages'] = this.messages;
    return data;
  }

  static Transaction fromString(String text) =>
      Transaction.fromJson(json.decode(text));

  String toString()=>json.encode(toJson());
}

class TransactionData {
  late String orderId;
  late String? appId;
  late String? trxId;
  late Amount amount;
  late String? paymentType;
  late String? date;
  late String? status;

  TransactionData(
      {required this.orderId,
        required this.appId,
        required this.trxId,
        required this.amount,
        required this.paymentType,
        required this.date,
        required this.status,
      });

  static TransactionData fromString(String text) =>
      TransactionData.fromJson(json.decode(text));

  TransactionData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'].toString();
    appId = json['appId']?.toString();
    trxId = json['trxId']?.toString();
    amount = Amount.fromJson(json['amount']);
    paymentType = json['paymentType']?.toString();
    date = json['date']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['appId'] = this.appId;
    data['trxId'] = this.trxId;
    data['amount'] = this.amount.toJson();
    data['paymentType'] = this.paymentType;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }

  String toString()=>json.encode(toJson());
}

class Amount{
  Amount({this.value, this.currency});

  double? value;
  String? currency;

  factory Amount.fromString(String text) => Amount.fromJson(json.decode(text));
  static List<Amount>? fromStringAsList(String text) => json.decode(text).map<Amount>((item) => Amount.fromJson(item)).toList();
  static List<Amount> fromJsonAsList(List<dynamic> json) => json.map<Amount>((item) => Amount.fromJson(item)).toList();

  @override
  String toString() => json.encode(toJson());
  static String toListString(var list) => json.encode(toListJson(list));
  static List<dynamic>? toListJson(var list) =>list?.map((item) => item.toJson()).toList();

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
        value: _stringToDouble(json['value']),
        currency: json['currency']?.toString()
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        data[key] = value;
      }
    }
    writeNotNull('value', value);
    writeNotNull('currency', currency);
    return data;
  }

  static double? _stringToDouble(var value) =>
      value == null ? null : double.parse(value.toString());
}