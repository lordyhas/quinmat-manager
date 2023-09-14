import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qmt_manager/logic/values.dart';
import 'package:qmt_manager/src/preference_page/about_page.dart';
import 'package:qmt_manager/src/preference_page/edit_profile_page.dart';

import 'login_page.dart';
import 'myspace_page.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = "SettingScreen";
  final Function()? onMenuTap;

  const SettingScreen({
    super.key,
    this.onMenuTap,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notification = false;
  bool mail = false;

  bool splitButtonDisabled = false;

  AccentColor splitButtonColor = Colors.red;
  final splitButtonFlyout = FlyoutController();

  @override
  void dispose() {
    splitButtonFlyout.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context).setState(NavigationScreen.setting);
    const Icon chevronRight = Icon(FluentIcons.chevron_right_med);

    const kSplitButtonHeight = 22.0;
    const kSplitButtonWidth = 24.0;

    return ScaffoldPage(
      content: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 32.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 910),
            child: Column(
              children: [
                SizedBox(
                  height: 560,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Card(
                          borderColor: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          margin: const EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 110.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(FluentIcons.edit_contact),
                                  title: const Text("Modifier le profile"),
                                  trailing: chevronRight,
                                  onPressed: () {
                                    Go.to(context, routeName: ProfilePage.routeName);

                                    /*showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => SizedBox(
                                        child: ContentDialog(
                                            //scrollable: true,
                                            title: Row(
                                              children: [
                                                const Icon(FluentIcons.accounts,
                                                  color: Colors.transparent,
                                                ),
                                                const Spacer(),
                                                const Text("Profile info"),
                                                const Spacer(),
                                                IconButton(
                                                  icon: const Icon(FluentIcons.chrome_close),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ),
                                            content: const SizedBox(
                                              width: 400,
                                              child: SingleChildScrollView(child: ProfilePage()),
                                            )),
                                      ),
                                    );*/
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(FluentIcons.password_field),
                                  title: const Text("Modifier le mot de passe"),
                                  trailing: chevronRight,
                                  onPressed: () {},
                                ),
                                ListTile(
                                  leading: const Icon(FluentIcons.local_admin),
                                  title: const Text("Accéder à Mon Compte"),
                                  trailing: chevronRight,
                                  onPressed: () =>  Go.of(context).to(routeName: MySpaceScreen.routeName),
                                ),


                                ListTile(
                                  leading: const Icon(FluentIcons.skype_message),
                                  title: const Text("Message et Chat"),
                                  trailing: chevronRight,
                                  onPressed: () {},
                                ),
                                ListTile(
                                  leading: const Icon(FluentIcons.input_address),
                                  title: const Text("Mon adresse"),
                                  trailing: chevronRight,
                                  onPressed: () {},
                                ),
                                ListTile(
                                  leading: const Icon(FluentIcons.payment_card),
                                  title: const Text("Mode de payement"),
                                  trailing: chevronRight,
                                  onPressed: () {},
                                ),
                                ListTile(
                                  //FluentIcons.plug_disconnected
                                  leading: const Icon(FluentIcons.leave),
                                  title: const Text("Se deconnecter"),
                                  trailing: chevronRight,
                                  onPressed: (){
                                    BlocProvider.of<AuthenticationBloc>(context).logout();
                                    Go.of(context).goNamed(LoginPage.routeName);
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  "assets/img/profile3.jpg" ,
                                  height: 130,
                                )),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const SelectableText("Unknown Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                )),
                            const SelectableText(
                              "guest-user@horizon.com",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    borderColor: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(FluentIcons.locale_language),
                          title: const Text("Changer la langue"),
                          trailing: chevronRight,
                          onPressed: () {},
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.clear_night),
                          title: const Text("Dark Mode"),
                          trailing: ToggleSwitch(
                            checked: true,
                            onChanged: (bool value) {},
                          ),
                          onPressed: () {},
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.boards),
                          title: const Text("Theme"),
                          trailing: SplitButtonBar(buttons: [
                            Button(
                              //style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
                              onPressed: splitButtonDisabled ? null : () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: splitButtonDisabled
                                      ? splitButtonColor.secondaryBrushFor(
                                    FluentTheme.of(context).brightness,
                                  )
                                      : splitButtonColor,
                                  borderRadius: const BorderRadiusDirectional.horizontal(
                                    start: Radius.circular(4.0),
                                  ),
                                ),
                                height: kSplitButtonHeight,
                                width: kSplitButtonWidth,
                              ),
                            ),
                            FlyoutTarget(
                              controller: splitButtonFlyout,
                              child: IconButton(
                                icon: const SizedBox(
                                  height: kSplitButtonHeight,
                                  width: kSplitButtonWidth,
                                  child: Icon(FluentIcons.chevron_down,),
                                ),
                                onPressed: splitButtonDisabled
                                    ? null
                                    : () async {
                                  final color = await splitButtonFlyout.showFlyout<AccentColor>(
                                    autoModeConfiguration: FlyoutAutoConfiguration(
                                      preferredMode: FlyoutPlacementMode.bottomCenter,
                                    ),
                                    builder: (context) {
                                      return FlyoutContent(
                                        constraints: const BoxConstraints(maxWidth: 200.0),
                                        child: Wrap(
                                          runSpacing: 10.0,
                                          spacing: 8.0,
                                          children: Colors.accentColors.map((color) {
                                            return Button(
                                              autofocus: splitButtonColor == color,
                                              style: ButtonStyle(
                                                padding: ButtonState.all(
                                                  const EdgeInsets.all(4.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop(color);
                                              },
                                              child: Container(
                                                height: 40.0,
                                                width: 40.0,
                                                color: color,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  );

                                  if (color != null) {
                                    setState(() => splitButtonColor = color);
                                  }
                                },
                              ),
                            ),
                          ]),
                          onPressed: () {},
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.mail_reminder),
                          title: const Text("Notification"),
                          trailing: ToggleSwitch(
                            checked: notification,
                            onChanged: (bool value) {
                              setState(() {
                                notification = value;
                              });
                            },
                          ),
                          onPressed: () {},
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.mail_solid),
                          title: const Text("Avis via mail"),
                          subtitle: const Text("M'envoyer des avis par mail"),
                          trailing: ToggleSwitch(
                            checked: mail,
                            onChanged: (bool value) {
                              setState(() {
                                mail = value;
                              });
                            },
                          ),
                          onPressed: () {},
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.more),
                          title: const Text("More"),
                          trailing: chevronRight,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    borderColor: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          //leading: const Icon(Icons.dark_mode),
                          title: const Text("About Us"),
                          trailing: chevronRight,
                          onPressed: () {},
                        ),
                        ListTile(
                          //leading: const Icon(Icons.dark_mode),
                          title: const Text("About this app"),
                          trailing: chevronRight,
                          onPressed: () {
                            Go.of(context).to(routeName: AboutPage.routeName);
                          },
                        ),

                        ListTile(
                          leading: const Icon(FluentIcons.feedback),
                          title: const Text("Feedback"),
                          trailing: chevronRight,
                          onPressed: () {},
                        ),

                        ListTile(
                          leading: const Icon(FluentIcons.help),
                          title: const Text("Help"),
                          trailing: chevronRight,
                          onPressed: () {},
                        ),

                        FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(

                                  leading: const Icon(FluentIcons.navigate_external_inline),
                                  title: const Text("Last Update"),
                                  subtitle: Text(
                                      "version beta : ${snapshot.data?.version} "),
                                  trailing: chevronRight,
                                  onPressed: () {},
                                );
                              }

                              return Container();
                            }),
                      ],
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
