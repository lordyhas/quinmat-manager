part of home_page;

class ProductScreen extends StatefulWidget {
  static const routeName = "RentProductScreen";
  final void Function()? onMenuTap;

  const ProductScreen({
    super.key,
    this.onMenuTap,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  List<ItemData> get dataTest =>
      ItemDataTest.items; //..addAll(DataTest.shops..shuffle());

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context)
        .setState(NavigationScreen.explorer);
    //var spaceList = _spaceList;//..addAll(_spaceList..shuffle());

    return NestedScrollView(
      //controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      [
                        "assets/img/pub_headset.jpeg",
                        "assets/img/pub_sofa.jpeg",
                      ].elementAt(Random().nextInt(2)),
                      //colorBlendMode: BlendMode,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      gaplessPlayback: true,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    //MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  Column(
                    children: [
                      Container(
                        //width: 500,
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              /// Search Entry Widget
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    //color: Colors.grey.withOpacity(0.70),
                                    //borderRadius: const BorderRadius.all(Radius.circular(38.0),),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    //only(left: 16, right: 16, top: 4, bottom: 4),
                                    child: TextFormBox(
                                      onChanged: (String txt) {},
                                      style: const TextStyle(
                                        fontSize: 18,
                                        //color: Colors.black,
                                      ),
                                      cursorColor: FluentTheme.of(context)
                                          .accentColor,
                                      placeholder: 'Lubumbashi...',
                                      placeholderStyle: const TextStyle(
                                        //color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              /// Search button
                              Container(
                                decoration: BoxDecoration(
                                  color: FluentTheme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          child: const Text(
                            "Trouver un produit specifique, "
                            "${AppConstant.shortname}",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ],
                  ),
                ],
              );
            }, childCount: 1),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: RContestTabHeader(context,
                secondary: true,
                title: const Text("4532 produits disponible")),
          ),
        ];
      },
      body: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 32.0),
          child: ProductListView(
            //heroTag: shopData.shopCode+"$index",
            //onHueClick: (index) => onMapClickOpenPage(index),
            onLikeClick: (index) => showToastFavorite(context: context),
            items: dataTest,
            onShopClick: (index) {
              Go.of(context).goNamed(
                SingleItemScreen.routeName,
                extra: ItemIntentData(
                  rent: dataTest[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  /*
  Widget getSearchBarUI(context) {
    //final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          /// Search Entry Widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (FluentTheme.of(context).brightness == Brightness.dark)
                      ? Colors.grey.withOpacity(0.70)
                      : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  //only(left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Lubumbashi...',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Search button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  */
  /*void showDemoDialog({required BuildContext context}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => ContentDialog(
        //constraints: const BoxConstraints(maxWidth: 720, maxHeight: 1020),
        //elevation: 0.0,
        //backgroundColor: Colors.transparent,
        content: Container(
          constraints: const BoxConstraints(maxWidth: kMediumDimens),
          child: CalendarPopupView(
            barrierDismissible: true,
            minimumDate: DateTime.now(),
            maximumDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day + 10),
            initialEndDate: endDate,
            initialStartDate: startDate,
            onApplyClick: (DateTime startData, DateTime endData) {
              setState(() {
                startDate = startData;
                endDate = endData;
              });
            },
            onCancelClick: () {},
          ),
        ),
      ),
    );
  }*/

  /*
  Widget getTimeDateUI(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choisir un date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Numbre des Chambres',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '3 Chambre - 2 Adultes',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  */
}

class RContestTabHeader extends SliverPersistentHeaderDelegate {
  const RContestTabHeader(
    this.context, {
    this.onSearchDataEnter,
    this.secondary = false,
    this.title,
  });

  final bool secondary;
  final Text? title;
  final BuildContext context;
  final Function()? onSearchDataEnter;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    //final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);
    //Color? filBarColor = secondary ? FluentTheme.of(context).primaryColorLight : null;
    Widget? h3text = !secondary ? RouteNameTitle(title!.data!) : null;
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: FluentTheme.of(context).scaffoldBackgroundColor,
                //color: HotelAppTheme.buildLightTheme().backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 8.0),
                ],
              ),
            ),
          ),
          Container(
            color: FluentTheme.of(context).scaffoldBackgroundColor,

            ///color: HotelAppTheme.buildLightTheme().backgroundColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: h3text ??
                          Text(
                            title?.data ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                    ),
                  ),
                  GestureDetector(
                    //focusColor: Colors.transparent,
                    //highlightColor: Colors.transparent,
                    //hoverColor: Colors.transparent,
                    //splashColor: Colors.grey.withOpacity(0.2),
                    //borderRadius: BorderRadius.circular(4.0),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              FluentIcons.sort_lines,
                                //color: Colors.white,
                              //shopAppTheme.buildLightShopTheme.primaryColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Divider(
              size: 1,
            ),
          )
        ],
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

/*
void _barBottomNav(){
  Align(
      alignment: Alignment.bottomCenter,
      child: Padding(padding: const EdgeInsets.only(bottom: 10.0) ,
        child: FancyBottomNavigation(
          circleColor: Theme.of(context).backgroundColor.withOpacity(0.9),
          barBackgroundColor: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.7),
          inactiveIconColor: Theme.of(context).primaryColorLight,
          activeIconColor: Colors.white,


          tabs: [
            TabData(iconData: CupertinoIcons.home, title: "Home"),
            TabData(iconData: CupertinoIcons.car_detailed, title: "Vehicle"),
            TabData(iconData: CupertinoIcons.shopping_cart, title: "Apart")
          ],
          onTabChangedListener: (position) {

          },
        ),
      )
  ),
}

 */
