part of data.model;

class ShopInformation{
  //final String owner;
  //final String
}

class ItemData{
  final dynamic id;
  final String name;
  final String? dept;
  final String? email;
  final OpenDay openDay;
  final String? isOpened;
  final maps.LatLng? location;
  final String? phoneNumber;
  final String? phoneNumber2;
  final String? imagePath;
  final dynamic image;



  AddressData? addressData;

  /// sum of the rating out of 5 given by users
  final int rating;

  ///number of rater, then rating in code will be :
  ///[ShopData.rating/(ShopData.rater*5)]
  final int rater;

  /// [authenticate] shop is when this exists
  final bool authenticate;

  /// [certify] shop with all info about,
  final bool certify;

  /// will be true if delivery is possible
  final dynamic canDeliver;


  ItemData({
    required this.name,
    required this.id,
    this.authenticate = false, this.certify = false,
    this.dept,
    this.imagePath,
    this.image,
    this.email,
    this.rating = 0,
    this.rater = 0,
    this.addressData,
    this.openDay = const OpenDay.openable(),
    this.isOpened,
    this.location,
    this.phoneNumber,
    this.phoneNumber2,
    this.canDeliver,
  });
  //: super(id:id, name:shopName, userCode:shopCode, location:location, phoneNumber:number,);

  final _table = "PRODUCTS";
  String get collectionName => _table;
  AddressData? get address => addressData;
  set setAddress(AddressData data) {
    addressData = data;
  }


  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'shop_name': name,
      'phone_number': phoneNumber,
      'shop_code': id,
      'open_day': openDay.week,
      'is_opened': isOpened,
      'email': email,
      'location': {
        'latitude':location?.latitude,
        'longitude':location?.longitude,
      },
      'phone_number2': phoneNumber2,
      'rating': rating,
      'rater': rater,
      'address': addressData!.asMap(),
      'image_path': imagePath,
      'image': image,
      'delivery': canDeliver,
      //'': this.,

    };
  }

  factory ItemData.fromMap(Map<String, dynamic> map) => ItemData(
    id: map['id'],
    name: map['shop_name'],
    dept: map['shop_code'],
    phoneNumber: map['phone_number'],
    phoneNumber2: map['phone_number2'],
    imagePath: map['image_path'],
    image: map['image'],
    openDay: map['open_day'],
    isOpened: map['is_opened'],
    rating: map['rating'],
    rater: map['rater'],
    email: map['email'],
    canDeliver: map['delivery'],
    location: maps.LatLng(
        map['location']['latitude'],
        map['location']['longitude']
    ),
    addressData: AddressData.fromMap(map['address']),

  );


}

class OpenDay {
  final Map<int, bool>? week;

  const OpenDay._({
    this.week,
  });

  const OpenDay.none() : this._(week: weekDefaultClose);

  const OpenDay.all() : this._(week: weekDefaultOpen);
  const OpenDay.weekendOnly() : this._(week: weekDefaultOpen);
  const OpenDay.openable() : this._(week: weekOpenable);

  factory OpenDay.only({
    bool? monday,
    bool? thursday,
    bool? wednesday,
    bool? tuesday,
    bool? friday,
    bool? saturday,
    bool? sunday}) {
    var map = weekDefaultClose;

    map[DateTime.monday] = monday ?? false;
    map[DateTime.thursday] = thursday ?? false;
    map[DateTime.wednesday] = wednesday ?? false;
    map[DateTime.tuesday] = tuesday ?? false;
    map[DateTime.friday] = friday ?? false;
    map[DateTime.saturday] = saturday ?? false;
    map[DateTime.sunday] = sunday ?? false;

    return OpenDay._(
      week: map,
    );
  }

  static const Map<int, bool> weekDefaultClose = <int, bool>{
    DateTime.monday: false,
    DateTime.thursday: false,
    DateTime.wednesday: false,
    DateTime.tuesday: false,
    DateTime.friday: false,
    DateTime.saturday: false,
    DateTime.sunday: false,
  };

  static const Map<int, bool> weekDefaultOpen = <int, bool>{
    DateTime.monday: true,
    DateTime.thursday: true,
    DateTime.wednesday: true,
    DateTime.tuesday: true,
    DateTime.friday: true,
    DateTime.saturday: true,
    DateTime.sunday: true,
  };
  static const Map<int, bool> weekOpenable = <int, bool>{
    DateTime.monday: true,
    DateTime.thursday: true,
    DateTime.wednesday: true,
    DateTime.tuesday: true,
    DateTime.friday: true,
    DateTime.saturday: true,
    DateTime.sunday: false,
  };

}