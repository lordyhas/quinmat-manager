import 'dart:math';

import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/utils.dart';


class ItemDataTest {
  static List<Product> products = [
    Product(
      name: "Crazy Horse Brown",
      id: "prole123",
      images: ["assets/qp/product (1).jpg"],
      model: "",
      description: "",
      productType: ProductType.unknown,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Rebel Safety Gear",
      id: "prole2",
      images: ["assets/qp/product (2).jpg"],
      model: "",
      description: "",
      productType: ProductType.QCL,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "YATO Drilling machine",
      id: "prole3",
      images: ["assets/qp/product (3).jpg"],
      model: "",
      description: "",
      productType: ProductType.QCL,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Peinture",
      id: "prole4",
      images: ["assets/qp/product (4).jpg"],
      model: "",
      description: "",
      productType: ProductType.QCL,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Pipes Quinmat",
      id: "prole5",
      images: ["assets/qp/product (5).jpg"],
      model: "",
      description: "",
      productType: ProductType.QCL,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Polyethylene compression fittings",
      id: "prole6",
      images: ["assets/qp/product (6).jpg"],
      model: "",
      description: "",
      productType: ProductType.QCL,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "GI & PVC fittings",
      id: "prole7",
      images: ["assets/qp/product (7).jpg"],
      model: "",
      description: "",
      productType: ProductType.QCL,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Papeterie",
      id: "prole8",
      images: ["assets/qp/product (8).jpg"],
      model: "",
      description: "",
      productType: ProductType.PAP,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Canapé",
      id: "prole9",
      images: ["assets/qp/product (9).jpg"],
      model: "",
      description: "",
      productType: ProductType.MOB,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Bureau, une chaise",
      id: "prole10",
      images: ["assets/qp/product (10).jpg"],
      model: "",
      description: "",
      productType: ProductType.MOB,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Bureau, plusieurs chaise",
      id: "prole11",
      images: ["assets/qp/product (11).jpg"],
      model: "",
      description: "",
      productType: ProductType.MOB,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Lit d'hopital, Medical",
      id: "prole12",
      images: ["assets/qp/product (12).jpg"],
      model: "",
      description: "",
      productType: ProductType.MED,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "IRM Medical Equipment",
      id: "prole13",
      images: ["assets/qp/product (13).jpg"],
      model: "",
      description: "",
      productType: ProductType.MED,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      name: "Diagnostic Medical Equipment",
      id: "prole14",
      images: ["assets/qp/product (14).jpg"],
      model: "",
      description: "",
      productType: ProductType.MED,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      id: 'BoutiqueGrandBoss1234',
      name: 'Salle de reunion',
      images: ["assets/local/loc_reunion_1.png"],
      model: "",
      description: "",
      productType: ProductType.unknown,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      id: 'QS1234',
      name: 'Salle à manger',
      images: ["assets/local/loc_restau_1.jpg"],
      model: "",
      description: "",
      productType: ProductType.unknown,
      price: Random().nextInt(500) + 20,
    ),

    Product(
      id: 'VIPQS1234',
      name: 'Salle de reunion (VIP)',
      images: ["assets/local/loc_reunion_2.jpg"],
      model: "",
      description: "",
      productType: ProductType.unknown,
      price: Random().nextInt(500) + 20,
    ),


  ];
  static List<ItemData> items = products.map((p) =>
      ItemData(
        name: p.name,
        id: p.id,
        imagePath: p.images.first,
        ratings: (3 + 3 + 4 + 5 + 2),
        raters: 5,
        phoneNumber: "+243 998731145",
        phoneNumber2: "+243 848731145",
        canDeliver: true,
        location: null,
        department: p.productType.name.isEmpty
            ? "${AppConstant.shortname} L'shi"
            : p.productType.name,
        product: p,
      ), ).toList();


}
