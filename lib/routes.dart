import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qmt_manager/src/dashboard/doctors/doctor_data_tab.dart';
import 'package:qmt_manager/src/add_product/add_product_page.dart';
import 'package:qmt_manager/src/dashboard/home_screen.dart';
import 'package:qmt_manager/src/dashboard/nested_web_view.dart';
import 'package:qmt_manager/src/dashboard/customers/filters_screen.dart';
import 'package:qmt_manager/src/dashboard/customers/product_table_page.dart';
import 'package:qmt_manager/src/login_page.dart';
import 'package:qmt_manager/src/maps_test.dart';
import 'package:qmt_manager/src/home_page.dart';
import 'package:qmt_manager/src/dashboard/single_item_screen.dart';

import 'package:qmt_manager/src/myspace_page.dart';
import 'package:qmt_manager/src/navigation_home.dart';
import 'package:qmt_manager/src/preference_page/about_page.dart';
import 'package:qmt_manager/src/preference_page/edit_profile_page.dart';
import 'package:qmt_manager/src/setting_profile_screen.dart';

import 'logic/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

import 'on_error_page.dart';

class AppRouter extends GoRouter {
  final GlobalKey<NavigatorState> key;
  AppRouter({
    required this.key,
  }) : super(
          navigatorKey: key,
          errorBuilder: (context, state) => OnErrorPage(error: state.error),
          initialLocation: HomeScreen.routeUrl, //LoginPage.routeName,
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: key,
              path: "/index",
              redirect: (_,state) {
                if(BlocProvider.of<AuthBloc>(_).state.
                status == AuthenticationStatus.authenticated){
                    return HomeScreen.routeUrl;
                }
                //return LoginPage.routeUrl;
                return LoginPage.routeUrl;
              },
            ),

            ShellRoute(
              // navigatorKey: shellNavigatorKey,
              builder: (context, state, screen) => NavigationHome(child: screen),
              routes: <RouteBase>[
                _homeGoRoute(parentKey: key),
              ],
            ),
            /*ShellRoute(
              // navigatorKey: shellNavigatorKey,
              builder: (context, state, screen) => HomePage(child: screen),
              routes: <RouteBase>[
                _homeGoRoute(parentKey: key),
              ],
            ),*/
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
        name: HomeScreen.routeName,
        path: HomeScreen.routeName,
        redirect: (_,state) {
          if(BlocProvider.of<AuthBloc>(_).isLogged){
            return null;
          }
          //return LoginPage.routeUrl;
          return LoginPage.routeUrl;
        },
        builder: (context, state) {
          return const NestedView(child: HomeScreen());
        },
        routes: <RouteBase>[
          GoRoute(
            /*redirect: (_,state){
              if(BlocProvider.of<AuthBloc>(_).isNotLogged){
                return LoginPage.routeUrl;
              }
              return null;
            },*/
            name: MySpaceScreen.routeName,
            path: 'user',
            builder: (context, state) {
              return const  NestedView(child:MySpaceScreen());
            },
            routes: [
              GoRoute(
                //parentNavigatorKey: parentKey,
                name: ProductTablePage.routeName,
                path: "product-table",
                builder: (context, state) => const ProductTablePage(),
              ),
              GoRoute(
                parentNavigatorKey: parentKey,
                name: AddProductPage.routeName,
                path: "add-product",
                builder: (context, state) => const AddProductPage(),
              ),
              GoRoute(
                //parentNavigatorKey: parentKey,
                name: DoctorDataTableScreen.routeName,
                path: 'doctor-table',
                builder: (c, s) => const DoctorDataTableScreen(),
              ),
              /*GoRoute(
                //parentNavigatorKey: parentKey,
                name: AddDoctorPage.routeName,
                path: 'add-doctor',
                builder: (c, s) => const AddDoctorPage(),
              ),*/
            ]
          ),
          GoRoute(
            //parentNavigatorKey: parentKey,
            name: FiltersScreen.routeName,
            path: "filter-item",
            builder: (context, state) => const FiltersScreen(),
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
              GoRoute(
                name: ProfilePage.routeName,
                path: "profile/edit",
                builder: (ctx, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      );
}

