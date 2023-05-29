import 'package:flutter/material.dart';
import 'package:qmt_manager/src/add_doctor/add_doctor_page.dart';
import 'package:qmt_manager/src/add_doctor/data_tab.dart';
import 'package:qmt_manager/src/add_product/add_product_page.dart';
import 'package:qmt_manager/src/login_page.dart';
import 'package:qmt_manager/src/maps_test.dart';
import 'package:qmt_manager/src/home_page.dart';
import 'package:qmt_manager/src/home_page/single_item_screen.dart';

import 'package:qmt_manager/src/myspace_page.dart';
import 'package:qmt_manager/src/preference_page/about_page.dart';

import 'logic/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

import 'on_error_page.dart';

class AppRouter extends GoRouter {
  //final GlobalKey<NavigatorState>? shellNavigatorKey;
  final GlobalKey<NavigatorState> key;

  AppRouter({
    //this.shellNavigatorKey,
    required this.key,
  }) : super(
          navigatorKey: key,
          errorBuilder: (context, state) => OnErrorPage(error: state.error),
          initialLocation: HomePage.routeUrl, //LoginPage.routeName,
          routes: <RouteBase>[
            /*GoRoute(
              parentNavigatorKey: key,
              path: "/",
              redirect: (_,state) {
                /*if(BlocProvider.of<AuthenticationBloc>(_).state.
                status == AuthenticationStatus.authenticated){
                    return HomePage.routeUrl;
                }*/
                //return LoginPage.routeUrl;
                return HomePage.routeUrl;
              },
            ),*/
            ShellRoute(
              // navigatorKey: shellNavigatorKey,
              builder: (context, state, screen) => HomePage(child: screen),
              routes: <RouteBase>[
                _homeGoRoute(parentKey: key),
              ],
            ),
            GoRoute(
              parentNavigatorKey: key,
              name: LoginPage.routeName,
              path: LoginPage.routeName,
              builder: (context, state) => const LoginPage(),
            ),
          ],
        );

  static _homeGoRoute({required GlobalKey<NavigatorState> parentKey}) =>
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeName,
        redirect: null,
        builder: (context, state) {
          return const NestedWebView(child: HomeScreen());
        },
        routes: <RouteBase>[

          GoRoute(
            name: UserSpaceScreen.routeName,
            path: 'user',
            builder: (context, state) {
              return const NestedWebView(child: UserSpaceScreen());
            },
            routes: [
              /*GoRoute(
                parentNavigatorKey: parentKey,
                name: ProductTablePage.routeName,
                path: "product-table",
                builder: (context, state) => const ProductTablePage(),
              ),*/
              GoRoute(
                parentNavigatorKey: parentKey,
                name: AddProductPage.routeName,
                path: "add-product",
                builder: (context, state) => const AddProductPage(),
              ),
              GoRoute(
                parentNavigatorKey: parentKey,
                name: DataTableDemo.routeName,
                path: 'doctor-table',
                builder: (c, s) => const DataTableDemo(),
              ),
              GoRoute(
                parentNavigatorKey: parentKey,
                name: AddDoctorPage.routeName,
                path: 'add-doctor',
                builder: (c, s) => const AddDoctorPage(),
              ),
            ]
          ),

          GoRoute(
            name: ProductScreen.routeName,
            path: "explore",
            builder: (ctx, state) {
              return const ProductScreen();
            },
            routes: [
              GoRoute(
                parentNavigatorKey: parentKey,
                name: SingleItemScreen.routeName,
                path: "places/single",
                builder: (context, state) => SingleItemScreen(
                  placeData: state.extra as ItemIntentData,
                ),
              ),
              GoRoute(
                parentNavigatorKey: parentKey,
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
      );
}
