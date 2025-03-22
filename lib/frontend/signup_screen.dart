import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:proexpo/frontend/home_page.dart';
import 'package:proexpo/frontend/login_screen.dart';
import 'package:proexpo/frontend/signup_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dropdown_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signup_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

List<Map<String, dynamic>> countries = [
  {"value": "12", 'name': "I'm a Visitor"},
  {"value": "12", 'name': "I'm an Exhibitor"},
  {"value": "12", 'name': "I'm a Service Provider"},
  {"value": "12", 'name': "I'm an Organizer"},
  {"value": "12", 'name': "I'm an Admin"},
];

class _SignUpScreenState extends State<SignUpScreen> {
  File _image1;
  File _image2;
  String companyName;
  String email;
  String recordNumber;
  String password;
  String confirmPassword;
  int employeesNum;
  String location;
  String domain;
  int phoneNumber;
  String website;
  String facebook;
  String ceoName;
  String description;

  final _companyNameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _recordNumberControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _confirmPasswordControl = TextEditingController();
  final _employeeNumberControl = TextEditingController();
  final _locationControl = TextEditingController();
  final _domainControl = TextEditingController();
  final _phoneNumberControl = TextEditingController();
  final _websiteControl = TextEditingController();
  final _facebookControl = TextEditingController();
  final _ceoNameControl = TextEditingController();
  final _descriptionControl = TextEditingController();

  bool _validate = false;
  bool _validatePass = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool error = false;
  Map<String, String> _selectedItem;

  @override
  void dispose() {
    _companyNameControl.dispose();
    _emailControl.dispose();
    _recordNumberControl.dispose();
    _passwordControl.dispose();
    _confirmPasswordControl.dispose();
    _employeeNumberControl.dispose();
    _locationControl.dispose();
    _domainControl.dispose();
    _phoneNumberControl.dispose();
    _websiteControl.dispose();
    _ceoNameControl.dispose();
    _facebookControl.dispose();
    _descriptionControl.dispose();

    super.dispose();
  }

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();

  ///ImagePicker For Company
  Future _imageFromGallery1() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera1() async {
    final pickedFile = await picker1.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  ///ImagePicker For CEO
  Future _imageFromGallery2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile2 != null) {
        _image2 = File(pickedFile2.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile2 != null) {
        _image2 = File(pickedFile2.path);
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

              ///EveryThing Else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Welcome,Please Fill...
                    Center(
                        child: Text(
                      'welcomelogin'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///CompanyLogo & Name & Email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Company Logo
                        GestureDetector(
                          onTap: () {
                            _showPicker1(context);
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

                        ///Company Name & Email
                        Column(
                          children: [
                            ///CompanyName
                            Container(
                              width: 200,
                              child: TextField(
                                  controller: _companyNameControl,
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    companyName = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.work,
                                      color: Colors.white,
                                    ),
                                    labelText: 'companyname'.tr(),
                                    errorText:
                                        _validate ? 'Can\'t Be Empty' : null,
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15.0),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                controller: _emailControl,
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
                                  errorText:
                                      _validatePass ? 'Can\'t Be Empty' : null,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Domain
                    TextField(
                      controller: _domainControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        domain = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.domain,
                          color: Colors.white,
                        ),
                        labelText: 'domain'.tr(),
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

                    ///Password
                    TextField(
                      obscureText: true,
                      controller: _passwordControl,
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

                    ///ConfirmPassword
                    TextField(
                      obscureText: true,
                      controller: _confirmPasswordControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        labelText: 'conpassword'.tr(),
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

                    ///Number Of Employees
                    TextField(
                      controller: _employeeNumberControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        employeesNum = value as int;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.group_rounded,
                          color: Colors.white,
                        ),
                        labelText: 'employeenum'.tr(),
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

                    ///Location
                    TextField(
                      controller: _locationControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        location = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        labelText: 'location'.tr(),
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

                    ///PhoneNumber
                    IntlPhoneField(
                      countryCodeTextColor: Colors.white,
                      dropDownArrowColor: Colors.white,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        phoneNumber = value as int;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        labelText: 'phone'.tr(),
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

                    ///Website
                    TextField(
                      controller: _websiteControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        website = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        labelText: 'website'.tr(),
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
                      controller: _facebookControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        facebook = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                        labelText: 'facebook'.tr(),
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

                    ///CEO Image & Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///CEO Image
                        GestureDetector(
                          onTap: () {
                            _showPicker2(context);
                          },
                          child: Stack(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 60.0,
                                child: _image2 != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        child: Image.file(
                                          _image2,
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

                        ///CEO Name
                        Container(
                          width: 230,
                          child: TextField(
                            controller: _ceoNameControl,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              ceoName = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_pin,
                                color: Colors.white,
                              ),
                              labelText: 'ceo'.tr(),
                              errorText:
                                  _validatePass ? 'Can\'t Be Empty' : null,
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15.0),
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///About
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLength: 200,
                      maxLines: null,

                      // ignore: deprecated_member_use
                      maxLengthEnforced: true,
                      obscureText: false,
                      controller: _descriptionControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(8),
                        labelText: 'about'.tr(),
                        errorText: _validatePass ? 'Can\'t Be Empty' : null,
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 15.0),
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
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'displayName', newUser.user.displayName);
                            SharedPreferences prefs2 =
                                await SharedPreferences.getInstance();
                            prefs.setString('displayName', email);
                            SharedPreferences prefs1 =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'displayName', phoneNumber.toString());
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
                              // Colors.green[700],
                              // Colors.green[600],
                              // Colors.green[500],
                              // Colors.green[400],
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

                    ///LogIn
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
                            if (_role.toString() ==
                                "{name: I'm a Visitor, value: 12}") {
                              print('visit');
                              Navigator.popAndPushNamed(context, LoginScreen.id,
                                  arguments: _role);
                            } else if (_role.toString() ==
                                "{name: I'm an Exhibitor, value: 12}") {
                              Navigator.popAndPushNamed(context, LoginScreen.id,
                                  arguments: _role);

                              print('exhibit');
                            } else if (_role.toString() ==
                                "{name: I'm a Service Provider, value: 12}") {
                              Navigator.popAndPushNamed(context, LoginScreen.id,
                                  arguments: _role);

                              print('serv');
                            }
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

  void _showPicker1(context) {
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
                      _imageFromGallery1();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'.tr()),
                    onTap: () {
                      _imageFromCamera1();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showPicker2(context) {
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
                      _imageFromGallery2();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'.tr()),
                    onTap: () {
                      _imageFromCamera2();
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
