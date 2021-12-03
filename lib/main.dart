import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/home_screen.dart';
import './provider/themes_provider.dart';
import './utils/constants.dart';
import './provider/data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((value) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) {
              String? theme = value.getString(Constant.APP_THEME);
              return (theme == null ||
                      theme.isEmpty ||
                      theme == Constant.SYSTEM_DEFAULT)
                  ? ThemeProvider(ThemeMode.system)
                  : ThemeProvider(theme == Constant.DARK
                      ? ThemeMode.dark
                      : ThemeMode.light);
            }),
            ChangeNotifierProvider(create: (context) => DataProvider()),
          ],
          child: Main(),
        ),
      ));
}

// ignore: use_key_in_widget_constructors
class Main extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: ShonenJump(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class ShonenJump extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShonenJumpState();
  }
}
