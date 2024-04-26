class PaymentSentModel {
  String date;
  String name;
  String paymentSent;
  String pendingPrice5;
  String pendingPrice6;

  PaymentSentModel({
    required this.date,
    required this.name,
    required this.paymentSent,
    required this.pendingPrice5,
    required this.pendingPrice6,
  });

  factory PaymentSentModel.fromJson(Map<String, dynamic> json) {
    return PaymentSentModel(
      date: json['date'] ?? "",
      name: json['name'] ?? "",
      paymentSent: json['payment_sent'] ?? "",
      pendingPrice5: json['pending_price_5'].toStringAsFixed(2) ?? "",
      pendingPrice6: json['pending_price_6'].toStringAsFixed(2) ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'name': name,
      'payment_sent': paymentSent,
      'pending_price_5': pendingPrice5,
      'pending_price_6': pendingPrice6,
    };
  }
}
