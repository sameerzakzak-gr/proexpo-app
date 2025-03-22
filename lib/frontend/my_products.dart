import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:proexpo/backend/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProducts extends StatefulWidget {
  static const String id = 'my_products';
  @override
  _MyProductsState createState() => _MyProductsState();
}

List<Product> myProducts = [];
final _firestore = FirebaseFirestore.instance;
Product product;
final _auth = FirebaseAuth.instance;

class _MyProductsState extends State<MyProducts> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/product.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  'myproducts'.tr(),
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('product').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        final allData = snapshot.data.docs
                            .map((doc) => doc.data())
                            .toList();

                        final pname = snapshot.data.docs
                            .map((doc) => doc["productname"])
                            .toList();
                        final pcategory = snapshot.data.docs
                            .map((doc) => doc["productcategory"])
                            .toList();

                        final pimage = snapshot.data.docs
                            .map((doc) => doc["productimage"])
                            .toList();

                        final prate = snapshot.data.docs
                            .map((doc) => doc["productrate"])
                            .toList();

                        final pnumofratings = snapshot.data.docs
                            .map((doc) => doc["productnumberofratings"])
                            .toList();

                        final phall = snapshot.data.docs
                            .map((doc) => doc["producthall"])
                            .toList();

                        final pprice = snapshot.data.docs
                            .map((doc) => doc["productprice"])
                            .toList();
                        final pconimg = snapshot.data.docs
                            .map((doc) => doc["productcontributorImage"])
                            .toList();
                        final pconname = snapshot.data.docs
                            .map((doc) => doc["productcontributorname"])
                            .toList();
                        final pabout = snapshot.data.docs
                            .map((doc) => doc["productabout"])
                            .toList();
                        final pquan = snapshot.data.docs
                            .map((doc) => doc["productquantity"])
                            .toList();
                        final pexpo = snapshot.data.docs
                            .map((doc) => doc["productexhibition"])
                            .toList();
                        final pexpoemail = snapshot.data.docs
                            .map((doc) => doc["productexhibitoremail"])
                            .toList();

                        product = Product(
                            productName: pname[i],
                            productAbout: (pabout[i] == "")
                                ? "Not Specified"
                                : pabout[i], //
                            productCategory: pcategory[i],
                            productExhibition: pexpo[i],
                            productExhibitorImage: (pconimg[i] == "")
                                ? "Not Specified"
                                : pconimg[i], //
                            productExhibitorName: pconname[i],
                            productHall: phall[i],
                            productImage: pimage[i],
                            productNumberOfRatings: pnumofratings[i],
                            productPrice: pprice[i],
                            productQuantity: (pquan[i] == null)
                                ? "Not Specified"
                                : pquan[i], //
                            productRate: prate[i],
                            productExhibitorEmail: pexpoemail[i]);
                        bool flag = false;
                        if (product.productName != "") {
                          for (int i = 0; i < myProducts.length; i++) {
                            if (product.productName ==
                                myProducts[i].productName) {
                              flag = true;
                            }
                          }
                        }
                        if (flag) {
                          flag = false;
                          continue;
                        }
                        if (product.productName == "" ||
                            product.productCategory == "" ||
                            product.productExhibition == "" ||
                            product.productExhibitorName == "" ||
                            product.productHall == "" ||
                            product.productImage == "" ||
                            product.productNumberOfRatings == null ||
                            product.productPrice == null ||
                            product.productRate == null ||
                            product.productExhibitorEmail == "") {
                          continue;
                        }
                        // if (_auth.currentUser.email ==
                        //     product.productExhibitorEmail) {
                        //
                        // }
                        myProducts.add(product);
                      }
                      return Container(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: myProducts.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SwipeActionCell(
                                backgroundColor: Colors.transparent,
                                key: ObjectKey(myProducts[index]),

                                ///this key is necessary
                                performsFirstActionWithFullSwipe: true,
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                      title: 'delete'.tr(),
                                      onTap: (CompletionHandler handler) async {
                                        myProducts.removeAt(index);
                                        setState(() {});
                                      },
                                      color: Colors.red),
                                ],
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      height: 160.0,
                                      margin: EdgeInsets.only(
                                          right: 10.0, left: 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 20.0,
                                                right: 20.0,
                                                left: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      myProducts[index]
                                                          .productImage),
                                                  radius: 40.0,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                      child: Text(
                                                        myProducts[index]
                                                            .productName,
                                                        style: TextStyle(
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                      child: Text(
                                                        myProducts[index]
                                                            .productCategory,
                                                        style: TextStyle(
                                                            fontSize: 18.0),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 20.0,
                                                right: 20.0,
                                                left: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Price:',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                Text(
                                                  myProducts[index]
                                                      .productPrice
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "\$",
                                                  style: TextStyle(
                                                      color: Colors.green[800],
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          },
                          separatorBuilder: (builder, index) {
                            return Divider(
                              height: 10,
                              thickness: 0,
                            );
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
