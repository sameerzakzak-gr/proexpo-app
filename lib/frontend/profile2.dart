import 'package:flutter/material.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Profile2 extends StatefulWidget {
  static String id = 'profile2';
  @override
  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  File _image;
  String fullName;
  String email;
  String password;
  String conirmPassword;
  int phoneNumber;

  final _fullNameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _phoneNumberControl = TextEditingController();
  final _confirmPasswordControl = TextEditingController();

  bool _validate = false;
  bool _validatePass = false;
  bool error = false;
  @override
  void dispose() {
    _fullNameControl.dispose();
    _emailControl.dispose();
    _passwordControl.dispose();
    _phoneNumberControl.dispose();
    _confirmPasswordControl.dispose();
    super.dispose();
  }

  final picker = ImagePicker();

  Future _imageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              //Logo
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
              //Everything Else
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
                      'editprofile'.tr(),
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
                                child: _image != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        child: Image.file(
                                          _image,
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
                                    controller: _fullNameControl,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      fullName = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.work,
                                        color: Colors.white,
                                      ),
                                      labelText: 'name'.tr(),
                                      errorText:
                                          _validate ? 'Can\'t Be Empty' : null,
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
                              //Email
                              Container(
                                width: 200,
                                child: TextField(
                                  keyboardType: TextInputType.name,
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
                                    errorText: _validatePass
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

                    ///Confirm Password
                    TextField(
                      obscureText: true,
                      controller: _confirmPasswordControl,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        conirmPassword = value;
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

                    ///Phone Number
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

                    ///Save & Cancel Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, ExposLoading.id);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30.0),
                              alignment: Alignment.center,
                              width: 100,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                gradient: LinearGradient(colors: [
                                  Colors.red[800],
                                  Colors.red[600],
                                  Colors.red[400],
                                  Colors.red[400],
                                  Colors.red[400],
                                  // Colors.green[700],
                                  // Colors.green[600],
                                  // Colors.green[500],
                                  // Colors.green[400],
                                ]),
                              ),
                              child: Text('cancel'.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.0))),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, ExposLoading.id);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30.0),
                              alignment: Alignment.center,
                              width: 100,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                gradient: LinearGradient(colors: [
                                  Colors.indigo[600],
                                  Colors.indigo[600],
                                  Colors.indigo[400],
                                  Colors.indigo[400],
                                  // Colors.green[700],
                                  // Colors.green[600],
                                  // Colors.green[500],
                                  // Colors.green[400],
                                  // Colors.green[400],
                                ]),
                              ),
                              child: Text('save'.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.0))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    )
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
                    title: new Text('Photo Gallery'),
                    onTap: () {
                      _imageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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
