
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show showLicensePage, showAboutDialog;
import 'package:qmt_manager/logic/values.dart';
import 'package:qmt_manager/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';



class AboutPage extends StatefulWidget{
  static const routeName = '/home/setting/about';

  const AboutPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage>{

  var timeUpdate = DateTime.now();
  String appVersion = "0.2.0";

  @override
  void initState() {
    super.initState();
    //initPlatformPackageInfo();
    //PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //appVersion = packageInfo.version;

  }


  /*void initPlatformPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
    //String appName = packageInfo.appName;
    //String packageName = packageInfo.packageName;
    //appVersion = packageInfo.version;
    //String buildNumber = packageInfo.buildNumber;
  }*/



  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationController>(context).setState(NavigationScreen.setting);
    ///text =  BlocProvider.of<LanguageBloc>(context).state.strings;
    ///
    final primaryTextStyle20 = const TextStyle().copyWith(fontSize: 17,);
    final textSettingsStyle = TextStyle(color: Colors.blue);

    final Color backgroundColor = FluentTheme.of(context).cardColor.withOpacity(0.8); //Colors.grey[160].withOpacity(0.8);


    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: BackgroundUI(
        child: ScaffoldPage(
          content: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0,),
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: kMediumDimens),
                child: Column(

                  children: <Widget>[
                    const SizedBox(height: 82,),

                    Card(
                      margin: const EdgeInsets.all(8.0),
                      //color: background2,
                      //backgroundColor: BlocProvider.of<StyleAppTheme>(context).theme.cardColor.withOpacity(0.8),
                      backgroundColor: backgroundColor,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const SizedBox(height: 16.0,),
                              SizedBox(
                                height: 150,
                                child: Image.asset("assets/icon_app.png"),
                              ),
                              const SizedBox(height: 8.0,),
                              const Text(
                                AppConstant.completeName,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24),
                              ),
                              Text("info@${AppConstant.shortname.toLowerCase()}.com",),

                            ],),
                          ),
                          FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {

                              String version = snapshot.data?.version ?? "";
                              String number = snapshot.data?.buildNumber ?? "";
                              return ListTile(
                                leading: const Icon(FluentIcons.info),
                                title: Text("Version", style: primaryTextStyle20,),
                                subtitle: Text("$version+$number (non-stable)",),

                              );
                            }
                          ),
                          ListTile(
                            leading: const Icon(FluentIcons.history),
                            title: Text('Update', style: primaryTextStyle20,),
                            subtitle: Text("${timeUpdate.subtract(const Duration(days: 35, hours: 1))}",
                            ),
                            onPressed: (){},
                          ),
                          ListTile(
                            leading: const Icon(FluentIcons.sync),
                            title: Text("Changelog",style: primaryTextStyle20,),
                            onPressed: (){
                              //showAboutDialog(context: context);
                            },
                          ),

                          ListTile(
                            leading: const Icon(FluentIcons.double_bookmark),
                            title: Text('Licence',style: primaryTextStyle20,),
                            onPressed: (){
                              showLicensePage(context: context);
                            },
                          ),

                          ListTile(
                            leading: const Icon(FluentIcons.share),
                            title: Text('Share this app',style: primaryTextStyle20,),
                            onPressed: (){
                              Share.share(
                                  'check out my favorite app Rental App: \n'
                                      'https://hassankajila.com',
                                  subject: 'Look what I find!'
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(FluentIcons.more),
                            title: Text('More app',style: primaryTextStyle20,),
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),

                    Card(
                      //color: background2,

                      margin: const EdgeInsets.all(8.0),
                      backgroundColor: backgroundColor,
                      child: Column(
                        children: <Widget>[

                          ListTile(
                            title: Text("Developer ",style: textSettingsStyle,),
                          ),
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.user),
                            title: Text("Hassan K.",style: primaryTextStyle20,),
                            subtitle: const Text("@lordyhas"), //Text("dev.haspro@gmail.com",),
                            onPressed: () async {
                              final Uri url = Uri.parse("https://linktr.ee/hassankajila");
                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },

                          ),
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.googlePlay),
                            title: Text("Google Play Store",style: primaryTextStyle20,),
                          ),

                          ListTile(
                            leading: const Icon(FluentIcons.teamwork),
                            title: Text("Our team",style: primaryTextStyle20,),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      //color: background2,
                      margin: const EdgeInsets.all(8.0),
                      backgroundColor: backgroundColor,
                      child: Column(
                        children: <Widget>[

                          ListTile(
                            title: Text("Company",style: textSettingsStyle,),
                          ),
                          ListTile(
                            leading: const Icon(FluentIcons.city_next),
                            title: Text("KDynamic Lab.",style: primaryTextStyle20,),
                            subtitle: const Text("Mobile App Developers ",),
                          ),
                          ListTile(
                            leading: const Icon(FluentIcons.map_pin),
                            title: Text('Address',style: primaryTextStyle20,),
                            subtitle: const Text("None ",),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }

}

