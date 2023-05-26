
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
//import 'package:latlong2/latlong.dart' as dist;

import 'package:qmt_manager/logic/model/data_model.dart';


class DataTest {
  static List<ItemData> shops = [
    ItemData(
      name: "Crazy Horse Brown",
      id: "prole123",
      imagePath: "assets/qp/product (1).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      location: null,
      dept: "Quincaillerie",
    ),

    ItemData(
      name: "Rebel Safety Gear",
      id: "prole2",
      imagePath: "assets/qp/product (2).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Quincaillerie",
    ),

    ItemData(
      name: "YATO Drilling machine",
      id: "prole3",
      imagePath: "assets/qp/product (3).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Quincaillerie",
    ),

    ItemData(
      name: "Peinture",
      id: "prole4",
      imagePath: "assets/qp/product (4).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Quincaillerie",
    ),

    ItemData(
      name: "Pipes Quinmat",
      id: "prole5",
      imagePath: "assets/qp/product (5).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Quincaillerie",
    ),

    ItemData(
      name: "Polyethylene compression fittings",
      id: "prole6",
      imagePath: "assets/qp/product (6).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Quincaillerie",
    ),

    ItemData(
      name: "GI & PVC fittings",
      id: "prole7",
      imagePath: "assets/qp/product (7).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Quincaillerie",
    ),


    ItemData(
      name: "Papeterie",
      id: "prole8",
      imagePath: "assets/qp/product (8).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Papeterie",
    ),


    ItemData(
      name: "Canapé",
      id: "prole9",
      imagePath: "assets/qp/product (9).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Mobilier",
    ),

    ItemData(
      name: "Bureau, une chaise",
      id: "prole10",
      imagePath: "assets/qp/product (10).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Mobilier",
    ),

    ItemData(
      name: "Bureau, plusieurs chaise",
      id: "prole11",
      imagePath: "assets/qp/product (11).jpg",
      email: 'info@quimat.com',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Mobilier",
    ),

    ItemData(
      name: "Lit d'hopital, Medical",
      id: "prole12",
      imagePath: "assets/qp/product (12).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Medical Equipment",
    ),

    ItemData(
      name: "IRM Medical Equipment",
      id: "prole13",
      imagePath: "assets/qp/product (13).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Medical Equipment",
    ),

    ItemData(
      name: "Diagnostic Medical Equipment",
      id: "prole14",
      imagePath: "assets/qp/product (14).jpg",
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998731145",
      phoneNumber2: "+243 848731145",
      canDeliver: true,
      dept: "Medical Equipment",
    ),

    //----------------------------

    ItemData(
      id: 'BoutiqueGrandBoss1234',
      imagePath: 'assets/local/loc_reunion_1.png',
      name: 'Salle de reunion',
      dept: 'Mobilier',
      rating: (3 + 3 + 4 + 5 + 2),
      rater: 5,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
    ),
    ItemData(
      id: 'QS1234',
      imagePath: 'assets/local/loc_restau_1.jpg',
      name: 'Salle à manger',
      rating: (3 + 3 + 4 + 5 + 2+5+5),
      rater: 7,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
    ),
    ItemData(
      id: 'VIPQS1234',
      imagePath: 'assets/local/loc_reunion_2.jpg',
      name: 'Salle de reunion (VIP)',
      dept: 'Mobilier',
      rating: (3 + 3 + 4 + 5 + 2+5+5),
      rater: 7,
      phoneNumber: "+243 998466121",
      phoneNumber2: "+243 8418321547",
      canDeliver: true,
    ),
  ];
}
