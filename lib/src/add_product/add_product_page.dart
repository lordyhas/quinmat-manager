library products.adder;

import 'dart:async';
import 'dart:io';

import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
//import 'package:utils_component/utils_component.dart' hide Go;

part 'add_verification.dart';

part 'add_upload_image.dart';

part 'add_form.dart';

enum StepperStep { zero, one, two }

class AddProductPage extends StatelessWidget {
  static const routeName = "form";

  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: Go.of(context).pop,
        ),
        title: const Text("Ajouter un produit "),
      ),
      body: const AddProductScreen(),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

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
    //RentalSpace space = RentalSpace.empty;
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

    return Container(
      //color: Colors.grey[160],
      child: SizedBox(
        width: 720,
        child: Stepper(
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
                      .read<RentalControllerBloc>()
                      .state
                      .product
                      .copyWith(images: [croppedFile!.path]);
                  context
                      .read<RentalControllerBloc>()
                      .addVehicleRentalImaged(vehicle);


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
            return Container(
              constraints: const BoxConstraints(
                maxWidth: 520.0,
              ),
              child: ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: controls.onStepContinue,
                      child: const Text('Suivant')),
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child:
                        Text(controls.currentStep == 0 ? 'Annulé' : 'Précédant'),
                  ),
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
                  child: RentForm(
                    controllers: controllers,
                    //spaceController: spaceCtrl,
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
                    condition: () =>
                        context.read<RentalControllerBloc>().isImmovable,
                    ifTrue: Column(
                      children: [
                        /*if (context
                            .read<RentalControllerBloc>()
                            .space
                            .images
                            .isNotEmpty)
                          SizedBox(
                            height: 320,
                            width: 320,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Responsive.of(context).isOnlyWeb
                                      ? Image.network(context
                                          .read<RentalControllerBloc>()
                                          .space
                                          .images
                                          .first)
                                      : Image.file(File(context
                                          .read<RentalControllerBloc>()
                                          .space
                                          .images
                                          .first)),
                                ),
                              ),
                            ),
                          ),*/
                        const SizedBox(
                          width: 16.0,
                        ),
                        Row(
                          children: [
                            Builder(builder: (context) {
                              final val = context
                                  .read<RentalControllerBloc>()
                                  .state
                                  .product;
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
                                  TextSpan(text: "${val.stockNumber} \n"),
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
                                      text: "${Product.departments[val.productType]} \n"),
                                ],
                              ));
                            }),
                          ],
                        ),
                      ],
                    ),
                    ifFalse: Column(
                      children: [
                        if (context
                            .read<RentalControllerBloc>()
                            .vehicle
                            .images
                            .isNotEmpty)
                          SizedBox(
                            height: 320,
                            width: 320,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Responsive.of(context).isOnlyWeb
                                      ? Image.network(context
                                          .read<RentalControllerBloc>()
                                          .vehicle
                                          .images
                                          .first)
                                      : Image.file(File(context
                                          .read<RentalControllerBloc>()
                                          .vehicle
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
                                  context.read<RentalControllerBloc>().vehicle;
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
                                      text: "${Product
                                          .departments[val.productType]} \n"),
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
      ),
    );
  }
}
