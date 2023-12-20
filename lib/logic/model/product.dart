part of data.model;

class Product {
  final dynamic id;
  final String name;
  final String model;
  final String description;
  final ProductType productType;
  final dynamic employee;
  final double? promotionPrice;
  final DateTime? promotionOutdated;
  final int stockNumber;
  final int threshold;
  final List<String> images;
  final AddressData? address;
  final bool canReserve;
  final double? price;
  final double? purchasePrice;
  final bool? isTendency;
  final PriceCurrency pricePer;

  const Product({
    required this.id,
    required this.name,
    required this.model,
    required this.description,
    required this.productType,
    required this.price,
    required this.purchasePrice,
    this.promotionPrice,
    this.promotionOutdated,
    this.employee,
    this.stockNumber = 1,
    this.threshold = -1,
    this.images = const [],
    this.address,
    this.canReserve = false,
    this.isTendency,
    this.pricePer = PriceCurrency.CDF,
  });

  static const List<ProductType> categories = [
    ProductType.QCL,
    ProductType.MOB,
    ProductType.MED,
    ProductType.PAP,
  ];

  static const empty = Product(
      id: '',
      name: '',
      description: '',
      price: null,
      purchasePrice: null,
      productType: ProductType.unknown,
      model: ''
  );

  /// Convenience getter to determine whether the
  /// current [Product] is empty.
  bool get isEmpty => this == Product.empty;

  /// Convenience getter to determine whether the
  /// current [Product] is not empty.
  bool get isNotEmpty => this != Product.empty;

  bool get isComplete => isNotEmpty && images.isNotEmpty;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          model == other.model &&
          description == other.description &&
          productType == other.productType &&
          employee == other.employee &&
          promotionPrice == other.promotionPrice &&
          promotionOutdated == other.promotionOutdated &&
          stockNumber == other.stockNumber &&
          images == other.images &&
          address == other.address &&
          canReserve == other.canReserve &&
          price == other.price &&
          isTendency == other.isTendency &&
          pricePer == other.pricePer);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      model.hashCode ^
      description.hashCode ^
      productType.hashCode ^
      employee.hashCode ^
      promotionPrice.hashCode ^
      stockNumber.hashCode ^
      images.hashCode ^
      address.hashCode ^
      canReserve.hashCode ^
      price.hashCode ^
      isTendency.hashCode ^
      pricePer.hashCode;

  @override
  String toString() {
    return 'Product('
        ' id: $id,'
        ' name: $name,'
        ' model: $model,'
        ' description: $description,'
        ' productType: $productType,'
        ' employee: $employee,'
        ' promotionPrice: $promotionPrice,'
        ' promotionOutdated : $promotionOutdated'
        ' stockNumber: $stockNumber,'
        ' images: $images,'
        ' address: $address,'
        ' canReserve: $canReserve,'
        ' price: $price,'
        ' isTendency: $isTendency,'
        ' pricePer: $pricePer,'
        ')';
  }

  Product copyWith({
    dynamic id,
    String? name,
    String? model,
    String? description,
    ProductType? productType,
    int? employee,
    double? promotionPrice,
    DateTime? promotionOutdated,
    int? stockNumber,
    int? threshold,
    List<String>? images,
    AddressData? address,
    bool? canReserve,
    double? price,
    double? purchasePrice,
    bool? isTendency,
    PriceCurrency? pricePer,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      description: description ?? this.description,
      productType: productType ?? this.productType,
      employee: employee ?? this.employee,
      promotionPrice: promotionPrice ?? this.promotionPrice,
      promotionOutdated: promotionOutdated ?? this.promotionOutdated,
      stockNumber: stockNumber ?? this.stockNumber,
      threshold: threshold ?? this.threshold,
      images: images ?? this.images,
      address: address ?? this.address,
      canReserve: canReserve ?? this.canReserve,
      price: price ?? this.price,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      isTendency: isTendency ?? this.isTendency,
      pricePer: pricePer ?? this.pricePer,
    );
  }

  /*Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'description': description,
      'productType': productType,
      'employee': employee,
      'promotionPrice': promotionPrice,
      'stockNumber': stockNumber,
      'images': images,
      'address': address?.toMap(),
      'canReserve': canReserve,
      'price': price,
      'isTendency': isTendency,
      'pricePer': pricePer,
    };
  }*/

  Map<String, dynamic> toPHPJson() => {
    "id": "$id",
    "name": name,
    "model": model,
    "purchasePrice": "$purchasePrice",
    "salePrice": "$price",
    "description": description,
    "productType": "${productType.index}",
    "employeeId": "$employee",
    "promotionalPrice": "$promotionPrice",
    "promotionalOutdated": "$promotionOutdated",
    "stock": "$stockNumber",
    "threshold": "$threshold",
    //"images": null,
    //"address": null,//address.toString(),
    "canReserve": canReserve ? "1" : "0",
    "isTendency": isTendency == true ? "1" : "0",
    //"updated_at": "2023-09-18T00:00:00.000000Z",
    //"created_at": "2023-09-18T00:00:00.000000Z"
  };

  factory Product.fromPHPJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as dynamic,
      name: map['name'] as String,
      model: map['model'] as String,
      price: double.parse(map['salePrice'] as String),
      purchasePrice: double.parse(map['purchasePrice'] as String),
      description: map['description'] as String? ?? "Aucune description" ,
      productType: ProductType.values[int.parse(map['productType'] as String)],
      employee: map['employeeId'] as int,
      promotionPrice: map['promotionalPrice'] != null
          ? double.parse(map['promotionalPrice'] as String)
          : null,
      promotionOutdated: map['promotionalOutdated'] != null
          ? DateTime.parse(map['promotionalOutdated'] as String)
          : null,
      stockNumber: map['stock'] as int,
      threshold: map['threshold'] as int,
      //images: [], //map['images'] as List<String>,
      //address: AddressData.fromMap(map['address']),
      canReserve: map['canReserve'] as int == 1,
      isTendency: map['isTendency'] as int == 1,
      //pricePer: map['pricePer'] as PriceCurrency,
    );
  }

  /*factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as dynamic,
      name: map['name'] as String,
      model: map['model'] as String,
      description: map['description'] as String,
      productType: map['productType'] as ProductType,
      employee: map['employee'] as dynamic,
      promotionPrice: map['promotionPrice'] as int,
      promotionOutdated: map['promotionOutdated'] as DateTime,
      stockNumber: map['stockNumber'] as int,
      images: map['images'] as List<String>,
      address: AddressData.fromMap(map['address']),
      canReserve: map['canReserve'] as bool,
      price: map['price'] as int,
      purchasePrice: map['price'] as int,
      isTendency: map['isTendency'] as bool,
      pricePer: map['pricePer'] as PriceCurrency,
    );
  }*/


}