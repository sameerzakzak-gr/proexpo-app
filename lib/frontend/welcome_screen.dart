import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:proexpo/frontend/login_screen.dart';
import 'package:proexpo/frontend/who_your.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class ContinueAsScreen extends StatefulWidget {
  static const String id = 'continue_as_screen';
  @override
  _ContinueAsScreenState createState() => _ContinueAsScreenState();
}

class _ContinueAsScreenState extends State<ContinueAsScreen> {
  //
  // final splashDelay = 2;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _loadWidget();
  // }
  //
  // _loadWidget() async {
  //   var _duration = Duration(seconds: splashDelay);
  //   return Timer(_duration, checkFirstSeen);
  // }
  //
  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _introSeen = (prefs.getBool('intro_seen') ?? false);
  //
  //   Navigator.pop(context);
  //   if (_introSeen) {
  //     Navigator.pushNamed(context, LoginScreen.id);
  //   } else {
  //     await prefs.setBool('intro_seen', true);
  //     Navigator.pushNamed(context, ContinueAsScreen.id);
  //   }
  // }
  Color color = Colors.grey;
  bool error = false;
  bool agreeValue = false;
  @override
  Widget build(BuildContext context) {
    bool checkValue;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //LOGO

                    SizedBox(
                      height: 10.0,
                    ),

                    ///Welcome
                    Center(
                      child: Text(
                        'welcome'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    ///Language Picker
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'language'.tr(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Icon(
                                  Icons.language,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///English
                                  Container(
                                      width: 85,
                                      height: 40,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              print('ss');
                                              context.locale =
                                                  Locale('en', 'US');
                                              print(context.locale);
                                            });
                                          },
                                          child: Text(
                                            'english'.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),

                                  ///Arabic
                                  Container(
                                      width: 85,
                                      height: 40,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              print('ss');
                                              context.locale =
                                                  Locale('ar', 'SA');
                                              print(context.locale);
                                            });
                                          },
                                          child: Text(
                                            'arabic'.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),

                                  ///French
                                  Container(
                                      width: 85,
                                      height: 40,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              print('ss');
                                              context.locale =
                                                  Locale('fr', 'FR');
                                              print(context.locale);
                                            });
                                          },
                                          child: Text(
                                            'french'.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),

                                  ///Italian
                                  Container(
                                      width: 85,
                                      height: 40,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              print('ss');
                                              context.locale =
                                                  Locale('it', 'IT');
                                              print(context.locale);
                                            });
                                          },
                                          child: Text(
                                            'italian'.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    ///Privacy Policy
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.transparent),
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text(
                                    'privacypolicy'.tr(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              CheckboxListTile(
                                checkColor: Colors.green,
                                activeColor: Colors.white,
                                selectedTileColor: Colors.green,
                                //checkColor: kGreenAppColor,
                                title: Text(
                                  'iagreeprivacy'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                value: timeDilation != 1.0,
                                onChanged: (agreeValue) {
                                  setState(() {
                                    timeDilation = agreeValue ? 5.0 : 1.0;
                                    if (agreeValue == true) {
                                      color = Colors.white;
                                    } else {
                                      color = Colors.grey;
                                    }
                                    print(agreeValue);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    ///Continue
                    TextButton(
                        child: Text(
                          'continue'.tr(),
                          style: TextStyle(
                            color: color,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (color == Colors.white) {
                              Navigator.pushReplacementNamed(
                                  context, WhoYouAre.id);
                            }
                          });
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
