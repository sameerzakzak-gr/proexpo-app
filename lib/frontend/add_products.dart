import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'package:proexpo/backend/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProducts extends StatefulWidget {
  static String id = 'add_products';
  final Exhibition expo;
  final Map<String, String> role;
  AddProducts(this.role, this.expo);
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  File image1;
  File image2;
  String productName;
  String price;
  String quantity;
  String domain;
  String exhibitorName;
  String hallNumber;
  bool error = false;
  String description;

  final _productNameControl = TextEditingController();
  final _priceControl = TextEditingController();
  final _quantityControl = TextEditingController();
  final _exhibitorNameControl = TextEditingController();
  final _hallNumberControl = TextEditingController();
  final _domainControl = TextEditingController();
  final _descriptionControl = TextEditingController();

  bool _validate = false;
  bool _validatePass = false;

  void dispose() {
    _productNameControl.dispose();
    _priceControl.dispose();
    _quantityControl.dispose();
    _exhibitorNameControl.dispose();
    _hallNumberControl.dispose();
    _domainControl.dispose();
    super.dispose();
  }

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('addproduct'.tr()),
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back1.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Product
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'product'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Product Image & Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///Product Image
                      GestureDetector(
                        onTap: () {
                          _showPicker1(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 80.0,
                          child: image1 != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    width: 300.0,
                                    child: Image.file(
                                      image1,
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
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
                      SizedBox(
                        width: 20.0,
                      ),

                      ///Type
                      Container(
                        width: 250,
                        child: TextField(
                            controller: _domainControl,
                            keyboardType: TextInputType.name,
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

                  ///Product Name
                  TextField(
                      controller: _productNameControl,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        productName = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.boxOpen,
                          color: Colors.white,
                        ),
                        labelText: 'productname'.tr(),
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
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.5),
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
                      labelText: 'productprice'.tr(),
                      errorText: _validatePass ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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

                  ///Quantity
                  TextField(
                    controller: _quantityControl,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      quantity = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.boxes,
                        color: Colors.white,
                      ),
                      labelText: 'quantity'.tr(),
                      errorText: _validatePass ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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

                  ///Exhibitor
                  Center(
                    child: Text(
                      'exhibitor'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Exhibitor Name & Picture
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ///Exhibitor Picture
                      GestureDetector(
                        onTap: () {
                          _showPicker2(context);
                        },
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 60.0,
                              child: image2 != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0),
                                      child: Image.file(
                                        image2,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(70),
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
                                  height: 25,
                                  width: 25,
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
                                    size: 15.0,
                                  ),
                                )),
                          ],
                        ),
                      ),

                      ///Exhibitor Name
                      Container(
                        width: 230,
                        child: TextField(
                          controller: _exhibitorNameControl,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            exhibitorName = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.userTie,
                              color: Colors.white,
                            ),
                            labelText: 'name'.tr(),
                            errorText: _validatePass ? 'Can\'t Be Empty' : null,
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

                  ///Hall
                  Center(
                    child: Text(
                      'hall'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Hall Number
                  TextField(
                    controller: _hallNumberControl,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      hallNumber = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.group_rounded,
                        color: Colors.white,
                      ),
                      labelText: 'hallnumber'.tr(),
                      errorText: _validatePass ? 'Can\'t Be Empty' : null,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
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

                  ///Add & Cancel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ///Cancel
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
                            child: Text('cancel'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18.0))),
                      ),

                      ///Add
                      GestureDetector(
                        onTap: () {
                          // image1.toString()
                          // image2.toString()
                          Product newProduct = Product(
                              productName: productName,
                              productCategory: domain,
                              productImage: 'assets/images/product.png',
                              productPrice: price,
                              productRate: 0,
                              productNumberOfRatings: 0,
                              productExhibitorName: exhibitorName,
                              productExhibitorImage: 'assets/images/A.jpg',
                              productHall: hallNumber,
                              productQuantity: quantity,
                              productAbout: description,
                              productExhibition: widget.expo.exhibitionName,
                              productExhibitorEmail: _auth.currentUser.email);

                          FirebaseFirestore.instance
                              .collection('product')
                              .add(newProduct.toMap());
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
                            child: Text('add'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18.0))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future _imageFromGallery1() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera1() async {
    final pickedFile = await picker1.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromGallery2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile2 != null) {
        image2 = File(pickedFile2.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imageFromCamera2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile2 != null) {
        image2 = File(pickedFile2.path);
      } else {
        print('No image selected.');
      }
    });
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
      },
    );
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
      },
    );
  }
}
