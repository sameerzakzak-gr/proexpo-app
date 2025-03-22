import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'package:proexpo/backend/service.dart';
import 'dropdown_menu.dart';
import 'package:easy_localization/easy_localization.dart';

class AddServiceScreen extends StatefulWidget {
  static String id = 'add_service';
  Exhibition expo;
  final Map<String, String> role;
  AddServiceScreen(this.role, this.expo);
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  File image;
  String serviceName;
  String type;
  String price;
  String phoneNumber;
  String serviceProviderName;
  String email;
  String facebook;
  String website;
  bool error = false;

  bool _validate = false;
  bool _validatePass = false;

  final _serviceNameControl = TextEditingController();
  final _phoneNumberControl = TextEditingController();
  final _typeControl = TextEditingController();
  final _priceControl = TextEditingController();
  final _serviceProviderNameControl = TextEditingController();
  final _emailControl = TextEditingController();
  final _facebookControl = TextEditingController();
  final _websiteControl = TextEditingController();

  void dispose() {
    _serviceNameControl.dispose();
    _phoneNumberControl.dispose();
    _priceControl.dispose();
    _emailControl.dispose();
    _facebookControl.dispose();
    _serviceProviderNameControl.dispose();
    _websiteControl.dispose();
    _typeControl.dispose();
    super.dispose();
  }

  final picker = ImagePicker();

  Future _imageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addservice'.tr()),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back1.png'), fit: BoxFit.cover),
        ),
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                ///Service Provider
                Center(
                  child: Text(
                    'service'.tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                ///Picture & Type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 70.0,
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  width: 300.0,
                                  child: Image.file(
                                    image,
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                width: 150,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.indigo[800],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Container(
                      width: 250,
                      child: TextField(
                          controller: _typeControl,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            type = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.handshake,
                              color: Colors.white,
                            ),
                            labelText: 'type'.tr(),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                ///Service Name
                TextField(
                    controller: _serviceNameControl,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      serviceName = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.handshake,
                        color: Colors.white,
                      ),
                      labelText: 'servicename'.tr(),
                      errorText: _validate ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),

                ///Price
                TextField(
                  controller: _priceControl,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    price = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.dollarSign,
                      color: Colors.white,
                    ),
                    labelText: "serviceprice".tr(),
                    errorText: _validatePass ? 'Can\'t Be Empty' : null,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.5),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),

                ///Contact Info
                Center(
                  child: Text(
                    'contactinfo'.tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                ///ServiceProviderName
                TextField(
                    controller: _serviceProviderNameControl,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      serviceProviderName = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.userTie,
                        color: Colors.white,
                      ),
                      labelText: 'serviceprovidername'.tr(),
                      errorText: _validate ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),

                ///Phone Number
                TextField(
                  controller: _phoneNumberControl,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.phoneAlt,
                      color: Colors.white,
                    ),
                    labelText: 'phonenumber'.tr(),
                    errorText: _validatePass ? 'Can\'t Be Empty' : null,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.5),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                ///Email
                TextField(
                    controller: _emailControl,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.at,
                        color: Colors.white,
                      ),
                      labelText: 'email'.tr(),
                      errorText: _validate ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),

                ///Facebook
                TextField(
                    controller: _facebookControl,
                    keyboardType: TextInputType.name,
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
                      errorText: _validate ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),

                ///Website
                TextField(
                    controller: _websiteControl,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      website = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.globe,
                        color: Colors.white,
                      ),
                      labelText: 'website'.tr(),
                      errorText: _validate ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    )),
                SizedBox(
                  height: 50.0,
                ),

                ///Add & Cancel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                          child: Text("cancel".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.0))),
                    ),
                    GestureDetector(
                      onTap: () {
/*                        Service({this.serviceNumOfRatings,this.serviceRate,this.serviceName,this.serviceType,this.serviceImage,this.servicePhoneNumber,
                          this.serviceWebsite,this.serviceEmail,this.serviceFacebook,this.serviceExhibition,this.serviceProviderName});*/

                        Service newService = Service(
                            serviceNumOfRatings: "0",
                            serviceRate: "0",
                            serviceName: serviceName,
                            serviceType: type,
                            serviceImage: 'assets/images/B.jpg',
                            servicePhoneNumber: phoneNumber.toString(),
                            serviceWebsite: website,
                            serviceEmail: email,
                            serviceFacebook: facebook,
                            serviceExhibition: widget.expo.exhibitionName,
                            serviceProviderName: serviceProviderName);
                        FirebaseFirestore.instance
                            .collection('service')
                            .add(newService.toMap());
                        Navigator.pop(context);
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
                          child: Text("add".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.0))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
