class PaymentPendingModel {
  String name;
  String pending;
  String date;
  String pending160;
  String id;

  PaymentPendingModel(
      {required this.name,
      required this.pending,
      required this.pending160,
      required this.date,required this.id});

  factory PaymentPendingModel.fromJson(Map<String, dynamic> json,String docId) {
    return PaymentPendingModel(
      id: docId,
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
