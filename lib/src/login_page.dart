library login_page;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/src/dashboard/home_screen.dart';
import 'package:qmt_manager/widgets/widgets.dart';

import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/foundation.dart';

//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:qmt_manager/logic/values.dart';

part 'login_page/login_form.dart';
part 'login_page/button_and_input.dart';



class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  static const routeUrl = '/login';

  const   LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  bool  underline = true;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool createAccount = false;



  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: FluentTheme.of(context).scaffoldBackgroundColor,
      ));
    }
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            GoRouter.of(context).goNamed(HomeScreen.routeName);
            break;
          default: break;
        }
      },
      child: BlocProvider(
        create: (_) => LoginCubit(
          context.read<AuthRepository>(),
        ),
        child: BackgroundUI(
          child: ScaffoldPage(
            //backgroundColor: Colors.transparent,
            //resizeToAvoidBottomInset: false,
            //extendBodyBehindAppBar: true,
            content: ScrollConfiguration(
              behavior: MyScrollBehaviorBehavior(),
              child: SizedBox(
                child: Container(
                  height: size.height,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[170].withOpacity(0.0),
                        Colors.grey[170].withOpacity(0.1),
                        Colors.grey[170].withOpacity(0.3),
                        Colors.grey[170].withOpacity(0.5),
                        Colors.grey[170].withOpacity(0.7),
                        Colors.grey[170].withOpacity(0.9),
                        Colors.grey[170].withOpacity(1),
                        Colors.grey[170].withOpacity(1),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: !kIsWeb? null : const NeverScrollableScrollPhysics(),
                    child: BlocListener<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state.status.isSubmissionFailure) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          displayInfoBar(context, builder: (context, close) {
                            return InfoBar(
                              title: const Text('Something goes wrong :/'),
                              content: const Text(
                                  'Authentication Failure :/'),
                              action: IconButton(
                                icon: const Icon(FluentIcons.clear),
                                onPressed: close,
                              ),
                              severity: InfoBarSeverity.warning,
                            );
                          });

                          /*ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Authentication Failure'),
                              ),
                            );*/
                        }
                      },
                      child: Opacity(
                        opacity: _opacity.value,
                        child: Transform.scale(
                          scale: _transform.value,
                          child: Container(
                            constraints: kLoginBoxConstraints,
                            width: size.width * .9,
                            height:kIsWeb ? size.height * 0.8 : 620,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.8),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(.1),
                                  blurRadius: 90,
                                ),
                              ],
                            ),
                            child: _form,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _form => Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(),
            child: Image.asset(
              'assets/icon_app.png',
              //color: Theme.of(context).primaryColor.withOpacity(0.85),
              height: 95,
            ),
          ),
          const Row(
            children: [
              SizedBox(),
              Spacer(),
              SelectableText(
                "Welcome to ${AppConstant.name}",
                //'Welcome to Tsheleka KodishApp',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  //color: Theme.of(context).primaryColor.withOpacity(.7),
                ),
              ),
              Spacer(),

              SizedBox(),
            ],
          ),
          const SizedBox(),
          const _EmployeeInput(
            key: Key('loginForm_employeeInput'),
          ),
          const _EmailInput(
            key: Key('loginForm_emailInput'),
          ),
          const _PasswordInput(
            key: Key('loginForm_passwordInput'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ButtonLogin(text: 'Connecter',),
              SizedBox(width: MediaQuery.of(context).size.width / 25),
              Container(
                //width: 150,
                  alignment: Alignment.center,
                  child: HoverButton(
                    onPressed: (){
                      Log.i('Forgotten password! button pressed',);
                      showDialog(
                        context: context,
                        builder: (context){
                          return ContentDialog(
                            actions: [
                              Button(
                                onPressed: GoRouter.of(context).pop,
                                child: const Text("Understand"),
                              ),
                              FilledButton(
                                onPressed: GoRouter.of(context).pop ,
                                child: const Text("Cancel"),
                              ),
                            ],
                            content: SizedBox(
                              height: 200,
                              width: 350,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Image.asset(
                                    'assets/icon_app.png',
                                    //color: Theme.of(context).primaryColor.withOpacity(0.85),
                                    height: 100,
                                  ),
                                  const Spacer(),
                                  const Text("You forgot the password, contact the Admin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0,),
                                  Text("info@exploress.space",
                                    style: TextStyle(
                                      color: Colors.teal.light,
                                    ),
                                  ),
                                  const Spacer(),

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    onLongPress: (){
                      GoRouter.of(context).goNamed(
                          HomeScreen.routeName
                      );
                    },

                    /*onHover: (value){
                      setState(() {
                        underline = value;
                      });
                    },*/
                    builder: (BuildContext context, Set<ButtonStates> state) {
                      return RichText(
                        text: TextSpan(
                          text: 'Mot de passe oublié !',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: underline
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                          //mouseCursor: SystemMouseCursors.
                          //recognizer: TapGestureRecognizer()..onTap = ,
                        ),
                      );
                    },

                  )
              )
            ],
          ),
          //const SizedBox(),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 32.0
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GoogleLoginButton(),
                SizedBox(height: 8.0,),
                _FacebookLoginButton(),
              ],
            ),
          ),
          // const SizedBox(),
          RichText(
            text: const TextSpan(
              text: 'S\'enregistrer',
              style: TextStyle(
                //color: Colors.white70, //Theme.of(context).primaryColor.withOpacity(.8),
                fontSize: 15,
              ),
              //recognizer: TapGestureRecognizer()..onTap = (){},
              //mouseCursor: SystemMouseCursors.text,
            ),
          ),
          const SizedBox(),
        ],
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: !kIsWeb ? IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.gear_solid,
                color: Colors.white,
                size: 24,
              )
          ) : null,
        ),
      ),
    ],
  );




}



