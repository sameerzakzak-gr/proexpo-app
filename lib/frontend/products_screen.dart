import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'package:proexpo/frontend/sort_screen.dart';
import 'package:search_page/search_page.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:url_launcher/url_launcher.dart';
import 'add_products.dart';
import 'package:proexpo/backend/product.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductsScreen extends StatefulWidget {
  static const String id = 'products_screen';
  final Exhibition expo;
  final Map<String, String> role;
  ProductsScreen(this.role, this.expo);
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

List<String> selectedCountList = [];

class _ProductsScreenState extends State<ProductsScreen> {
  bool isFavorite = false;
  Map<String, String> role1;
  List<Product> dataList = [];
  Product product;
  final _firestore = FirebaseFirestore.instance;

  String searchText;
  @override
  void initState() {
    role1 = widget.role;
    super.initState();
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could'nt Launch $command");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.7),
        tooltip: 'searchproduct'.tr(),
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Product>(
            onQueryUpdate: (s) => print(s),
            items: dataList,
            searchLabel: 'searchproduct'.tr(),
            suggestion: Center(
              child: Container(child: Text('filterproduct'.tr())),
            ),
            failure: Center(
              child: Text('noproduct'.tr()),
            ),
            filter: (product) => [
              product.productName,
              product.productCategory,
              product.productPrice,
            ],
            builder: (product) => LimitedBox(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Expandable.extended(
                  elevation: 10,
                  isClickable: false,
                  initiallyExpanded: false,
                  centralizePrimaryWidget: true,
                  centralizeAdditionalWidget: true,
                  primaryWidget: Container(
                    height: 150,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productName.toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(product.productCategory.toString()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Container(
                                  height: 75,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(product.productImage),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.grey.withOpacity(0.6),
                                          BlendMode.darken),
                                    ),
                                    borderRadius: new BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('price'.tr()),
                              SizedBox(
                                width: 170,
                              ),
                              Text(product.productPrice.toString() + '\$'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  secondaryWidget: Container(
                    height: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('addfavourites'.tr()),
                            InkWell(
                              customBorder: CircleBorder(),
                              onTap: () =>
                                  setState(() => isFavorite = !isFavorite),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red.withOpacity(0.9)),
                              ),
                            ),
                          ],
                        ),

                        ///PeoductInfo
                        Container(
                          height: 120.0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  width: 100.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        product.productNumberOfRatings
                                                .toString() +
                                            'ratings'.tr(),
                                        style: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        product.productRate.toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        'rate'.tr(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  width: 25,
                                  thickness: 1,
                                ),
                                Container(
                                  width: 100.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            product.productExhibitorImage),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        product.productExhibitorName,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('exhibitor'.tr()),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  width: 25,
                                  thickness: 1,
                                ),
                                Container(
                                  width: 100.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage(product.productImage),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        product.productHall,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('hall'.tr()),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  width: 25,
                                  thickness: 1,
                                ),
                                Container(
                                  width: 100.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Icon(
                                        Icons.inbox,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        '20',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('quantity'.tr()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Text('about'.tr() + product.productAbout),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'rateproduct'.tr(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'ordernow'.tr(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            FloatingActionButton(
                              backgroundColor:
                                  Colors.orangeAccent.withOpacity(0.8),
                              child: Icon(Icons.shopping_cart),
                              onPressed: () {
                                _showDialog();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  arrowWidget: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.blueGrey,
                    size: 20.0,
                  ),
                  additionalWidget: Text('more'.tr()),
                  arrowLocation: ArrowLocation.left,
                ),
              ),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                    'products'.tr(),
                    style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SortScreen(role1, dataList),
                      ),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30.0)),
                      width: 170,
                      height: 60.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'sort'.tr(),
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.deepPurple,
                          )
                        ],
                      )),
                ),
                role1.toString() == "{name: I'm an Exhibitor, value: 12}"
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddProducts(role1, widget.expo),
                            ),
                          );
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(30.0)),
                            width: 170,
                            height: 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'addproduct'.tr(),
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.deepPurple,
                                )
                              ],
                            )),
                      )
                    : SizedBox(),
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
                              productPrice: (pprice[i] == "")
                                  ? "Not Specified"
                                  : pprice[i],
                              productQuantity: (pquan[i] == "")
                                  ? "Not Specified"
                                  : pquan[i], //
                              productRate: prate[i],
                              productExhibitorEmail: pexpoemail[i]);

                          bool flag = false;
                          if (product.productName != "") {
                            for (int i = 0; i < dataList.length; i++) {
                              if (product.productName ==
                                  dataList[i].productName) {
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
                              product.productRate == null ||
                              product.productExhibitorEmail == "") {
                            continue;
                          }
                          if (widget.expo.exhibitionName ==
                              product.productExhibition) {
                            dataList.add(product);
                          }
                        }
                        return Container(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return LimitedBox(
                                child: Container(
                                  margin: EdgeInsets.all(20.0),
                                  child: Expandable.extended(
                                    elevation: 10,
                                    isClickable: false,
                                    initiallyExpanded: false,
                                    centralizePrimaryWidget: true,
                                    centralizeAdditionalWidget: true,
                                    primaryWidget: Container(
                                      height: 150,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          dataList[index]
                                                              .productName,
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(dataList[index]
                                                            .productCategory),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(
                                                    flex: 2,
                                                  ),
                                                  Container(
                                                    height: 75,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            dataList[index]
                                                                .productImage),
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.6),
                                                                BlendMode
                                                                    .darken),
                                                      ),
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                        const Radius.circular(
                                                            10.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              width: 275,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('price'.tr()),
                                                  Spacer(
                                                    flex: 1,
                                                  ),
                                                  Text(dataList[index]
                                                          .productPrice +
                                                      '\$'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    secondaryWidget: Container(
                                      height: 450,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text('addfavourites'.tr()),
                                              InkWell(
                                                customBorder: CircleBorder(),
                                                onTap: () => setState(() =>
                                                    isFavorite = !isFavorite),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                      isFavorite
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: Colors.red
                                                          .withOpacity(0.9)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 100.0,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 100.0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        Text(
                                                          dataList[index]
                                                                  .productNumberOfRatings
                                                                  .toString() +
                                                              'ratings'.tr(),
                                                          style: TextStyle(
                                                            fontSize: 10.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text(
                                                          dataList[index]
                                                              .productRate
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text(
                                                          'rate'.tr(),
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 25,
                                                    thickness: 1,
                                                  ),
                                                  Container(
                                                    width: 100.0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(dataList[
                                                                      index]
                                                                  .productExhibitorImage),
                                                          radius: 15.0,
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text(
                                                          dataList[index]
                                                              .productExhibitorName,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text('exhibitor'.tr()),
                                                      ],
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 25,
                                                    thickness: 1,
                                                  ),
                                                  Container(
                                                    width: 100.0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/map.jpg'),
                                                          radius: 15.0,
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text(
                                                          dataList[index]
                                                              .productHall,
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text('hall'.tr()),
                                                      ],
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 25,
                                                    thickness: 1,
                                                  ),
                                                  Container(
                                                    width: 100.0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        Icon(
                                                          Icons.inbox,
                                                          size: 25,
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text(
                                                          dataList[index]
                                                              .productQuantity
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Text('quantity'.tr()),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Text('About\n' +
                                              dataList[index].productAbout),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'rateproduct'.tr(),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 0.5,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) async {
                                                  DocumentReference docRef =
                                                      _firestore
                                                          .collection("service")
                                                          .doc();

                                                  DocumentSnapshot docSnap =
                                                      await docRef.get();
                                                  var docId2 =
                                                      docSnap.reference.id;
                                                  print(docId2);
                                                  double newSum = double.parse(
                                                      dataList[index]
                                                          .serviceSumRating);
                                                  double rate;
                                                  int numOfRatings = int.parse(
                                                      dataList[index]
                                                          .serviceNumOfRatings);
                                                  numOfRatings++;
                                                  newSum += rating;
                                                  rate = newSum / numOfRatings;
                                                  print(rate);
                                                },
                                              ),
                                              SizedBox(height: 5.0),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'ordernow'.tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              FloatingActionButton(
                                                backgroundColor: Colors
                                                    .orangeAccent
                                                    .withOpacity(0.8),
                                                child:
                                                    Icon(Icons.shopping_cart),
                                                onPressed: () {
                                                  _showDialog();
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    arrowWidget: Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: Colors.blueGrey,
                                      size: 20.0,
                                    ),
                                    additionalWidget: Text('more'.tr()),
                                    arrowLocation: ArrowLocation.left,
                                  ),
                                ),
                              );
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
                    })
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Container(
              height: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ///Title
                  Text(
                    'toorder'.tr(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Website & Email
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ///Website
                        TextButton(
                          onPressed: () {
                            customLaunch('https://www.google.com/');
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepPurple),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.globe,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'website'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),

                        ///Email
                        TextButton(
                          onPressed: () {
                            customLaunch('mailto:nabe8sa@gmail.com');
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.at,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'email'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///Phone & SMS
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ///Phone
                        TextButton(
                          onPressed: () {
                            customLaunch('tel:+963 937 567 233');
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.amber),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'phone'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),

                        ///SMS
                        TextButton(
                          onPressed: () {
                            customLaunch('sms:937 567 233');
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.sms,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'sms'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///WhatsApp & facebook
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ///WhatsApp
                        TextButton(
                          onPressed: () {
                            customLaunch('https://wa.me/963937567233');
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'whatsapp'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),

                        ///Facebook
                        TextButton(
                          onPressed: () {
                            customLaunch(
                                'https://www.facebook.com/damascus.fite/');
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'facebook',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Web & Email
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
