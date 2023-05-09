part of data.model;

class Product {
  final dynamic id;
  final String name;
  final String model;
  final String description;
  final ProductType productType;
  final dynamic employee;
  final int? promotionPrice;
  final int stockNumber;
  final List<String> images;
  final AddressData? address;
  final bool isPossibleReservation;
  final int? price;
  final bool? isTendency;

  final PriceCurrency pricePer;


  const Product({
    required this.name,
    required this.model,
    required this.id,
    required this.description,
    required this.productType,
    required this.price,

    this.promotionPrice,
    this.employee,
    this.stockNumber = 1,
    this.images = const [],
    this.address,
    this.isPossibleReservation = false,
    this.isTendency,
    this.pricePer = PriceCurrency.CDF,
  });

  static const Map<ProductType, String> departments = {
    ProductType.QCL: "QUINCAILLERIE",
    ProductType.MOB: "MOBILIER",
    ProductType.MED: "MEDICAL",
    ProductType.PAP: "PAPETERIE",

  };


  static const empty = Product(
      id: '',
      name: '',
      description: '',
      price: null,
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
          stockNumber == other.stockNumber &&
          images == other.images &&
          address == other.address &&
          isPossibleReservation == other.isPossibleReservation &&
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
      isPossibleReservation.hashCode ^
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
        ' owner: $employee,'
        ' promotionPrice: $promotionPrice,'
        ' stockNumber: $stockNumber,'
        ' images: $images,'
        ' address: $address,'
        ' isPossibleReservation: $isPossibleReservation,'
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
    dynamic employee,
    int? promotionPrice,
    int? stockNumber,
    List<String>? images,
    AddressData? address,
    bool? isPossibleReservation,
    int? price,
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
      stockNumber: stockNumber ?? this.stockNumber,
      images: images ?? this.images,
      address: address ?? this.address,
      isPossibleReservation:
          isPossibleReservation ?? this.isPossibleReservation,
      price: price ?? this.price,
      isTendency: isTendency ?? this.isTendency,
      pricePer: pricePer ?? this.pricePer,
    );
  }

  Map<String, dynamic> toMap() {
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
      'isPossibleReservation': isPossibleReservation,
      'price': price,
      'isTendency': isTendency,
      'pricePer': pricePer,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as dynamic,
      name: map['name'] as String,
      model: map['model'] as String,
      description: map['description'] as String,
      productType: map['productType'] as ProductType,
      employee: map['employee'] as dynamic,
      promotionPrice: map['promotionPrice'] as int,
      stockNumber: map['stockNumber'] as int,
      images: map['images'] as List<String>,
      address: AddressData.fromMap(map['address']),
      isPossibleReservation: map['isPossibleReservation'] as bool,
      price: map['price'] as int,
      isTendency: map['isTendency'] as bool,
      pricePer: map['pricePer'] as PriceCurrency,
    );
  }

//</editor-fold>
}