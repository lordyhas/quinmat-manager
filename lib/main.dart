import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qmt_manager/logic/values.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:qmt_manager/routes.dart';

import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'logic/maps_controller/maps.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );*/

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

  //NavigatorState get _navigator => _navigatorKey.currentState!;

  void _checkSomePermissions() async {
    if (kIsWeb) return;
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      //Permission.camera,
      //Permission.locationAlways,
    ].request();
    debugPrint("===== Permissions : ${statuses[Permission.storage]}");
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) _checkSomePermissions();

    return MultiBlocProvider(
      providers: [
        BlocProvider<StyleAppTheme>(
          create: (context) => StyleAppTheme(),
        ),
        BlocProvider<MapsBloc>(
          create: (context) => MapsBloc(),
        ),
        BlocProvider<NavigationController>(
          create: (context) => NavigationController(),
        ),
        BlocProvider<RentalControllerBloc>(
          create: (context) => RentalControllerBloc(),
        ),
        BlocProvider<FilterCubit>(
          create: (context) => FilterCubit(
            const Filter.values(
                maxPrice: 600.0,
                minPrice: 50,
                maxDistance: 5.0,
                minDistance: 0.0,
                categoryList: []),
          ),
        ),
      ],
      child: BlocBuilder<StyleAppTheme, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(

            debugShowCheckedModeBanner: false,
            title: AppConstant.markName,

            theme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: "Nunito",
            ).copyWith(

              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColorLight: Colors.teal.shade400,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.cyan.withOpacity(1),
              ),
            ),
            //supportedLocales: const <Locale>[Locale('fr')],
            routerConfig: AppRouter(key: _rootNavigatorKey,),
          );
        },
      ),
    );
  }
}
