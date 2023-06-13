//part of home_page;


import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qmt_manager/logic/values.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool underline = false;

  /*double h1Size() {
    if (Responsive.of(context).isPhone) {
      return 28;
    } else if (Responsive.of(context).size.width < 720) {
      return 28;
    } else if (Responsive.of(context).size.width < 854) {
      return 28;
    } else if (Responsive.of(context).size.width < 1080) {
      return 32;
    } else if (Responsive.of(context).size.width < 1280) {
      return 42;
    } else if (Responsive.of(context).size.width < 1680) {
      return 54;
    } else if (Responsive.of(context).size.width < 1920) {
      return 54;
    }
    return 18;
  }*/

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.home);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.home);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          //height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 32),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    //height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        //image: AssetImage("assets/img/bg_image2.jpg"),
                        image: AssetImage("assets/img/qmt-batiment.jpg"),
                        fit: BoxFit.cover,
                        opacity: 5.0,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                const ListTile(
                                  title: SelectableText(
                                    "Bienvenue dans ${AppConstant.name}",
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  subtitle: SelectableText(
                                    "Faire la gestion des produits",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0)
                                      .copyWith(top: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FilledButton(
                                        /*style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),*/
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Créér un compte",
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                      SizedBox(width: 8.0,),
                                      HyperlinkButton(

                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text.rich(TextSpan(children: [
                                            TextSpan(
                                              text: "Besoin d'aide",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  //letterSpacing: underline ? .0 : null,
                                                  decoration: underline
                                                      ? TextDecoration
                                                          .underline
                                                      : TextDecoration.none),
                                            ),
                                            const TextSpan(
                                              text: " ?",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ])),
                                        ),
                                        /*onHover: (value) {
                                          setState(() {
                                            underline = value;
                                          });
                                        },*/
                                        onPressed: () {
                                          //Go.of(context).to(routeName: DataTableDemo.routeName);
                                        },
                                        onLongPress: () {},
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    //height: 250,
                    color: Colors.black,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Image.asset("assets/img/vector_mg1.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Image.asset("assets/img/vector_mg2.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //Image.asset("assets/img/vector_mg2.jpg"),

                            ],
                          ),
                          Container(
                            //height: 200,
                            color: Colors.black.withOpacity(0.6),
                            child: const SizedBox(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8.0,
                                ),
                                ListTile(
                                  title: SelectableText(
                                    "Tableau de bore du Gestionaire : ${AppConstant.name}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                    ),
                                  ),
                                  subtitle: SelectableText(
                                    "Faire la gestion des produits, tout gérer sur un écran",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                /*shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),*/
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        //visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                        //  titleAlignment: ListTileTitleAlignment.center,
                        //horizontalTitleGap: 32.0,
                        leading: const Icon(
                          cup.CupertinoIcons.home,
                        ),
                        title: const SelectableText(
                          "Mobiler",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: const Icon(cup.CupertinoIcons.chevron_right_2),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        //visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                        //horizontalTitleGap: 32.0,
                        leading: const Icon(
                          cup.CupertinoIcons.rectangle_stack_fill,
                        ),
                        title: const SelectableText(
                          "Papeterie",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: const Icon(cup.CupertinoIcons.chevron_right_2),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        //visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                        //horizontalTitleGap: 32.0,
                        leading: const Icon(
                          cup.CupertinoIcons.car_detailed,
                          //size: 42,
                        ),
                        title: const SelectableText(
                          "Quaincaillerie",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: const Icon(cup.CupertinoIcons.chevron_right_2),
                        onPressed: () {},
                      ),
                      ListTile(
                        //visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                        //horizontalTitleGap: 32.0,
                        leading: const Icon(
                          FontAwesomeIcons.kitMedical,
                          //size: 42,
                        ),
                        title: const SelectableText(
                          "Medical Equipment",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),

                        trailing: const Icon(cup.CupertinoIcons.chevron_right_2),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
