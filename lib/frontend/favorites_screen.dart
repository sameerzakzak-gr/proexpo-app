import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proexpo/backend/product.dart';
import 'package:proexpo/frontend/who_your.dart';
import 'expo_model.dart';
import 'expo_page.dart';
import 'package:easy_localization/easy_localization.dart';
// class Product {
//   String imgProduct;
//   // product id
//   int id;
//   // product name
//   String name;
//   // product description
//   String description;
//   //product category
//   String category;
//   // reference of the contributing exhibitor(owner) of the product
// /*  Contributor _ce;*/
//   // price of the product
//   double price;
//   int quantityLeft;
//
// /*  List<Order> orders = [];*/
//   /*Review review;*/
//   //constructor
//   Product(this.id, this.name, this.description, this.category, this.price,
//       this.quantityLeft);
// }

class FavouritesScreen extends StatefulWidget {
  static String id = 'favourites_screen';
  List<Product> products = [];
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Expo> dataList = upcomingEvents;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> roles = ModalRoute.of(context).settings.arguments;

    final _tabPages = <Widget>[
      ///Expos
      Container(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          itemCount: dataList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return LimitedBox(
              maxHeight: 120,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 120.0,
                      width: 120.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(dataList[index].image),
                            fit: BoxFit.cover),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                0.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                          child: TextButton(
                            /* onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    ExpoPage(dataList[index], roles),
                              ));
                            },*/
                            child: Text(
                              dataList[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                dataList[index].location,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.blueGrey,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (builder, index) {
            return Divider(
              height: 30,
              thickness: 0,
            );
          },
        ),
      ),

      ///Exhibitors
      Container(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return LimitedBox(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Expandable.extended(
                  onPressed: () {},
                  elevation: 10,
                  isClickable: false,
                  initiallyExpanded: false,
                  centralizePrimaryWidget: true,
                  centralizeAdditionalWidget: true,
                  primaryWidget: Container(
                    height: 60,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Domain'),
                            ],
                          ),
                          SizedBox(
                            width: 160,
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/A.jpg'),
                            radius: 20.0,
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
                        Container(
                          height: 120.0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        '1.2k ' + 'ratings'.tr(),
                                        style: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        '3.4',
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
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/map.jpg'),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        'H11',
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
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        '300',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('employeenum'.tr()),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  width: 25,
                                  thickness: 1,
                                ),
                                Container(
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/A.jpg'),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('ceo'.tr()),
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
                        Text('about'.tr()),
                        Text('location'.tr()),
                        Text('contactinfo'.tr()),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/map.jpg'),
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
                                  Text('product name'),
                                ],
                              ),
                              VerticalDivider(
                                width: 25,
                                thickness: 1,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/map.jpg'),
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
                                  Text('product name'),
                                ],
                              ),
                              VerticalDivider(
                                width: 25,
                                thickness: 1,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/map.jpg'),
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
                                  Text('product name'),
                                ],
                              ),
                              VerticalDivider(
                                width: 25,
                                thickness: 1,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/map.jpg'),
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
                                  Text('product name'),
                                ],
                              ),
                              VerticalDivider(
                                width: 25,
                                thickness: 1,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/map.jpg'),
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
                                  Text('product name'),
                                ],
                              ),
                              VerticalDivider(
                                width: 25,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'rateexhibitor'.tr(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 0.5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  arrowWidget: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.blueGrey,
                    size: 20.0,
                  ),
                  additionalWidget: Text('more'.tr()),
                  arrowLocation: ArrowLocation.right,
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
      ),

      ///Products
      Container(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemCount: widget.products.length,
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
                                        widget.products[index].productName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(widget
                                          .products[index].productCategory
                                          .toString()),
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
                                      image:
                                          AssetImage('assets/images/map.jpg'),
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
                              Text(widget.products[index].productPrice
                                      .toString() +
                                  '\$'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  secondaryWidget: Container(
                    height: 400,
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
                        Container(
                          height: 120.0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        '1.2k ' + 'ratings'.tr(),
                                        style: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        '3.4',
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
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/A.jpg'),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        'Inmar',
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
                                  width: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/map.jpg'),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        'H11',
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
                                  width: 80.0,
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
                        Text('About' + widget.products[index].productAbout),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'rateproduct'.tr(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 0.5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 5.0),
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
      ),
    ];
    final _tabs = <Tab>[
      Tab(text: 'expos'.tr()),
      Tab(text: 'exhibitors'.tr()),
      Tab(text: 'products'.tr()),
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.red),
          title: Text(
            'favorites'.tr(),
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/back1.png'),
            fit: BoxFit.cover,
          )),
          child: TabBarView(
            children: _tabPages,
          ),
        ),
      ),
    );
  }
}
