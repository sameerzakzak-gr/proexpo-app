import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class SignUpScreen2 extends StatefulWidget {
  static String id = 'signup_screen2';
  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  File _image1;
  String fullName1;
  String email1;
  String password1;
  String confirmPassword1;
  int phoneNumber1;
  String facebook1;
  String website1;

  final _fullNameControl1 = TextEditingController();
  final _emailControl1 = TextEditingController();
  final _passwordControl1 = TextEditingController();
  final _confirmPasswordControl1 = TextEditingController();
  final _phoneNumberControl1 = TextEditingController();
  final _facebookControl1 = TextEditingController();
  final _websiteControl1 = TextEditingController();

  bool _validate1 = false;
  bool _validatePass1 = false;
  bool error1 = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _fullNameControl1.dispose();
    _emailControl1.dispose();
    _passwordControl1.dispose();
    _confirmPasswordControl1.dispose();
    _phoneNumberControl1.dispose();
    _facebookControl1.dispose();
    _websiteControl1.dispose();
    super.dispose();
  }

  final picker = ImagePicker();

  Future _imageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _role = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back1.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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

              ///Everything Else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),

                    /// Please fill your info....
                    Center(
                        child: Text(
                      'fillinfo'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Profile Picture & Name & Email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Profile Picture
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Stack(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 60.0,
                                child: _image1 != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        child: Image.file(
                                          _image1,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                        width: 150,
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.camera_alt,
                                              color: Colors.indigo[800],
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.indigo[800],
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.indigo[800],
                                    ),
                                  )),
                            ],
                          ),
                        ),

                        /// Full Name & Email
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              ///Full Name
                              Container(
                                width: 200,
                                child: TextField(
                                    controller: _fullNameControl1,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      fullName1 = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.work,
                                        color: Colors.white,
                                      ),
                                      labelText: 'name'.tr(),
                                      errorText:
                                          _validate1 ? 'Can\'t Be Empty' : null,
                                      labelStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              ///Email
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: _emailControl1,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    email1 = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    labelText: 'email'.tr(),
                                    errorText: _validatePass1
                                        ? 'Can\'t Be Empty'
                                        : null,
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15.0),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Password
                    TextField(
                      obscureText: true,
                      controller: _passwordControl1,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password1 = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        labelText: 'password'.tr(),
                        errorText: _validatePass1 ? 'Can\'t Be Empty' : null,
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Confirm Password
                    TextField(
                      obscureText: true,
                      controller: _confirmPasswordControl1,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        confirmPassword1 = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        labelText: 'conpassword'.tr(),
                        errorText: _validatePass1 ? 'Can\'t Be Empty' : null,
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Phone Number
                    IntlPhoneField(
                      countryCodeTextColor: Colors.white,
                      dropDownArrowColor: Colors.white,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        phoneNumber1 = value as int;
                      },
                      onSaved: (value) {
                        phoneNumber1 = value as int;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        labelText: 'phonenumber'.tr(),
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      initialCountryCode: 'SY',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Website
                    TextField(
                      controller: _websiteControl1,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        website1 = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        labelText: 'website'.tr(),
                        errorText: _validatePass1 ? 'Can\'t Be Empty' : null,
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Facebook
                    TextField(
                      controller: _facebookControl1,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        facebook1 = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                        labelText: 'facebook'.tr(),
                        errorText: _validatePass1 ? 'Can\'t Be Empty' : null,
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///SignUp Button
                    GestureDetector(
                      onTap: () async {
                        try {
                          final newUser2 =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email1, password: password1);
                          if (newUser2 != null) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'displayName', newUser2.user.displayName);
                            SharedPreferences prefs2 =
                                await SharedPreferences.getInstance();
                            prefs.setString('displayName', email1);
                            SharedPreferences prefs1 =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'displayName', phoneNumber1.toString());
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
                            ]),
                          ),
                          child: Text('signup'.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.0))),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    ///Login
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'alreadyuser'.tr(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, ProfileScreen.id);
                          },
                          child: Text(
                            'login'.tr(),
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
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('gallery'.tr()),
                    onTap: () {
                      _imageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'.tr()),
                    onTap: () {
                      _imageFromCamera();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
