class MilkReceivedModel {
  String id;
  String name;
  String price;
  String totalMilk5;
  String totalMilk6;
  String price5;
  String price6;
  String totalPrice5;
  String totalPrice6;
  String totalMilk;
  String date;

  MilkReceivedModel(
      {required this.id,required this.name,
      required this.price,
      required this.totalMilk5,
      required this.totalMilk6,
      required this.price5,
      required this.price6,
      required this.date,
      required this.totalMilk,required this.totalPrice5,required this.totalPrice6});

  factory MilkReceivedModel.fromMap(Map<String, dynamic> map,String docId) {
    return MilkReceivedModel(
      id: docId,
      name: map['name'].toString() ?? '',
      price: map['price'] ?? '',
      totalMilk5: map['total_5'].toStringAsFixed(2) ?? '',
      totalMilk6: map['total_6'].toStringAsFixed(2) ?? '',
      price5: map['price_5'].toStringAsFixed(2) ?? '',
      price6: map['price_6'].toStringAsFixed(2) ?? '',
      date: map['date'].toString() ?? '',
      totalMilk: map['totalMilk'].toString() ?? '',
      totalPrice5: map['total_price_5'].toString()??"",
      totalPrice6: map['total_price_6'].toString()??""
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'totalMilk5': totalMilk5,
      'totalMilk6': totalMilk6,
      'price5': price5,
      'price6': price6,
      "totalMilk": totalMilk,
      "totalPrice6":totalPrice6,
      "totalPrice5":totalPrice5
    };
  }
}
