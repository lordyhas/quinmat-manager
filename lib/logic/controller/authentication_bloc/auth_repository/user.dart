
part of 'setup.dart';


/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {

  /// todo: resolved the probleme of email if is in facebook user
  /// {@macro user}
  const User({
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.access,
    this.registrationNumber,
    this.photoMail,

    this.creationDate,
    this.lastDate,
    this.isAnonymous,
    this.isCheckMail,
    this.location,
    this.lastConnection,
    this.verifiedAccount = false,
    this.isDataCloud = false,
    this.isBlocked = false,
  })  : assert(email != null,"User must have a mail"),
        assert(id != null,"User must have an id");




  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String? id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photoMail;
  //final Blob? photoCloud;

  ///
  final DateTime? creationDate;
  final DateTime? lastDate;
  final DateTime? lastConnection;

  /// The phone number of user
  final String? phoneNumber;

  final String? registrationNumber;
  final int access;




  /// isCheckMail is an equivalent of [emailVerified]
  final bool? isCheckMail;

  /// isAnonymous will be true if [isCheckMail] is false
  final bool? isAnonymous;

  /// The current location, mobile position
  final dynamic location;

  /// If all value is okay and verified in Database will be true, else false
  final bool verifiedAccount;

  /// It will be true if data from cloud else false
  final bool isDataCloud;

  final bool isBlocked;

  ///

  // The fix location like the home address
 // final homeLocation;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, phoneNumber: null, access: 1,);

  /// copyWith method, will help to get [UserData] saved in FireCloud
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? photoMail,
    photoCloud,
    String? phoneNumber,
    String? registrationNumber,
    bool? isAnonymous,
    bool? isEmail,
    DateTime? creationTime,
    DateTime? lastConnection,
    DateTime? lastDate,
    location,
    bool? verifiedAccount,
    bool? isDataCloud,
    bool? isBlocked,
    int? access,

  }) => User(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    access: access ?? this.access,
    photoMail: photoMail ?? this.photoMail,
    //photoCloud: photoCloud ?? this.photoCloud,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    registrationNumber: registrationNumber ?? this.registrationNumber,
    lastDate: lastDate ?? this.lastDate,
    creationDate: creationTime ?? creationDate,
    isAnonymous: isAnonymous ?? this.isAnonymous,
    isCheckMail: isEmail ?? isCheckMail,
    lastConnection: lastConnection ?? this.lastConnection,
    verifiedAccount: verifiedAccount ?? this.verifiedAccount,
    location: location ?? this.location,
    isDataCloud: isDataCloud ?? this.isDataCloud,
    isBlocked: isBlocked ?? this.isBlocked,

  );


  Map<String, dynamic> toMap() => {
    'id':id,
    'name':name,
    'email':email,
    'reg_no': registrationNumber,
    'access': access,
    //'photo_profile':photoCloud,
    'photo_mail':photoMail,
    'phone': phoneNumber,
    'last_login':lastDate,
    'creation_time':creationDate,
    'last_connection': lastConnection ?? DateTime.now() ,
    'is_check_mail':isCheckMail,
    'verified_account':verifiedAccount,
    'location':location,
    'is_data_cloud': isDataCloud,
    'is_blocked': isBlocked,
    //'':this,

  };

  static User fromMap(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    email: data['email'],
    access: data['access'],
    registrationNumber: data['reg_no'],
    //photoCloud: data['photo_profile'],
    photoMail: data['photo_mail'],
    creationDate: data['creation_time'].toDate(),
    lastDate: data['last_login'].toDate(),
    lastConnection: data['last_connection'].toDate(),
    phoneNumber: data['phone'],
    isCheckMail: data['is_check_mail'],
    isBlocked: data['is_blocked'],
    verifiedAccount: data['verified_account'],
    location: data['location'],
    //photo: value.data()![''],
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photoMail];
}
