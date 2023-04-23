import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qmt_manager/src/login_page.dart';
import 'package:qmt_manager/src/maps_test.dart';
import 'package:qmt_manager/src/add_rent_page/add_rent_page.dart';
import 'package:qmt_manager/src/home_page.dart';
import 'package:qmt_manager/src/home_page/place_info_screen.dart';

import 'package:qmt_manager/src/myspace_page.dart';
import 'package:qmt_manager/src/preference_page/about_page.dart';

import 'logic/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

import 'on_error_page.dart';

class AppRouter extends GoRouter {
  final GlobalKey<NavigatorState> shellNavigatorKey;
  final GlobalKey<NavigatorState> rootNavigatorKey;


  AppRouter({
    required this.shellNavigatorKey,
    required this.rootNavigatorKey,
  }) : super(
          navigatorKey: rootNavigatorKey,
          errorBuilder: (context, state) => OnErrorPage(error: state.error),
          initialLocation: LoginPage.routeName,
          routes: [
            ShellRoute(
              navigatorKey: shellNavigatorKey,
              builder: (context, state, child) => HomePage(child: child),
              routes: [
                GoRoute(
                  name: HomePage.routeName,
                  path: HomePage.routeName,
                  redirect: (context, state) => null,
                  builder: (context, state) {
                    return const NestedWebView(child: HomeScreen());
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      name: UserSpaceScreen.routeName,
                      path: 'user/myspace',
                      builder: (context, state) {
                        return const NestedWebView(child: UserSpaceScreen());
                      },
                    ),
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      name: AddProductPage.routeName,
                      path: "user/form",
                      builder: (context, state) => const AddProductPage(),
                    ),
                    GoRoute(
                      name: ProductScreen.routeName,
                      path: "explore",
                      builder: (ctx, state) {
                        return const ProductScreen();
                      },
                      routes: [
                        GoRoute(
                          parentNavigatorKey: rootNavigatorKey,
                          name: PlaceInfoScreen.routeName,
                          path: "places/single-place",
                          builder: (context, state) => PlaceInfoScreen(
                            placeData: state.extra as PlaceInfoData,
                          ),
                        ),
                        GoRoute(
                          parentNavigatorKey: rootNavigatorKey,
                          name: MapSample.routeName,
                          path: "map",
                          builder: (context, state) => MapSample(
                            initialPosition: state.extra as maps.LatLng?,
                          ),
                        ),
                      ],
                    ),
                    GoRoute(
                      name: SettingScreen.routeName,
                      path: 'setting',
                      builder: (ctx, state) => const SettingScreen(),
                      routes: [
                        GoRoute(
                          name: AboutPage.routeName,
                          path: "about",
                          builder: (ctx, state) => const AboutPage(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: LoginPage.routeName,
              path: LoginPage.routeName,
              builder: (context, state) => const LoginPage(),
            ),
          ],
        );
}
