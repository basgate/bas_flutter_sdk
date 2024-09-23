class DataToPayment {
  String? appId;
  String? orderId;
  String? trxId;
  Amount? amount;
  String? paymentType;
  String? date;
  String? status;

  DataToPayment({
    this.appId,
    this.orderId,
    this.trxId,
    this.amount,
    this.paymentType,
    this.date,
    this.status,
  });

  static DataToPayment get failed => DataToPayment.fromJson({
        "appId": "ac90ddd1-6627-4ae9-b268-98c17bd8ee6c",
        "orderId": "507c54a0-361e-4b23-9307-76ba62563ab9",
        "trxId": "ab9cbca6-219d-43bc-ae0f-689b21da46d7",
        "amount": {"value": "1300", "currency": "YER"},
        "paymentType": "BillPay",
        "date": "9/19/2024 8:25:54 PM",
        "status": "",
      });

  static DataToPayment get success => DataToPayment.fromJson({
        "appId": "9793b01c-8b4a-4513-9cc9-5f384b253cb3",
        "orderId": "507c54a0-361e-4b23-9307-76ba62563ab9",
        "trxId": "ab9cbca6-219d-43bc-ae0f-689b21da46d7",
        "amount": {"value": "1300", "currency": "YER"},
        "paymentType": "BillPay",
        "date": "9/19/2024 8:25:54 PM",
        "status": "",
      });

  factory DataToPayment.fromJson(Map<String, dynamic> json) => DataToPayment(
        appId: json["appId"],
        orderId: json["orderId"],
        trxId: json["trxId"],
        amount: json["amount"] == null ? null : Amount.fromJson(json["amount"]),
        paymentType: json["paymentType"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "appId": appId,
        "orderId": orderId,
        "trxId": trxId,
        "amount": amount?.toJson(),
        "paymentType": paymentType,
        "date": date,
        "status": status,
      };
}

class Amount {
  String? value;
  String? currency;

  Amount({
    this.value,
    this.currency,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        value: json["value"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
      };
}
