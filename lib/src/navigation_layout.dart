
import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/src/add_product/add_product_page.dart';
import 'package:qmt_manager/src/setting_profile_screen.dart';
import '../logic/values.dart';
import 'dashboard/doctors/doctor_data_tab.dart';
import 'home_page.dart';
import 'myspace_page.dart';



class NavigationLayout extends StatefulWidget {

  static const routeName = "home_layout";
  final Widget? child;
  const NavigationLayout({required this.child, Key? key}) : super(key: key);

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  int topIndex = 0;

  final flyoutController = FlyoutController();

  searchMenuBar(){
    String? selectedCat;
    const cats = <String>[
      'Setting',
      'Profile',
      'About',
      'Product List',
      'Doctor Database',
      'Add Product',
      'Add Doctor',
    ];
    return AutoSuggestBox<String>(
      placeholder: 'Search Menu...',
      trailingIcon: const Padding(
        padding:  EdgeInsets.only(right:8.0),
        child:  Icon(FluentIcons.search,),
      ),
      items: cats.map((cat) {
        return AutoSuggestBoxItem<String>(
            value: cat,
            label: cat,
            onFocusChange: (focused) {
              if (focused) {
                debugPrint('Focused $cat');
              }
            }
        );
      }).toList(),
      onSelected: (item) {
        setState(() {});
      },
    );


  }

  @override
  void dispose() {
    flyoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 20;
    const TextStyle textStyle = TextStyle(
      fontSize: 16,
    );

    // Do not define the `items` inside the `Widget Build` function
    // otherwise on running `setstate`, new item can not be added.

    List<NavigationPaneItem> items = [
      PaneItemHeader(header: searchMenuBar()),
      PaneItemSeparator(color: Colors.transparent),

      PaneItem(
        body: const SizedBox.shrink(),
        icon: const Icon(FluentIcons.home, size: iconSize,),
        title: const Text('Home', style: textStyle,),
        //onTap: (){},
        onTap: () => Go.of(context).to(routeName: HomePage.routeName),
      ),
      PaneItemSeparator(),
      PaneItem(
        icon: const Icon(FluentIcons.issue_tracking, size: iconSize,),
        title: const Text('Track orders', style: textStyle,),
        infoBadge: const InfoBadge(source: Text('2')),
        body: const SizedBox.shrink(),
        onTap: () {},
      ),

      PaneItem(
        icon: const Icon(FluentIcons.group, size: iconSize,),
        title: const Text('Teams', style: textStyle,),
        body: const SizedBox.shrink(),
        onTap: () {

        },
      ),

      PaneItem(
        body: const SizedBox.shrink(),
        icon: const Icon(FluentIcons.mail, size: iconSize,),
        title: const Text('Messages', style: textStyle,),
        infoBadge: const InfoBadge(source: Text('8')),
        //body: const SizedBox.shrink(),
        onTap: () {

        },
      ),
      PaneItem(
          body: const SizedBox.shrink(),
        icon: const Icon(FluentIcons.fluid_logo, size: iconSize,),
        title: const Text('Previsualiser', style: textStyle,),
        //body: const _NavigationBodyItem0(),
        onTap:  () => null,  //Go.of(context).to(routeName: MySpaceScreen.routeName)
      ),
      PaneItemExpander(
        body: const SizedBox.shrink(),
        icon: const Icon(FluentIcons.product_list, size: iconSize,),
        title: const Text('Products', style: textStyle,),
        //body: const _NavigationBodyItem0(),
        onTap: () {

        },
        items: [
          PaneItem(
            body: const SizedBox.shrink(),
            icon: const Icon(FluentIcons.product_release),
            title: const Text('Ajouer un produit', style: textStyle,),
            onTap: () => Go.of(context).to(routeName: AddProductPage.routeName),
          ),
        ],
      ),
      PaneItem(
        body: const SizedBox.shrink(),
        icon: const Icon(FluentIcons.disable_updates, size: iconSize,),
        title: const Text('Disabled Item', style: textStyle,),
        //body: const _NavigationBodyItem0(),
        //enabled: false,
        onTap: (){},
      ),
      PaneItemExpander(
        icon: const Icon(FluentIcons.account_management, size: iconSize,),
        title: const Text('Mon Compte', style: textStyle,),
        body: const SizedBox.shrink(),
        items: [
          PaneItemHeader(header: const Text('Dans mon compte')),
          PaneItem(
            body: const SizedBox.shrink(),
            icon: const Icon(FluentIcons.contact),
            title: const Text('Acceder à mon compte', style: textStyle,),
            //body: const _NavigationBodyItem0(),
            onTap:  () =>  Go.of(context).to(routeName: MySpaceScreen.routeName),

          ),
          PaneItem(
            body: const SizedBox.shrink(),
            icon: const Icon(FluentIcons.mail),
            title: const Text('Notification', style: textStyle,),
            //body: const _NavigationBodyItem0(),
            onTap: (){},
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.calendar),
            title: const Text('Calendar', style: textStyle,),
            onTap: () {  },

          ),
          PaneItem(
            body: const SizedBox.shrink(),
            icon: const Icon(FluentIcons.contact_list),
            title: const Text('Docteurs data', style: textStyle,),
            onTap:  () =>  Go.of(context).to(routeName: DoctorDataTableScreen.routeName),
          ),

        ],
      ),
      PaneItemAction(
        icon: const Icon(FluentIcons.more),
        title: const Text('More', style: textStyle,),
        onTap: () {
        },
      ),

      PaneItemAction(
        icon: const Icon(FluentIcons.oem), //FluentIcons.waffle
        title: const Text('Apps', style: textStyle,),
        onTap: () {
        },
      ),
    ];

    // Return the NavigationView from `Widegt Build` function

    return NavigationView(
      appBar: const NavigationAppBar(
        leading: Icon(FluentIcons.fluid_logo),
        //leading: Icon(FluentIcons.arrange_bring_forward),
        title: true ? null : Text(AppConstant.completeName,
          style: TextStyle(
            //color: Theme.of(context).primaryColorDark,
            fontSize: 16,
          ),
        ),
      ),

      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        //displayMode: displayMode,
        header: Text(
          "  ${AppConstant.shortname.toUpperCase()}",
          style: const TextStyle(
            //color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),),
        items: items,
        footerItems: [
          PaneItemSeparator(),
          PaneItemAction(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings', style: textStyle,),
            onTap: (){
              GoRouter.of(context).goNamed(SettingScreen.routeName);
            },
          ),

          PaneItemAction(
            icon: const Icon(FluentIcons.info),
            title: const Text('About Us', style: textStyle,),
            onTap: (){},
          ),
          PaneItemSeparator(),
          PaneItemAction(
            icon: const Icon(FluentIcons.recycle_bin),
            title: const Text('Corbeille', style: textStyle,),
            onTap: (){},
          ),

        ],
      ),
      paneBodyBuilder: (item, child){
        return Container(
          color: Colors.transparent,
          child: widget.child,

          //NestedWebView(child: SizedBox(),),
        );

      },

    );


  }
}


