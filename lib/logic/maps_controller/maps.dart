
library data.maps;

import 'package:equatable/equatable.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:latlong2/latlong.dart' as dist;

import 'package:qmt_manager/logic/maps_controller/gps_location.dart';


part 'maps_bloc.dart';
part 'maps_event.dart';
part 'maps_state.dart';



class MapsData extends Equatable{
  //final Set<Marker>? shopMarkers;
  final GPS currentPosition;

  const MapsData({required this.currentPosition});


  static MapsData empty = MapsData(currentPosition: GPS.empty);

  CameraPosition get currentCameraPosition => CameraPosition(
      target: currentPosition.latLng,
      zoom: 15.0,
  );

  LatLng get currentLatLng => LatLng(
      currentPosition.latLng.latitude,
      currentPosition.latLng.longitude
  );

  //Marker get currentMarker => Marker(markerId: null);

  dist.LatLng get currentLatLng2 => dist.LatLng(
      currentPosition.latLng.latitude,
      currentPosition.latLng.longitude
  );

  @override
  List<Object?> get props => [currentPosition];


}