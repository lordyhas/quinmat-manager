

library data.model;

import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
//import 'package:latlong2/latlong.dart' as geo;

part 'item_data.dart';
part 'product.dart';


enum RentalSpaceType{apartment, house, bureau, reception, hall, unknown}

// ignore: constant_identifier_names
enum ProductType{QCL,MOB,MED,PAP, unknown}
extension ProductTypeHelper on ProductType {
  String get name {
    switch(this){
      case ProductType.QCL: return "Electronique";
      case ProductType.MOB: return "Alimentaire";
      case ProductType.MED: return "Cosmetique";
      case ProductType.PAP: return "Papeterie";
      case ProductType.unknown: return "";

    }
  }
}
/*abstract class RentalSpaceType{
  static const apartment = 0;
  static const house = 1;
  static const bureau = 2;
  static const reception = 3;
  static const hall = 4;
  static const unknown = 1;
}*/

// ignore: constant_identifier_names
enum PriceCurrency{USD, CDF}

extension PriceCurrencyHelper on PriceCurrency {
  String get name {
    switch(this){
      case PriceCurrency.USD: return "USD";
      case PriceCurrency.CDF: return "CDF";

    }
  }
}

class Bill{
  final int productId;
  final int customerId;
  final int quantity;
  final String? phone;
  final String? regno;


  const Bill({
    required this.productId,
    this.customerId = 1,
    this.quantity = 0,
    this.phone = "",
    this.regno = "",
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          customerId == other.customerId &&
          quantity == other.quantity &&
          phone == other.phone &&
          regno == other.regno);

  @override
  int get hashCode =>
      productId.hashCode ^
      customerId.hashCode ^
      quantity.hashCode ^
      phone.hashCode ^
      regno.hashCode;

  @override
  String toString() {
    return 'Sale{ '
        'productId: $productId, '
        'customerId: $customerId, '
        'quantity: $quantity, '
        'phone: $phone, '
        'regno: $regno,}';
  }

  Bill copyWith({
    int? productId,
    int? customerId,
    int? quantity,
    String? phone,
    String? regno,
  }) {
    return Bill(
      productId: productId ?? this.productId,
      customerId: customerId ?? this.customerId,
      quantity: quantity ?? this.quantity,
      phone: phone ?? this.phone,
      regno: regno ?? this.regno,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId.toString(),
      'customer_id': customerId.toString(),
      'quantity': quantity.toString(),
      'phone': phone ?? "",
      'reg_no': regno ?? "",
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      productId: map['product_id'] as int,
      customerId: map['customer_id'] as int,
      quantity: map['quantity'] as int,
      phone: map['phone'] as String,
      regno: map['reg_no'] as String,
    );
  }


}


class AddressData {
  final String avenue;
  final String? town;
  final String zone;
  final int number;
  final String commune;

  AddressData({
    required this.avenue,
    required this.zone,
    required this.number,
    required this.commune,
    this.town,
  });


  Map<String,dynamic> asMap() => {
    'avenue': avenue,
    'town': town,
    'zone': zone,
    'number': number,
    'commune': commune,
  };

  factory AddressData.fromMap(Map<String,dynamic> map) => AddressData(
    avenue: map['avenue'],
    zone: map['zone'],
    number:map['number'],
    commune: map['commune'],
    town: map['town'],
  );

  Map<String, dynamic> toMap() {
    return asMap();
  }
  @override
  String toString() => "$number, $avenue, ${town ?? commune}";

}

class Ratings {
  final dynamic id;
  final int score;
  final String message;
  final String userCode;
  final String shopCode;
  final DateTime timeMessage;
  final DateTime? timeShopMessage;
  final String? shopMessage;

  const Ratings({
    required this.score,
    required this.message,
    required this.userCode,
    required this.shopCode,
    required this.timeMessage,
    this.id,
    this.timeShopMessage,
    this.shopMessage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'message': message,
      'userCode': userCode,
      'shopCode': shopCode,
      'timeMessage': timeMessage,
      'timeShopMessage': timeShopMessage,
      'shopMessage': shopMessage,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      id: map['id'] as dynamic,
      score: map['score'] as int,
      message: map['message'] as String,
      userCode: map['userCode'] as String,
      shopCode: map['shopCode'] as String,
      timeMessage: map['timeMessage'] as DateTime,
      timeShopMessage: map['timeShopMessage'] as DateTime,
      shopMessage: map['shopMessage'] as String,
    );
  }
}

class ImageLinkStorage {
  final dynamic id;
  final String? primaryPath;
  final List<String> paths;

  const ImageLinkStorage({
    this.id,
    this.primaryPath,
    this.paths = const <String>[],
  });

  List<String?> toList() => [primaryPath, ...paths];

}



extension DateTimeHelper on DateTime {
  static DateTime datePlan(
      {required int day, required int hour, required int minute}) {
    var d = DateTime.now();
    return DateTime(
      d.year,
      d.month,
      day,
      hour,
      minute,
    );
  }
}


