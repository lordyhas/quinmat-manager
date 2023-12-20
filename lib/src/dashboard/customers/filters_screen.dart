import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show RangeValues, AppBar, MaterialPageRoute, Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qmt_manager/src/dashboard/customers/model/view_model.dart';
import 'package:qmt_manager/src/dashboard/customers/range_slider_view.dart';
import 'package:qmt_manager/src/dashboard/customers/slider_view.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "filter";
  const FiltersScreen({super.key});

  static MaterialPageRoute route() => MaterialPageRoute(
    builder:(context) => const FiltersScreen(),
  );

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late List<PopularFilterListData> popularFilterListData;

  late List<PopularFilterListData> storeListData;

  late RangeValues _values;
  late double distValue;
  late Filter filter;
  late bool isDarkMode;

  //late final _text;

  /*Map<String, String> lang = <String, String>{
    "filter_title" : "Filters",
    "filter_apply" : "Apply",
    "filter_shop"  : "Type of shop",
    "filter_max_dist" : "Maximum distance from me",
    "filter_cat" : "Category filters",
    "filter_price" : "Price",

    "filter_slider_dist" : "Less than",

    "filter_list_" : "",
    "filter_" : "",

    "cat_electronic" : "Electronic Device",
    "cat_cloth" : "Clothes",
    "cat_cuisine" : "Cuisine",
    "cat_furniture" : "Furniture",
    "cat_" : "",
  };*/

  @override
  void initState() {
    super.initState();
    //text = lang as Map<String, String>;
    //text = BlocProvider.of<LanguageBloc>(context).state.getStrings();
    popularFilterListData = popularFList();
    storeListData = storeFilterList();
    filter = BlocProvider.of<FilterCubit>(context).state;
    //_values = const RangeValues(100, 600);
    _values = RangeValues(filter.minPrice, filter.maxPrice);
    distValue = filter.maxDistance;
  }

  Color colorTitle() {
    return isDarkMode ? Colors.black : Colors.grey[120];
  }
  double? usdValue;
  double? cdfValue;

  @override
  Widget build(BuildContext context) {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);
    isDarkMode = FluentTheme.of(context).brightness == Brightness.dark;
    final GlobalKey<FormState> validatorKey = GlobalKey<FormState>();

    return ScaffoldPage(
      //appBar: AppBar(),
      //backgroundColor: Colors.transparent,
      content: Column(
        children: <Widget>[
          getAppBarUI(),
          const Divider(size: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 720),
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 400,
                        child: Form(
                          key: validatorKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Taux du jours',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        //color: colorTitle(),
                                          fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    //constraints: const BoxConstraints(maxWidth: 500),
                                    child:  Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: InfoLabel(
                                            label:"USD",
                                            child: TextFormBox(
                                              initialValue: "1",
                                              placeholder:"Entrez la valeur (USD)",
                                              onChanged: (str) {},
                                              onSaved: (String? value) {
                                                  setState(() {
                                                    usdValue = value!.toDouble();
                                                  });
                                              },
                                              validator: (v) {
                                                if (v!.isEmpty) return 'USD est requis.';
                                                if(v.isNotNumeric) return 'USD doit être un nombre.';
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: InfoLabel(
                                            label:"CDF",
                                            child: TextFormBox(
                                              initialValue: "2475.60",
                                              placeholder:"Entrez la valeur (CDF)",
                                              onSaved: (value) {
                                                setState(() {
                                                  cdfValue = value!.toDouble();
                                                });
                                              },
                                              validator: (v) {
                                                if (v!.isEmpty) return 'CDF est requis.';
                                                if(v.isNotNumeric) return 'CDF doit être un nombre.';
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: FilledButton(
                                            child: const Text("Enregistrer"),
                                            onPressed: (){
                                              if (validatorKey.currentState!.validate()) {
                                                validatorKey.currentState!.save();
                                                BlocProvider.of<FilterCubit>(context).change(
                                                  exchangeRate: usdValue!/cdfValue!,
                                                );
                                              }
                                              //validatorKey.currentState;
                                            }
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        child: Column(
                          children: [
                            priceBarFilter(),
                            const Divider(size: 1),
                            popularFilter(),
                            //const Divider(height: 1),
                            //distanceViewUI(),
                            const Divider(size: 1),
                            shopFilterUI()
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            size: 1,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
            child: Container(
              height: 48,
              constraints: const BoxConstraints(maxWidth: 520),
              decoration: BoxDecoration(
                color: shopAppTheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Container(
                color: Colors.transparent,
                child: Button(
                  //borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  //highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      "Appliqué",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget shopFilterUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "Type de local",
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < storeListData.length; i++) {
      final PopularFilterListData date = storeListData[i];
      noList.add(
        Container(
          color: Colors.transparent,
          child: GestureDetector(
            //borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: const TextStyle(
                          //color: Theme.of(context).textTheme.subtitle2?.color
                          ),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? shopAppTheme.primary
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          size: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (storeListData[0].isSelected) {
        for (final d in storeListData) {
          d.isSelected = false;
        }
      } else {
        for (final d in storeListData) {
          d.isSelected = true;
        }
      }
    } else {
      storeListData[index].isSelected = !storeListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < storeListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = storeListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == storeListData.length - 1) {
        storeListData[0].isSelected = true;
      } else {
        storeListData[0].isSelected = false;
      }
    }
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "Maximum distance par rapport au centre ville",
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChangeDistValue: (double value) {
            distValue = value;
            BlocProvider.of<FilterCubit>(context).change(
              maxDistance: value,
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "Categorie",
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getPList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList() {
    final shopAppTheme = BlocProvider.of<StyleAppTheme>(context);

    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData data = popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: GestureDetector(
                    //borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        data.isSelected = !data.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            data.isSelected
                                ? FluentIcons.box_checkmark_solid
                                : FluentIcons.checkbox,
                            color: data.isSelected
                                ? shopAppTheme.primary
                                : Colors.grey[110],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            data.titleTxt,
                            //style: TextStyle(color: Theme.of(context).primaryColorDark),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Prix (en \$)',
            textAlign: TextAlign.left,
            style: TextStyle(
                //color: colorTitle(),
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: [
            RangeSliderView(
              values: _values,
              onChangeRangeValues: (RangeValues values) {
                _values = values;
                BlocProvider.of<FilterCubit>(context).change(
                  maxPrice: values.end,
                  minPrice: values.start,
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: FluentTheme.of(context).scaffoldBackgroundColor,
        //color: shopAppTheme.buildLightShopTheme.backgroundColor,
        /*boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],*/
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Container(
                color: Colors.transparent,
                child: GestureDetector(
                  /*borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),*/
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FluentIcons.cancel, size: 18,),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Filtre",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  List<PopularFilterListData> popularFList() {
    return <PopularFilterListData>[
      PopularFilterListData(
        titleTxt: "Quincaillerie",
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: "Mobilier",
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: "Papeterie",
        isSelected: true,
      ),
      PopularFilterListData(
        titleTxt: "Autres",
        isSelected: false,
      ),
    ];
  }

  List<PopularFilterListData> storeFilterList() {
    return <PopularFilterListData>[
      PopularFilterListData(
        titleTxt: 'Tout type',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'Alimantaire',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'Electronique',
        isSelected: true,
      ),
      PopularFilterListData(
        titleTxt: 'Plastique',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'Meublier',
        isSelected: false,
      ),
      PopularFilterListData(
        titleTxt: 'Papier',
        isSelected: false,
      ),
    ];
  }
}
