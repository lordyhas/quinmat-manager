library myspace_page;

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';
//import 'package:flutter/material.dart' show InkWell;
import 'package:qmt_manager/logic/data_test.dart';
import 'package:qmt_manager/logic/values.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard/doctors/doctor_data_tab.dart';
import 'add_product/add_product_page.dart';

part 'my_space/trimester_line_chart.dart';
part 'my_space/monthly_line_chart.dart';
part 'my_space/daily_line_chart.dart';
part 'my_space/data_chart.dart';

class MySpaceScreen extends StatefulWidget {
  static const routeName = "/home/user/my_space";
  static const routeUrl = "/home/user";

  const MySpaceScreen({Key? key}) : super(key: key);

  @override
  State<MySpaceScreen> createState() => _MySpaceScreenState();
}

class _MySpaceScreenState extends State<MySpaceScreen> {
  TextStyle get numStyle =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  TextStyle get textStyle =>
      const TextStyle(color: Colors.white);

  bool underline = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.myspace);
    double boxWidth = 100.0;
    double boxHeight = 60.0;
    final ScrollController scrollController = ScrollController();

    const titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    );

    const subTitleStyle = TextStyle(
      fontSize: 14,
    );

    return ScaffoldPage(
      content: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  constraints: const BoxConstraints(maxWidth: 1280),
                  //const BoxConstraints(maxWidth: kMediumDimens),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 16.0,
                        runSpacing: 8.0,
                        children: [
                          //const SizedBox(height: 32.0,),
                          //const H1("MySpace"),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            constraints: const BoxConstraints(
                              maxWidth: kPhoneDimens,
                            ),
                            height: Responsive.of(context).isPhone ? null : 320,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],
                            ),
                            child: Column(
                              children: [
                                BooleanBuilder(
                                  condition: () =>
                                      state.status ==
                                      AuthenticationStatus.authenticated,
                                  ifTrue: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        "assets/img/profile3.jpg",
                                        height: 75,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text("${state.user.name}"),
                                    subtitle: Text(state.user.email),
                                  ),
                                  ifFalse: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        "assets/img/profile3.jpg",
                                        height: 75,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: const Text("Unknown Name"),
                                    subtitle:
                                        const Text("guest@exploress.org"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 32.0,
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: [
                                    Button(
                                      onPressed: () {},
                                      child: Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        child:  Column(
                                          children: [
                                            const Spacer(),
                                            Text(
                                              "À verifier",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            const Text("18",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                )
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Button(

                                      //borderRadius: BorderRadius.circular(20),
                                      onPressed: () {},
                                      child: Container(
                                        //margin: const EdgeInsets.all(4.0),
                                        height: 50,
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        child: Column(
                                          children: [
                                            const Spacer(),
                                            Text(
                                              "Déjà ajouté",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white.withOpacity(0.7)),
                                            ),
                                            const Text(
                                              "4",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0,),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Button(
                                      //hoverColor:  Colors.teal.light,
                                      //borderRadius: BorderRadius.circular(20),
                                      onPressed: () => Go.to(
                                        context,
                                        routeName: AddProductPage.routeName,
                                      ),
                                      child: Container(
                                        //margin: const EdgeInsets.all(4.0),
                                        height: 45,
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        child: const Column(
                                          children: [
                                            Spacer(),
                                            Text(
                                              "Ajouter un produit",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Button(
                                      //hoverColor:  Colors.teal,
                                      //borderRadius: BorderRadius.circular(20),
                                      onPressed: Go.params(context,
                                        routeName: DoctorDataTableScreen.routeName,
                                      ).push,
                                      child: Container(
                                        //margin: const EdgeInsets.all(4.0),
                                        height: 45,
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        child: const Column(
                                          children: [
                                            Spacer(),
                                            Text(
                                              "Database docteur",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          //const SizedBox(height: 16.0,),
                          Container(
                            //constraints: const BoxConstraints(maxHeight: 200),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            constraints:
                                const BoxConstraints(maxWidth: kPhoneDimens),
                            height: Responsive.of(context).isPhone ? 400 : 320,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/img/bg_material_2.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20),
                              //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],
                            ),

                            child: SizedBox(
                              child: Column(
                                children: [
                                  const Row(),
                                  const Spacer(),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints: const BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: boxWidth,
                                          height: boxHeight,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Vue",
                                                style: textStyle,
                                              ),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "4",
                                                    style: numStyle,
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints: const BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: boxWidth,
                                          height: boxHeight,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Check",
                                                style: textStyle,
                                              ),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "496",
                                                    style: numStyle,
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints: const BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: boxWidth,
                                          height: boxHeight,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Deprtmnt",
                                                style: textStyle,
                                              ),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Quin",
                                                      style: numStyle),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints:
                                        const BoxConstraints(maxWidth: 150),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: boxWidth,
                                          height: boxHeight,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Niveau",
                                                style: textStyle,
                                              ),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "3", style: numStyle),
                                                  const TextSpan(
                                                    text: "LVL",
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints:
                                        const BoxConstraints(maxWidth: 150),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: boxWidth,
                                          height: boxHeight,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Frais",
                                                style: textStyle,
                                              ),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "4", style: numStyle),
                                                  const TextSpan(
                                                    text: "\$",
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints:
                                        const BoxConstraints(maxWidth: 150),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: SizedBox(
                                          width: boxWidth,
                                          height: boxHeight,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Gain",
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.7),
                                                ),
                                              ),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "1250",
                                                    style: numStyle,
                                                  ),
                                                  const TextSpan(
                                                    text: "\$",
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  //const Spacer(),
                                  //const ListTile(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                        ),
                        //constraints: const BoxConstraints(maxWidth: 1220),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                "Statistiques hebdomadaire",
                                style: titleStyle
                              ),
                              subtitle: const Text("sur les transactions",
                                style: subTitleStyle,),
                              trailing: HyperlinkButton(
                                onPressed: (){},
                                child: const Icon(FluentIcons.view, size: 18,),
                              ),
                            ),
                            SizedBox(
                              height: 400,
                              child: Card(
                                //padding: EdgeInsets.all(0.8),
                                borderColor: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                backgroundColor : Colors.grey[160]
                                    .withOpacity(0.2),
                                child: LineChart(
                                  DataChart.lineCharData(),
                                  duration: const Duration(milliseconds: 100), // Optional
                                  curve: Curves.bounceIn, // Optional
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                "Statistiques Mensuel et Jounalier",
                                style: titleStyle,
                              ),
                              subtitle: const Text("sur les transactions",
                                style: subTitleStyle,
                              ),
                              trailing: HyperlinkButton(
                                onPressed: (){},
                                child: const Icon(FluentIcons.view, size: 18,),
                              ),
                            ),
                            SizedBox(
                              //height: 300,
                              child: Wrap(
                                spacing: 16.0,
                                runSpacing: 16.0,
                                children: [
                                  Container(
                                    height: 270,
                                    //width:400,
                                    constraints: const BoxConstraints(maxWidth: 550),
                                    child: Card(
                                      borderColor: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                        child: LineChartSample4(),
                                    ),
                                  ),

                                  Container(
                                    height: 270,
                                    //width: 400,
                                    constraints: const BoxConstraints(maxWidth: 680),
                                    child: Card(
                                      borderColor: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                        child: LineChartSample5(
                                          gradientColor1: Colors.blue,
                                          gradientColor2: Colors.green,
                                          gradientColor3: Colors.orange,
                                          indicatorStrokeColor: Colors.orange,
                                        ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                "Statistiques trimestriel",
                                style: titleStyle,
                              ),
                              subtitle: const Text("sur les transactions",
                                style: subTitleStyle,),
                              trailing: HyperlinkButton(
                                onPressed: (){},
                                child: const Icon(FluentIcons.view, size: 18,),
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: Card(
                                borderColor: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                  child: const _LineChart(isShowingMainData: false,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //constraints: const BoxConstraints(maxHeight: 200),
                        //margin: const EdgeInsets.symmetric(vertical: 0.0),
                        //padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        /*constraints: Responsive.of(context).size.width > 1363
                                ? null
                                : const BoxConstraints(maxWidth: kPhoneDimens),*/
                        //height: 300,
                        decoration: const BoxDecoration(
                          //border: Border.all(color: Colors.white),
                          //borderRadius: BorderRadius.circular(20),
                          //boxShadow: [BoxShadow(color: Theme.of(context).primaryColorLight)],
                        ),

                        child: SizedBox(
                          child: Column(
                            children: [
                              //const SizedBox(height: 1, child: Expanded(child: SizedBox(width: 10,),),),
                              ListTile(
                                title: const Text(
                                  "Mes Produits",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text("Seulement les produits que vous avez ajouté sont visible depuis votre compte"),
                                trailing: HyperlinkButton(
                                  onPressed: (){},
                                  child: const Text("Voir tout"),),
                              ),
                              Wrap(children: dataTestList,),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0,),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> get dataTestList => ItemDataTest.items
      .map((e) => SizedBox(
            width: 400,
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Image.asset(
                e.imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                e.name,
                style: const TextStyle(),
              ),
              subtitle: Text(
                "Prix: ${(Random().nextInt(40) + 20 * (e.raters * e.ratings)).toInt()}\$",
              ),
              onPressed: () {},
            ),
          ))
      .toList();
}
