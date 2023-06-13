
import 'package:fluent_ui/fluent_ui.dart';
import 'package:qmt_manager/src/setting_profile_screen.dart';
import '../logic/values.dart';



class NavigationLayout extends StatefulWidget {

  static const routeName = "home_layout";
  final Widget? child;
  const NavigationLayout({required this.child, Key? key}) : super(key: key);

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  int topIndex = 0;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 20;
    const TextStyle textStyle = TextStyle(
      fontSize: 16,
    );

    // Do not define the `items` inside the `Widget Build` function
    // otherwise on running `setstate`, new item can not be added.

    List<NavigationPaneItem> items = [
      PaneItemAction(

        icon: const Icon(FluentIcons.home, size: iconSize,),
        title: const Text('Home', style: textStyle,),
        onTap: (){},
      ),
      PaneItemSeparator(),
      PaneItemAction(
        icon: const Icon(FluentIcons.issue_tracking, size: iconSize,),
        title: const Text('Track orders', style: textStyle,),
        infoBadge: const InfoBadge(source: Text('2')),
        //body: const SizedBox.shrink(),
        onTap: () {

        },
      ),

      PaneItemAction(
        icon: const Icon(FluentIcons.mail, size: iconSize,),
        title: const Text('Messages', style: textStyle,),
        infoBadge: const InfoBadge(source: Text('8')),
        //body: const SizedBox.shrink(),
        onTap: () {

        },
      ),
      PaneItemAction(
        icon: const Icon(FluentIcons.fluid_logo, size: iconSize,),
        title: const Text('Explorer', style: textStyle,),
        //body: const _NavigationBodyItem0(),
        onTap: () {

        },
      ),
      PaneItemAction(
        icon: const Icon(FluentIcons.product_list, size: iconSize,),
        title: const Text('Products', style: textStyle,),
        //body: const _NavigationBodyItem0(),
        onTap: () {

        },
      ),
      PaneItemAction(
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
          PaneItemAction(
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
          PaneItemAction(
            icon: const Icon(FluentIcons.contact_list),
            title: const Text('Docteurs data', style: textStyle,),
            onTap: (){},
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.product_release),
            title: const Text('add data', style: textStyle,),
            onTap: (){},
          ),
        ],
      ),
      PaneItemAction(
        icon: const Icon(FluentIcons.add),
        title: const Text('Add New Item', style: textStyle,),
        onTap: () {
          // Your Logic to Add New `NavigationPaneItem`
          /*items.add(
                PaneItem(
                  icon: const Icon(FluentIcons.new_folder),
                  title: const Text('New Item'),
                  body: const Center(
                    child: Text(
                      'This is a newly added Item',
                    ),
                  ),
                ),
              );
              setState(() {});*/
        },
      ),
    ];

    // Return the NavigationView from `Widegt Build` function

    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text(AppConstant.shortname),
      ),
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        //displayMode: displayMode,
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


