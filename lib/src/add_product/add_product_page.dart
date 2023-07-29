library products.adder;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
//import 'package:flutter/cupertino.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:flutter/material.dart' show Material, Stepper, Step, ControlsDetails, ButtonBar, Radio;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../widgets/radio_group.dart';
//import 'package:utils_component/utils_component.dart' hide Go;

part 'add_verification.dart';

part 'add_upload_image.dart';

part 'add_form.dart';

enum StepperStep { zero, one, two}

class AddProductPage extends StatelessWidget {
  static const routeName = "form";

  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      //backgroundColor: Colors.grey.shade800,
      appBar: NavigationAppBar(
        leading: IconButton(
          icon: const Icon(FluentIcons.cancel),
          onPressed: () => Go.of(context).pop,
        ),
        title: const Text("Ajouter un produit "),
      ),
      content: const TabViewPage(),
    );
  }
}

class TabViewPage extends StatefulWidget {
  const TabViewPage({Key? key}) : super(key: key);

  @override
  State<TabViewPage> createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage> {
  int currentIndex = 0;
  List<Tab> tabs = [];

  Tab generateTab(int index) {
    late Tab tab;
    tab = Tab(
      key: UniqueKey(),
      text: Text('Add product sheet  $index'),
      semanticLabel: 'Add product page #$index',
      icon: const Icon(FluentIcons.product_release),
      body: Container(
        margin: null,
        child: AddProductScreen(
          key: UniqueKey(),
          title: "Product Sheet $index",
        ),
      ),
      onClosed: () {
        setState(() {
          tabs.remove(tab);
          if (currentIndex > 0) currentIndex--;
        });
      },
    );
    return tab;
  }

  void addTab(){
    final index = tabs.length + 1;
    final tab = generateTab(index);
    tabs.add(tab);
    //debugPrint("tab added");
  }
  @override
  void initState() {
    super.initState();
    addTab();
  }
  @override
  Widget build(BuildContext context) {

    return TabView(
      tabs: tabs,
      currentIndex: currentIndex,
      onChanged: (index) => setState(() => currentIndex = index),
      tabWidthBehavior: TabWidthBehavior.equal,
      closeButtonVisibility: CloseButtonVisibilityMode.always,
      showScrollButtons: true,
      //wheelScroll: false,
      onNewPressed: () {
        setState(() {
          addTab();
        });
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = tabs.removeAt(oldIndex);
          tabs.insert(newIndex, item);

          if (currentIndex == newIndex) {
            currentIndex = oldIndex;
          } else if (currentIndex == oldIndex) {
            currentIndex = newIndex;
          }
        });
      },
    );;
  }
}


class AddProductScreen extends StatefulWidget {
  final String title;
  const AddProductScreen({required this.title, Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late StepperStep _index;
  CroppedFile? croppedFile;
  final GlobalKey<FormState> validator = GlobalKey<FormState>();
  late final List<TextEditingController> controllers;
  //late final Map<String, TextEditingController> spaceCtrl;
  late final Map<String, TextEditingController> vehicleCtrl;

  @override
  void initState() {
    Product vehicle = Product.empty;
    super.initState();
    _index = StepperStep.zero;
    controllers = List<TextEditingController>.generate(
        10, (index) => TextEditingController());
    //.filled(10, TextEditingController());

    vehicleCtrl = vehicle
        .toMap()
        .map((key, value) => MapEntry(key, TextEditingController()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: FluentTheme.of(context).cardColor,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 16.0),
          width: 720,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 720,
                    child: Card(
                      margin: EdgeInsets.all(16.0).copyWith(left: 32.0),
                      padding: EdgeInsets.all(16.0),
                      borderColor: Colors.white,
                        child: Text(widget.title, style: const TextStyle(fontSize: 20),),
                    ),
                  ),
                ],
              ),
              Stepper(
                currentStep: _index.index,
                onStepCancel: () {
                  switch (_index) {
                    case StepperStep.zero:
                      break;
                    case StepperStep.one:
                      setState(() {
                        _index = StepperStep.zero;
                      });
                      break;
                    case StepperStep.two:
                      setState(() {
                        _index = StepperStep.one;
                      });
                      break;
                  }
                },
                onStepContinue: () {
                  switch (_index) {
                    case StepperStep.zero:
                      if (validator.currentState!.validate()) {
                        validator.currentState!.save();
                        //context.watch<RentalControllerBloc>();

                        setState(() {
                          _index = StepperStep.one;
                        });
                      }
                      break;
                    case StepperStep.one:
                      if (croppedFile.isNull) break;

                        Product vehicle = context
                            .read<ProductControllerBloc>()
                            .state
                            .product
                            .copyWith(images: [croppedFile!.path]);
                        context
                            .read<ProductControllerBloc>()
                            .addProductImaged(vehicle);


                      setState(() {
                        _index = StepperStep.two;
                      });
                      break;
                    case StepperStep.two:
                      //setState((){_index = StepperStep.one;});
                      break;
                  }
                },
                onStepTapped:
                (int index) {
                      setState(() {
                        _index = StepperStep.values[index];
                      });
                    },
                controlsBuilder: (BuildContext context, ControlsDetails controls) {
                  return SizedBox(
                    width: 520,
                    /*constraints: const BoxConstraints(
                      maxWidth: 520.0,
                    ),*/
                    child: Row(
                      children: [
                        Button(
                            onPressed: controls.onStepContinue,
                            child: const Text('Suivant')),
                        const SizedBox(width: 8.0,),
                        TextButton(
                          onPressed: controls.onStepCancel,
                          child:
                              Text(controls.currentStep == 0 ? 'Annulé' : 'Précédant'),
                        ),
                        //const Spacer(),
                      ],
                    ),
                  );
                },
                steps: <Step>[
                  Step(
                    title: const Text("Info à propos "),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        child: ProductForm(
                          productController: vehicleCtrl,
                          validator: validator,
                          onComplete: (_) {},
                          onValidForm: (_) {},
                        ),
                      ),
                    ),
                  ),
                  Step(
                    title: const Text('Téléversé l\'image'),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: UploadImage(
                            onUploaded: (file) {
                              setState(() {
                                croppedFile = file;
                              });
                              //print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
                              //print(croppedFile!.path);
                            },
                          ),
                        )),
                  ),
                  Step(
                    title: const Text('Vérfication'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 540,
                        child: BooleanBuilder(
                          condition: () => false,
                          ifTrue: const SizedBox.shrink(),
                          ifFalse: Column(
                            children: [
                              if (context
                                  .read<ProductControllerBloc>()
                                  .product
                                  .images
                                  .isNotEmpty)
                                SizedBox(
                                  height: 320,
                                  width: 320,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Responsive.of(context).isOnlyWeb
                                            ? Image.network(context
                                                .read<ProductControllerBloc>()
                                                .product
                                                .images
                                                .first)
                                            : Image.file(File(context
                                                .read<ProductControllerBloc>()
                                                .product
                                                .images
                                                .first)),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Row(
                                children: [
                                  Builder(builder: (context) {
                                    final val =
                                        context.read<ProductControllerBloc>().product;
                                    return Text.rich(TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Titre : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(text: "${val.name} \n"),
                                        const TextSpan(
                                          text: "Description : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(text: "${val.description} \n"),
                                        const TextSpan(
                                          text: "Pièce(s) : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(text: "${val.promotionPrice} \n"),
                                        const TextSpan(
                                          text: "Prix : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(text: "${val.price} \n"),
                                        const TextSpan(
                                          text: "Catégorie :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                            text: "${val.productType.name} \n"),
                                      ],
                                    ));
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
