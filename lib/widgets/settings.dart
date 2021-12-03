import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/themes_provider.dart';
import '../utils/constants.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  var isDarkTheme;
  List<String> themes = Constant.themes;

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: Text(isDarkTheme ? "Dark Theme" : "Light Theme"),
                  trailing: Switch.adaptive(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      prefs.setString(
                          Constant.APP_THEME, value ? "Dark" : "Light");

                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(value);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
