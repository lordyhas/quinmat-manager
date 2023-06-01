library home_page;

import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:qmt_manager/logic/values.dart';
import 'package:qmt_manager/src/login_page.dart';
import 'package:qmt_manager/src/preference_page/edit_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
//import 'package:latlong2/latlong.dart' as dist;
import 'package:qmt_manager/data_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
//import 'package:qmt_manager/src/maps_test.dart';
import 'package:qmt_manager/src/preference_page/about_page.dart';
import 'package:qmt_manager/src/home_page/products/product.dart';
import 'package:qmt_manager/src/home_page/products/filters_screen.dart';
import 'package:qmt_manager/src/home_page/products/model/view_model.dart';
import 'package:qmt_manager/src/home_page/single_item_screen.dart';
import 'package:qmt_manager/src/myspace_page.dart';

import 'package:http/http.dart' as http;

//import '../logic/maps_controller/maps.dart';



part 'home_page/product_screen.dart';

part 'setting_profile_screen.dart';

part 'home_page/home_screen.dart';

part 'home_page/nested_web_view.dart';

part 'home_page/app_bar_view.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  static const routeUrl = '/home';
  final Widget child;

  const HomePage({
    this.child = const SizedBox(),
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _iconMenuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }


  void closeDrawer() => _scaffoldKey.currentState?.closeDrawer();

  List<DrawerItem> get items => <DrawerItem>[
    DrawerItem(
      navigationScreen: NavigationScreen.home,
      icon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home),
      label: const Text('Acceuil'),
      onPressed: () {
        BlocProvider.of<NavigationController>(context)
            .setState(NavigationScreen.home);
        GoRouter.of(context).goNamed(HomePage.routeName);
        closeDrawer();
        //setState(() {});
      },),
    DrawerItem(
      navigationScreen: NavigationScreen.explorer,
      icon: const Icon(Icons.view_carousel_outlined),
      selectedIcon: const Icon(Icons.view_carousel),
      label: const Text('Explorer'),
      onPressed: () {
        GoRouter.of(context).goNamed(ProductScreen.routeName);
        closeDrawer();
      },
    ),
    DrawerItem(
      navigationScreen: NavigationScreen.setting,
      icon: const Icon(Icons.settings),
      selectedIcon: const Icon(Icons.settings),
      label: const Text('Préférences'),
      onPressed: () {
        //_scaffoldKey.currentState?.closeDrawer();
        GoRouter.of(context).goNamed(SettingScreen.routeName);
        closeDrawer();
        },
    ),
  ];

  FloatingActionButton get floatingActionButton => FloatingActionButton(
    elevation: 0,
    onPressed: () {},
    child: const Icon(CupertinoIcons.map),
  );

  Future<void> getTest() async {

    final response = await http
        .get(Uri.parse('https://exploress.space/index.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }

  }

  Future<void> sendTest(Map data) async {
    final response = await http
        .post(Uri.parse('http://127.0.0.1:8000/api/test_post'), body: data);
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    //return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {

    //getTest();
    sendTest({'host':'Hassan K.'});


    Responsive responsive = Responsive.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      print("==== MediaQuery.of(context).size.width : $screenWidth");
    }
    GoRouter.of(context).addListener(() {
      if (GoRouter.of(context).location == HomePage.routeName) {
        BlocProvider.of<NavigationController>(context)
            .setState(NavigationScreen.home);
      }
    });

    return Material(
      child: Row(
        children: <Widget>[
          ///  NavigationRail ++++++++++++++++++++++ ///
          if (screenWidth > kPhoneDimens && kIsWeb)
            BlocBuilder<NavigationController, NavigationScreen>(
              builder: (context, state) {
                int index = state.index <= 2 ? state.index : 2;
                return NavigationRail(
                  selectedIndex: index,
                  groupAlignment: 1.0,
                  onDestinationSelected: (int index) {
                    items[index].onPressed!();
                  },
                  labelType: (screenWidth < 800)
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  leading: floatingActionButton,
                  destinations: items
                      .map((item) => NavigationRailDestination(
                    icon: item.icon,
                    selectedIcon: item.selectedIcon,
                    label: item.label,
                  ))
                      .toList(),
                );
              },
            ),

          //const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Scaffold(
              key: _scaffoldKey,
              //floatingActionButton: responsive.isPhone ? floatingActionButton : null,

              appBar: AppBar(
                elevation: 0.0,
                //centerTitle: kIsWeb,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: responsive.isPhone ? null : Container(),  //(Image.asset("assets/icon_app.png")),
                title: Row(
                  children: [
                    Text(
                      AppConstant.shortname.toUpperCase(),
                      style: const TextStyle(
                        //color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    BooleanBuilder(
                      condition:
                          () => screenWidth > (kPhoneDimens - 40) && kIsWeb,
                      ifTrue: Row(
                        children: [
                          TextButton(
                            child: const Text("Mon Compte"),
                            onPressed: () => Go.of(context)
                                .goNamed(UserSpaceScreen.routeName),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          TextButton(
                            child: const Text("About"),
                            onPressed: () => GoRouter.of(context)
                                .goNamed(AboutPage.routeName),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Help"),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("FAQ"),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              switch(state.status){
                                case AuthenticationStatus.authenticated:
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () => Go.of(context)
                                        .goNamed(LoginPage.routeName),
                                    child: const Text("Login"),
                                  );
                                case AuthenticationStatus.unauthenticated:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),
                          const SizedBox(width: 8.0,),
                        ],
                      ),
                      ifFalse: const SizedBox.shrink(),
                    ),
                  ],
                ),

                actions: [
                  IconButton(
                    key: _iconMenuKey,
                    icon: const Icon(Icons.notifications),
                    onPressed: (){
                      final RenderBox renderBox = _iconMenuKey.currentContext?.findRenderObject() as RenderBox;
                      // Get the size of the widget
                      final Size size = renderBox.size;
                      // Get the offset of the widget
                      final Offset offset = renderBox.localToGlobal(Offset.zero);

                      final RelativeRect position = RelativeRect.fromLTRB(
                        offset.dx,
                        offset.dy + size.height,
                        offset.dx + size.width,
                        offset.dy,
                      );
                      showMenu(
                          context: context,
                          position: position,
                          items: <PopupMenuEntry<int>>[
                            const PopupMenuItem<int>(
                              value: 1,
                              child: ListTile(
                                title: Text('Heritier M.'),
                                subtitle: Text(
                                    "Il une erreur sur PP0022 ?"),
                              ),
                            ),
                            const PopupMenuItem<int>(
                              value: 2,
                              child: ListTile(
                                title: Text('Mark'),
                                subtitle:
                                Text("Corrige l'adresse QC17889 ?"),
                              ),
                            ),
                            const PopupMenuItem<int>(
                              value: 3,
                              child: ListTile(
                                title: Text('Sami Konda'),
                                subtitle: Text("Corriger l'erreur, svp, MD4589"),
                              ),
                            ),
                            const PopupMenuItem<int>(
                              value: 3,
                              child: ListTile(
                                title: Text('Olga Wivine'),
                                subtitle: Text("Merci beaucoup."),
                              ),
                            ),
                          ],
                      );
                    },
                  ),
                  //
                  /*PopupMenuButton(
                    //enabled: false,
                    tooltip: "",
                    icon: const Icon(Icons.notifications),
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<int>>[
                      const PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text('Heritier M.'),
                          subtitle: Text(
                              "Il une erreur sur PP0022 ?"),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: ListTile(
                          title: Text('Mark'),
                          subtitle:
                          Text("Corrige l'adresse QC17889 ?"),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 3,
                        child: ListTile(
                          title: Text('Sami Konda'),
                          subtitle: Text("Corriger l'erreur, svp, MD4589"),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 3,
                        child: ListTile(
                          title: Text('Olga Wivine'),
                          subtitle: Text("Merci beaucoup."),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
              drawer: BlocBuilder<NavigationController, NavigationScreen>(
                builder: (context, state) {
                  int index = state.index <= 2 ? state.index : 2;
                  return NavigationDrawer(
                    selectedIndex: index,
                    indicatorColor: Colors.teal.shade400,
                    onDestinationSelected: (int index) {
                      items[index].onPressed!();
                    },
                    children: [
                      SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            const Spacer(),
                            Image.asset(
                              "assets/icon_app.png",
                              width: 75,
                            ),
                            const SizedBox(height: 8.0,),
                            const Text(
                              AppConstant.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0,),

                            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (context, state) {
                                switch(state.status){
                                  case AuthenticationStatus.unauthenticated:
                                    return const Chip(
                                      /*avatar: CircleAvatar(
                                      child: Text("X"),
                                    ),*/
                                      label: Text("Not Connected"),
                                    );
                                  case AuthenticationStatus.authenticated:
                                    return Chip(
                                      avatar: CircleAvatar(
                                        child: Text("${state.user.name?.substring(0,1)}"),
                                      ),
                                      label: Text("${state.user.name}"),
                                    );
                                }
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      //const Spacer(),
                      const Divider(),
                      const SizedBox(height: 16.0,),
                      ...items.map((item) => NavigationDrawerDestination(

                        //backgroundColor: Colors.teal.shade700,
                        icon: item.icon,
                        selectedIcon: item.selectedIcon,
                        label: item.label,
                      )).toList(),
                      const SizedBox(height: 16.0,),
                      //const Spacer(),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          BlocProvider.of<NavigationController>(context)
                              .setState(NavigationScreen.myspace);
                          Go.of(context).to(routeName: UserSpaceScreen.routeName);
                          closeDrawer();
                        },
                        horizontalTitleGap: 32.0,
                        style: ListTileStyle.drawer,
                        leading: Ink(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColorLight),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.space_dashboard,
                            ),
                          ),
                        ),
                        title: const Text(
                          "Mon Compte",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        horizontalTitleGap: 32.0,
                        style: ListTileStyle.drawer,
                        leading: Ink(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.more_horiz),
                          ),
                        ),
                        title: const Text(
                          "Plus",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );

                },
              ),

              body: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final NavigationScreen navigationScreen;
  final Widget icon;
  final Widget selectedIcon;
  final Widget label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Key? key;

  const DrawerItem({
    required this.navigationScreen,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.onPressed,
    this.padding,
    this.key,
  });
}
