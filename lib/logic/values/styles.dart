
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

enum StylesThemeState{light,dark}

class StyleAppTheme extends Cubit<FluentThemeData> {

  //final DatabaseManager objectBoxManager = DatabaseManager.empty();

  StyleAppTheme([StylesThemeState? stylesTheme]) : super(_darkTheme);

  FluentThemeData get theme => state;

  Color get gray => Colors.grey;
  Color get primary => Colors.teal;

  //String? a;
  /*
  void restoreTheme() async {
    //final SettingAppData  _settingData = (await objectBoxManager.getSettingDataBox)!;
    //print(" ObjectBox._initObjectBox(theme: ${_settingData!.theme}) ===  ===");
    //Log.out("ObjectBox"," ObjectBox._initObjectBox(theme: ${_settingData.theme}) ===  ===");
    //this.setTheme(StylesThemeState.values[_settingData.theme]);


    var box = await Hive.openBox<AppSetting>(HiveBoxManager.settingBoxName);

    //AppSetting appSetting = new AppSetting()..language = 0;
    //box.put(AppSetting.keyName, 'David');

    if(box.isEmpty){
      AppSetting appSetting = new AppSetting()..theme = 0 ..language = 0;
      box.put(AppSetting.keyName, appSetting);
    }

    AppSetting? setting = box.get(AppSetting.keyName,)!;

    Log.out("HiveBox","HiveBoxManager.restoreTheme(theme: ${setting.theme}) ===  ===");
    this.setTheme(StylesThemeState.values[setting.theme ?? 0]);

  }
  */

  /// [defaultTheme] return a [StylesThemeState] in arg, if arg null return [StylesThemeState.light]
  static FluentThemeData defaultTheme([StylesThemeState? stylesTheme]){
    if (stylesTheme != null) {
      switch(stylesTheme){
        case StylesThemeState.light: return _lightTheme;
        case StylesThemeState.dark: return _darkTheme;
      }
    }
    return _lightTheme;
  }

  bool get isDarkMode => state.brightness == Brightness.dark;


  static final _lightTheme = FluentThemeData(
    brightness: Brightness.light,
  );

  /// dark theme
  static final _darkTheme = FluentThemeData(
    fontFamily: 'Nunito',
    visualDensity: VisualDensity.standard,
    //
    //
    brightness: Brightness.dark,
    //
    activeColor: Colors.teal.lighter,
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

extension UtilsColors on Colors {
  static Color greyDark = Colors.grey[170];
  static Color greyLight = Colors.grey[50];
}
