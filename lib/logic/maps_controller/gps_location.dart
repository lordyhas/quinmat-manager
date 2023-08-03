
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSLocation {


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<GPS> myCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error("Location permissions are permanently "
                "denied, we cannot request permissions.");
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return (await Geolocator.getCurrentPosition()).toGPSPosition();
  }


}

class GPS extends Position implements Equatable{

   GPS({
    required this.latLng,
    required DateTime? timestamp,
    required double accuracy,
    required double altitude,
    required heading,
    required double speed,
    required double speedAccuracy,
    int? floor,
    bool isMocked = false,
  }) : super(
    latitude: latLng.latitude,
    longitude: latLng.longitude,
    timestamp: timestamp,
    accuracy: accuracy,
    altitude: altitude,
    heading: heading,
    speed: speed,
    speedAccuracy: speedAccuracy,
  );

  /// A pair of latitude and longitude coordinates, stored as degrees.
  final LatLng latLng;



   /// Converts the supplied [Map] to an instance of the [Position] class.
  static GPS fromMap(dynamic message) {
    final Map<dynamic, dynamic> positionMap = message;

    if (!positionMap.containsKey('latitude')) {
      throw ArgumentError.value(positionMap, 'positionMap',
          'The supplied map doesn\'t contain the mandatory key `latitude`.');
    }

    if (!positionMap.containsKey('longitude')) {
      throw ArgumentError.value(positionMap, 'positionMap',
          'The supplied map doesn\'t contain the mandatory key `longitude`.');
    }

    final DateTime timestamp = positionMap['timestamp'] ??
        DateTime.fromMillisecondsSinceEpoch(positionMap['timestamp'].toInt(),
        isUtc: true);

    return GPS(
      latLng: LatLng(positionMap['latitude'],positionMap['longitude']),
      //latitude: positionMap['latitude'],
      //longitude: positionMap['longitude'],
      timestamp: timestamp,
      altitude: positionMap['altitude'] ?? 0.0,
      accuracy: positionMap['accuracy'] ?? 0.0,
      heading: positionMap['heading'] ?? 0.0,
      floor: positionMap['floor'],
      speed: positionMap['speed'] ?? 0.0,
      speedAccuracy: positionMap['speed_accuracy'] ?? 0.0,
      isMocked: positionMap['is_mocked'] ?? false,
    );
  }

  static GPS empty = GPS(
    latLng: const LatLng(0.0,0.0),
    timestamp: null,
    altitude: 0.0,
    accuracy: 0.0,
    heading: 0.0,
    floor: null,
    speed: 0.0,
    speedAccuracy: 0.0,
    isMocked: false,
  );

  @override
  List<Object?> get props => [
    latLng, altitude, accuracy, heading,
    floor, speed, speedAccuracy, isMocked];

  @override
  bool? get stringify => null;


}

extension on Position{
  GPS toGPSPosition(){
    return GPS(
      latLng: LatLng(latitude, longitude),
      timestamp: timestamp,
      accuracy: accuracy,
      altitude: altitude,
      heading: heading,
      speed: speed,
      speedAccuracy: speedAccuracy,
      floor: floor,
      isMocked: isMocked,
    );
  }
}