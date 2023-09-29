import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qmt_manager/logic/transfer_protocol/http_protocol.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logic/model/data_model.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  static const routeUrl = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool underline = false;

  Bill bill = Bill(productId: 0);

  final GlobalKey<FormState> validatorForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.home);
  }
  int? productId;
  int? customerId;
  int? quantity;
  String? phone;
  String? regno;

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.home);
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1280),
            //height: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 32),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white,),
                    ),
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
                          filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                color: Colors.black.withOpacity(0.8),
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
                                                "Ajouter un client",
                                              ),
                                            ),
                                            onPressed: () {
                                              launchUrl(Uri.parse("${BackendServer.weburl}/register"));
                                            },
                                          ),
                                          const SizedBox(width: 8.0,),
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
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                    borderColor: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Form(
                        key: validatorForm,
                        child: Column(
                          children: [
                            const ListTile(
                              title: SelectableText(
                                "Faire la facture",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Wrap(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 300),
                                  child:  Wrap(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: InfoLabel(
                                          label:"No du client",
                                          child: TextFormBox(
                                            placeholder:"Entrez le no",
                                            onEditingComplete: (){},
                                            onChanged: (value) {
                                              print("XXXXXXXXXX");
                                              setState(() {
                                                customerId = value.toInt();
                                                bill.copyWith(customerId: value.toInt());
                                              });
                                            },
                                            onSaved: (String? value) {


                                            },
                                            validator: (v) {
                                              if (v!.isEmpty) return null;
                                              if (v.isNotNumeric) {
                                                return 'No doit être en chiffre.';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: InfoLabel(
                                          label:"Numéro du produits *",
                                          child: TextFormBox(
                                            placeholder:"No produit",
                                            onEditingComplete: (){},
                                            onChanged: (value) {
                                              print("XXXXXXXXXX");
                                              setState(() {
                                                productId = value.toInt();
                                                bill.copyWith(productId: value.toInt());
                                              });
                                            },
                                            onSaved: (String? value) {
                                            },
                                            validator: (v) {
                                              if (v!.isEmpty) return 'No est requis.';
                                              if (v.isNotNumeric) return 'No doit être en chiffre.';
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 300),
                                  child:  Wrap(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: InfoLabel(
                                          label:"Quantité d'item *",
                                          child: TextFormBox(
                                            placeholder:"Entrez la qté",
                                            onEditingComplete: (){},
                                            onChanged: (value) {
                                              print("XXXXXXXXXX");
                                              setState(() {
                                                quantity = value.toInt();
                                                bill.copyWith(quantity: value.toInt());
                                              });
                                            },
                                            onSaved: (String? value) {

                                            },
                                            validator: (v) {
                                              if (v!.isEmpty) return 'Qté est requis.';
                                              if (v.isNotNumeric) return 'Qté doit être en chiffre.';
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: InfoLabel(
                                          label:"Matricule employé",
                                          child: TextFormBox(
                                            placeholder:"Entrez le matricule",
                                            onEditingComplete: (){},
                                            onChanged: (value) {
                                              setState(() {
                                                regno = value;
                                                bill.copyWith(regno: value);
                                              });
                                            },
                                            onSaved: (String? value) {


                                            },
                                            validator: (v) {
                                              //if (v!.isEmpty) return 'Matricule est requis.';
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 300),
                                  child:  Wrap(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: InfoLabel(
                                          label:"Numéro de telephone ",
                                          child: TextFormBox(
                                            placeholder:"Entrez le contact",
                                            onEditingComplete: (){},
                                            onChanged: (value) {
                                              setState(() {
                                                phone = value;
                                                bill.copyWith(phone: value);
                                              });
                                            },
                                            onSaved: (String? value) {

                                            },
                                            validator: (v) {
                                              //if (v!.isEmpty) return 'Phone est requis.';
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: InfoLabel(
                                          label:"Matricule employé",
                                          child: TextFormBox(
                                            placeholder:"Entrez le matricule",
                                            onEditingComplete: (){},
                                            onChanged: (str) {},
                                            onSaved: (String? value) {
                                              //bill.copyWith(regno: value);
                                            },
                                            validator: (v) {
                                              //if (v!.length < 3) return 'Modèle est requis.';
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16.0,
                              ),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  FilledButton(
                                    onPressed: (){
                                      if(validatorForm.currentState!.validate()){
                                        if(customerId == null &&
                                            productId == null &&
                                            quantity == null ) return;

                                        final bill = Bill(
                                          productId: productId ?? 0,
                                          customerId: customerId ?? 1,
                                          quantity: quantity ?? 0,
                                          phone: phone,
                                          regno: regno,
                                        );
                                        final http = BackendServer(
                                            "/transactions",
                                            data: bill.toMap()
                                        );

                                        print(bill.toMap());

                                        http.post().then((status) {
                                          if(status){
                                            displayInfoBar(context, builder: (context, close) {
                                              return InfoBar(
                                                title: const Text('Succés :)'),
                                                content: const Text(
                                                    'Facture enregistré avec succés :)'),
                                                action: IconButton(
                                                  icon: const Icon(FluentIcons.check_mark),
                                                  onPressed: close,
                                                ),
                                                severity: InfoBarSeverity.warning,
                                              );
                                            });
                                          }else{
                                            displayInfoBar(context, builder: (context, close) {
                                              return InfoBar(
                                                title: const Text('Echec :/'),
                                                content: const Text(
                                                    'Facture non enregistré :/'),
                                                action: IconButton(
                                                  icon: const Icon(FluentIcons.clear),
                                                  onPressed: close,
                                                ),
                                                severity: InfoBarSeverity.warning,
                                              );
                                            });
                                          }
                                        });
                                      }
                                    },
                                    child: const Text("Faire la facture"),
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
                                      "Tableau de bord du Gestionaire : ${AppConstant.name}",
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
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                    borderColor: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            //visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                            //titleAlignment: ListTileTitleAlignment.center,
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
                              "Electronique ",
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
                              "Autres",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
