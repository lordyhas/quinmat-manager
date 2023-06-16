import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qmt_manager/logic/access_controller/access_controller_cubit.dart';

import 'package:qmt_manager/logic/values.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:qmt_manager/routes.dart';

import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'logic/maps_controller/maps.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  //GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  Bloc.observer = AppBlocObserver();
  //Hive.initFlutter();

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(InitApp(
        authRepository: AuthenticationRepository(),
      )));
}

class InitApp extends StatelessWidget {
  const InitApp({
    required this.authRepository,
    Key? key,
  }) : super(key: key);

  final AuthenticationRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authRepository: authRepository,
        ),
        child: QuinmatApp(),
      ),
    );
  }
}

class QuinmatApp extends StatelessWidget {
  QuinmatApp({super.key});

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "rootKey");

  //final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "shellKey");

  void _checkSomePermissions() async {
    if (kIsWeb) return;
    //Map<Permission, PermissionStatus> statuses =
    await [
      Permission.location,
      Permission.storage,
      //Permission.camera,
      //Permission.locationAlways,
    ].request();
    //debugPrint("===== Permissions : ${statuses[Permission.storage]}");
  }

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

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) _checkSomePermissions();
    checkConnect();
    return MultiBlocProvider(
      providers: [
        BlocProvider<StyleAppTheme>(
          create: (context) => StyleAppTheme(),
        ),
        BlocProvider<AccessController>(
          create: (context) => AccessController(),
        ),
        BlocProvider<MapsBloc>(
          create: (context) => MapsBloc(),
        ),
        BlocProvider<NavigationController>(
          create: (context) => NavigationController(),
        ),
        BlocProvider<ProductControllerBloc>(
          create: (context) => ProductControllerBloc(),
        ),
        BlocProvider<FilterCubit>(
          create: (context) => FilterCubit(),
        ),
      ],
      child: BlocBuilder<StyleAppTheme, FluentThemeData>(
        builder: (context, theme) {
          return FluentApp.router(
            //key: _shellNavigatorKey,
            debugShowCheckedModeBanner: false,
            title: AppConstant.markName,
            theme: theme,
            //supportedLocales: const <Locale>[Locale('fr')],
            routerConfig: AppRouter(
              key: _rootNavigatorKey,
            ),
          );
        },
      ),
    );
  }
}
