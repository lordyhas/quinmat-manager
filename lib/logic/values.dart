library values;

import 'package:achievement_view/achievement_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

export 'controller/my_bloc_controller.dart';
export 'values/styles.dart';
export 'values/dimens.dart';
export 'utils.dart';
export 'extension.dart';
export 'package:utils_component/utils_component.dart' hide Responsive, Go;
export 'package:go_router/go_router.dart';
export 'go_utils.dart';

part 'category.dart';

part 'distance.dart';

void checkConnect() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  switch (connectivityResult) {
    case ConnectivityResult.bluetooth:
      debugPrint("I am connected to a bluetooth. ###");
      break;
    case ConnectivityResult.wifi:
      debugPrint("I am connected to a wifi network. ###");
      break;
    case ConnectivityResult.ethernet:
      debugPrint("I am connected to a ethernet network. ###");
      break;
    case ConnectivityResult.mobile:
      debugPrint("I am connected to a mobile network. ###");
      break;
    case ConnectivityResult.none:
      debugPrint("I am not connected to any network. ###");
      break;
    case ConnectivityResult.vpn:
    // I am connected to a vpn network.
    // Note for iOS and macOS:
    // There is no separate network interface type for [vpn].
    // It returns [other] on any device (also simulator)
      debugPrint("I am connected to a vpn network. ###");
      break;
    case ConnectivityResult.other:
      debugPrint(
          "I am connected to a network which is not in the above mentioned networks. ###");
      break;
  }
}


extension GoRouterHelper on GoRouter {
  void to({
    required String routeName,
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      goNamed(routeName,
          pathParameters: params, queryParameters: queryParams, extra: extra);
}

class Responsive {
  final BuildContext context;

  const Responsive._(this.context);

  static Responsive of(BuildContext context) => Responsive._(context);

  Size get size => MediaQuery.of(context).size;

  bool get isPhone => size.width <= kPhoneDimens; // || Platform.isAndroid;
  bool get isWeb => size.width > kPhoneDimens || kIsWeb;

  bool get isOnlyWeb => kIsWeb;

  bool get isWindows => size.width > kPhoneDimens; // || Platform.isWindows;
  bool get isMacOS => size.width > kPhoneDimens; // || Platform.isMacOS;
}

Future<void> launchMapOnWeb({maps.LatLng? latLng}) async {
  double lat = latLng?.latitude ?? -10.6284708;
  double lng = latLng?.latitude ?? 20.487585;
  String latlng = "$lat,$lng";
  if (!kIsWeb) return;
  final Uri url = Uri.parse("https://maps.google.com/?q=$latlng");
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

class MyScrollBehaviorBehavior extends ScrollBehavior {
  /*@override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }*/
}

void showToastFavorite({required BuildContext context, String? message}) =>
    AchievementView(
      context,
      title: "Added to favorite",
      subTitle: message ?? "Place added to your favorite list",
      isCircle: true,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.favorite),
      color: Colors.teal.shade800,

      //onTab: _onTabAchievement,
      //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      //borderRadius: 5.0,
      //color: Colors.blueGrey,
      //textStyleTitle: TextStyle(),
      //textStyleSubTitle: TextStyle(),
      //alignment: Alignment.topCenter,
    ).show();
