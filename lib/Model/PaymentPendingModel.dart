class PaymentPendingModel {
  String name;
  String pending;
  String date;
  String pending160;

  PaymentPendingModel(
      {required this.name,
      required this.pending,
      required this.pending160,
      required this.date});

  factory PaymentPendingModel.fromJson(Map<String, dynamic> json) {
    return PaymentPendingModel(
        name: json['name'] ?? "",
        pending: json['pending'].toString() ?? "",
        date: json['date'] ?? "",
        pending160: json['pending_160'].toString() ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pending': pending,
      'pending_160': pending160,
      'date': date
    };
  }
}
