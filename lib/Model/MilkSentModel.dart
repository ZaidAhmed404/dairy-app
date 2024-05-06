class MilkSentModel {
  String id;
  String date;
  String fat;
  String milk;
  String milk_5;
  String name;
  String pending;
  String pending160;
  String rate;

  MilkSentModel(
      {required this.id,
      required this.date,
      required this.fat,
      required this.milk,
      required this.name,
      required this.pending,
      required this.pending160,
      required this.rate,
      required this.milk_5});

  factory MilkSentModel.fromMap(Map<String, dynamic> map, String docId) {
    return MilkSentModel(
      id: docId,
      date: map['date'].toString(),
      fat: map['fat'].toString(),
      milk: map['milk'].toString(),
      milk_5: map['milk_5'].toString(),
      name: map['name'].toString(),
      pending: map['pending'].toString(),
      pending160: map['pending_160'].toString(),
      rate: map['rate'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'fat': fat.toString(),
      'milk': milk.toString(),
      'name': name,
      "milk_5": milk_5,
      'pending': pending.toString(),
      'pending_160': pending160.toString(),
      'rate': rate,
    };
  }
}
