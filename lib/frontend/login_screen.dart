import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proexpo/frontend/home_page.dart';
import 'package:proexpo/frontend/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import 'signup_screen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _text = TextEditingController();

  final _textPass = TextEditingController();

  bool _validatePass = false;

  bool _validate = false;

  String email;

  String password;

  @override
  void dispose() {
    _text.dispose();
    _textPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _role = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back1.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            ///Logo
            Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))),
            ),
            SizedBox(
              height: 30.0,
            ),

            ///Please Fill Your info...
            Center(
                child: Text(
              'welcomelogin'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20.0,
            ),

            ///EveryThing Else
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),

                      ///Email
                      TextField(
                          controller: _text,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            labelText: 'email'.tr(),
                            errorText: _validate ? 'Can\'t Be Empty' : null,
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 15.0),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),

                      ///Password
                      TextField(
                        obscureText: true,
                        controller: _textPass,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: 'password'.tr(),
                          errorText: _validatePass ? 'Can\'t Be Empty' : null,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      ///LogIn Button
                      GestureDetector(
                        onTap: () async {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('displayName', user.user.displayName);
                                  SharedPreferences prefs2 = await SharedPreferences.getInstance();
                                  prefs.setString('displayName', email);
                            }
                          } catch (e) {
                            print(e);
                          }
                          if (_role.toString() ==
                              "{name: I'm a Visitor, value: 12}") {
                            print('visit');
                            Navigator.pushNamed(context, HomePage.id,
                                arguments: _role);
                          } else if (_role.toString() ==
                              "{name: I'm an Exhibitor, value: 12}") {
                            Navigator.pushNamed(context, HomePage.id,
                                arguments: _role);
                            print('exhibit');
                          } else if (_role.toString() ==
                              "{name: I'm a Service Provider, value: 12}") {
                            Navigator.pushNamed(context, HomePage.id,
                                arguments: _role);
                            print('serv');
                          }
                          print(_role);
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30.0),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              gradient: LinearGradient(colors: [
                                Colors.white38,
                                Colors.white54,
                                Colors.white60,
                                Colors.white70,

                                // Colors.grey[600],
                                // Colors.grey[600],
                                // Colors.grey[400],
                                // Colors.grey[400],
                              ]),
                            ),
                            child: Text('login'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18.0))),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      ///SignUp
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('newuser'.tr()),
                          TextButton(
                            onPressed: () {
                              if (_role.toString() ==
                                  "{name: I'm a Visitor, value: 12}") {
                                print('visit');
                                Navigator.pushNamed(context, SignUpScreen2.id,
                                    arguments: _role);
                              } else if (_role.toString() ==
                                  "{name: I'm an Exhibitor, value: 12}") {
                                Navigator.pushNamed(context, SignUpScreen.id,
                                    arguments: _role);
                                print('exhibit');
                              } else if (_role.toString() ==
                                  "{name: I'm a Service Provider, value: 12}") {
                                Navigator.pushNamed(context, SignUpScreen2.id,
                                    arguments: _role);
                                print('serv');
                              }
                            },
                            child: Text(
                              'signup'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
