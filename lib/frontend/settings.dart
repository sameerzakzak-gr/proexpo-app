import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proexpo/frontend/home_page.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String darkTheme = 'assets/images/splash_bg.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            Navigator.pushNamed(context, HomePage.id);
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.language,
                    color: Colors.deepPurple,
                    size: 60,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'language'.tr(),
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              ToggleSwitch(
                minWidth: 70.0,
                minHeight: 80.0,
                cornerRadius: 20.0,
                fontSize: 20.0,
                initialLabelIndex: 0,
                activeBgColor: [Colors.deepPurple],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.deepPurple,
                inactiveFgColor: Colors.white,
                totalSwitches: 4,
                labels: ['EN', 'FR', 'AR', 'IT'],
                onToggle: (index) {
                  if (index == 0) {
                    context.locale = Locale('en', 'US');
                  }
                  if (index == 1) {
                    context.locale = Locale('fr', 'FR');
                  }
                  if (index == 2) {
                    context.locale = Locale('ar', 'SA');
                  }
                  if (index == 3) {
                    context.locale = Locale('it', 'IT');
                  }
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
