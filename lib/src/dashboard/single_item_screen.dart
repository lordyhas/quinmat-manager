import 'dart:math';

//import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:latlong2/latlong.dart' as dist;

class ItemIntentData {
  final int? index;
  final ItemData rent;
  final void Function()? onMapClick;

  ItemIntentData({
    required this.rent,
    this.onMapClick,
    this.index,
  });
}

class SingleItemScreen extends StatefulWidget {
  static const routeName = "/home/explore/places/single-place";
  final ItemIntentData placeData;

  const SingleItemScreen({required this.placeData, Key? key}) : super(key: key);

  @override
  State createState() => _SingleItemScreenState();

  static Route route({
    required ItemIntentData placeData,
    Key? key,
  }) {
    return MaterialPageRoute<void>(
        builder: (_) => SingleItemScreen(
              placeData: placeData,
              key: key,
            ));
  }
}

class _SingleItemScreenState extends State<SingleItemScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  late AnimationController animationController;
  late Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ItemData shop;
    final ItemIntentData data;
    data = widget.placeData;
    shop = data.rent;

    var primaryColorLight = Colors.purple;

    int? phone;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                //backgroundColor: Colors.white38,
                expandedHeight: 120.0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      shop.imagePath,
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  )),
                  child: const FlexibleSpaceBar(
                    centerTitle: true,
                    title: SelectableText(
                      "",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),

          ];
        },
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          //height: MediaQuery.of(context).size.height * 0.75,

          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                  child: Text(
                    shop.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      //color: AppTheme.darkerText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 8, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Chez ${AppConstant.shortname} Lubumbashi',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 22,
                          letterSpacing: 0.27,
                          //color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            '4.3',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: Colors.white70,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: primaryColorLight,
                            size: 24,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Wrap(
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    getTimeBoxUI('24/24', 'Hour'),
                                    getTimeBoxUI('7 Day', 'Week'),
                                    getTimeBoxUI('${60 + Random().nextInt(30)}',
                                        '\$'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity2,
                            child: Padding(
                              padding: const EdgeInsets
                                  .symmetric(horizontal: 16.0, vertical: 8.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Row(
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                      //overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                            letterSpacing: 0.27,
                                            color: Colors.white,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Contact 1: ${phone ?? "do not have contact"}\n",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 16,
                                                letterSpacing: 0.20,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Contact 2: ${phone ?? "do not have contact"}\n",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 16,
                                                letterSpacing: 0.20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Email : info.${AppConstant.shortname.toLowerCase()}.com \n",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 16,
                                                letterSpacing: 0.20,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Déjà pris ? : ${shop.canDeliver ? "Oui" : "Non"}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 16,
                                                letterSpacing: 0.20,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ), /*Text(
                            "",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 14,
                              letterSpacing: 0.27,
                              color: Colors.black87,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),*/
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: opacity3,
                        child: Container(
                          //height: 400, //color: Colors.red,
                          constraints: const BoxConstraints(maxHeight: 420),
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(shop.imagePath),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 550),
                  opacity: opacity3,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            child: Icon(
                              FontAwesomeIcons.shopify,
                              color: primaryColorLight,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: data.onMapClick,
                            child: Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.65,
                              decoration: BoxDecoration(
                                color: primaryColorLight,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          primaryColorLight,
                                          //.withOpacity(0.5),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Find on Maps',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    //int Theme = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.purple.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.purple,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedContestTabHeader extends SliverPersistentHeaderDelegate {
  const RoundedContestTabHeader(
    this.context, {
    required this.borderRadius,
    this.onSearchDataEnter,
  });

  final BorderRadius borderRadius;
  final BuildContext context;
  final Function()? onSearchDataEnter;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    return SizedBox(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
    );
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
