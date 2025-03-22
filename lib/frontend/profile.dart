import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:easy_localization/easy_localization.dart';

import 'dropdown_menu.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

List<Map<String, dynamic>> countries = [
  {"value": "12", 'name': "I'm a Visitor"},
  {"value": "12", 'name': "I'm an Exhibitor"},
  {"value": "12", 'name': "I'm a Service Provider"},
];

class _ProfileScreenState extends State<ProfileScreen> {
  File _image1;
  File _image2;
  String companyName;
  String email;
  String recordNumber;
  String password;
  String confirmPassword;
  int employeesNum;
  String location;
  int phoneNumber;
  String website;
  String ceoName;
  String description;

  final _companyNameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _recordNumberControl = TextEditingController();
  final passwordControl = TextEditingController();
  final _confirmPasswordControl = TextEditingController();
  final _employeeNumberControl = TextEditingController();
  final _locationControl = TextEditingController();
  final _phoneNumberControl = TextEditingController();
  final _websiteControl = TextEditingController();
  final _ceoNameControl = TextEditingController();
  final _descriptionControl = TextEditingController();

  bool _validate = false;
  bool _validatePass = false;

  bool error = false;
  Map<String, String> _selectedItem;

  @override
  void dispose() {
    _companyNameControl.dispose();
    _emailControl.dispose();
    _recordNumberControl.dispose();
    passwordControl.dispose();
    _confirmPasswordControl.dispose();
    _employeeNumberControl.dispose();
    _locationControl.dispose();
    _phoneNumberControl.dispose();
    _websiteControl.dispose();
    _ceoNameControl.dispose();
    _descriptionControl.dispose();

    super.dispose();
  }

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();

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
              ///logo
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Fill Your Info....
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

                    ///CompanyLogo & CompanyName &Email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //CompanyLogo
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
                        //Company Name & Email
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              //CompanyName
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
                                  controller: _emailControl,
                                  keyboardType: TextInputType.emailAddress,
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
                    //Membership Picker
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: MembershipPicker(),
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Domain
                    Container(
                      child: CustomDropDown(
                        titleSize: 10,
                        errorMessageSize: 15,
                        withoutHeader: true,
                        bgColor: Colors.transparent,
                        borderColor: Colors.white,
                        direction: Direction.LTR,
                        dividerColor: Colors.white,
                        error: error,
                        errorMessage: "required",
                        headerColor: Colors.black,
                        headerIcon: Icons.account_circle_rounded,
                        hintText: 'domain'.tr(),
                        iconColor: Colors.white,
                        textColor: Colors.grey,
                        title: 'domain'.tr(),
                        withBorder: true,
                        items: countries,
                        onSelected: (Map<String, dynamic> selectedItem) {
                          print(selectedItem);
                          setState(() {
                            _selectedItem = selectedItem;
                          });
                        },
                        borderRadius: 20,
                        itemsTextSize: 20,
                        iconSize: 20,
                        headerIconColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///RecordNumber
                    TextField(
                      controller: _recordNumberControl,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        recordNumber = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.book_rounded,
                          color: Colors.white,
                        ),
                        labelText: 'recordnumber'.tr(),
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
                    Container(
                      child: TextField(
                        obscureText: true,
                        controller: passwordControl,
                        keyboardType: TextInputType.name,
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///Confirm Password
                    TextField(
                      obscureText: true,
                      controller: _confirmPasswordControl,
                      keyboardType: TextInputType.name,
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

                    ///Number of Employees
                    TextField(
                      controller: _employeeNumberControl,
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.name,
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

                    ///Website
                    TextField(
                      controller: _websiteControl,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
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

                    ///CEO & Picture
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///CEO Picture
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

                    ///Save and Cancel Buttons
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
                      height: 30.0,
                    ),

                    ///Go to Login Screen
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
                    title: new Text('galery'.tr()),
                    onTap: () {
                      _imageFromGallery1();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'.tr()),
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
                    title: new Text('Photo Gallery'),
                    onTap: () {
                      _imageFromGallery2();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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
