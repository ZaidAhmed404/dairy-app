class PaymentReceivedModel {
  String date;
  String name;
  String payment;

  PaymentReceivedModel({
    required this.date,
    required this.name,
    required this.payment,
  });

  factory PaymentReceivedModel.fromJson(Map<String, dynamic> json) {
    return PaymentReceivedModel(
      date: json['date'] ?? "",
      name: json['name'] ?? "",
      payment: json['payment'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'name': name,
      'payment': payment,
    };
  }
}
