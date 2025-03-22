import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:proexpo/backend/contributor.dart';

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'package:search_page/search_page.dart';

class ExhibitorsScreen extends StatefulWidget {
  static const String id = 'exhibitors_screen';

  final Map<String, String> role;
  final Exhibition expo;

  ExhibitorsScreen(this.role, this.expo);
  @override
  _ExhibitorsScreenState createState() => _ExhibitorsScreenState();
}

class _ExhibitorsScreenState extends State<ExhibitorsScreen> {
  List<Contributor> dataList = [];

  final _firestore = FirebaseFirestore.instance;

  bool isFavorite = false;
  Contributor contributor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.7),
        tooltip: 'searchexhibitors'.tr(),
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Contributor>(
            onQueryUpdate: (s) => print(s),
            items: dataList,
            searchLabel: 'filterexhibitors'.tr(),
            suggestion: Center(
              child: Container(child: Text('filterexhibitors'.tr())),
            ),
            failure: Center(
              child: Text('noexhibitors'.tr()),
            ),
            filter: (contributor) => [
              contributor.contributorName,
              contributor.contributorDomain,
              contributor.ceoName,
            ],
            builder: (contributor) => LimitedBox(
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
                    width: 300,
                    height: 60,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contributor.contributorName,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(contributor.contributorDomain),
                            ],
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(contributor.contributorImage),
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
                                  width: 100.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        contributor.contributorNumberOfRatings
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
                                        contributor.contributorRate.toString(),
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
                                        backgroundImage:
                                            AssetImage('assets/images/map.jpg'),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        contributor.contributorHall,
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
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        contributor.contributorNumberOfEmployees
                                            .toString(),
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
                                            AssetImage(contributor.ceoImage),
                                        radius: 15.0,
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        contributor.ceoName,
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
                        Text(contributor.contributorAbout),
                        Text(contributor.contributorLocation),
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
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/exhibit.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(30.0),
                  bottomRight: const Radius.circular(30.0),
                ),
              ),
              child: Center(
                  child: Text(
                'exhibitors'.tr(),
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('contributor').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    for (int i = 0; i < snapshot.data.docs.length; i++) {
                      final allData =
                          snapshot.data.docs.map((doc) => doc.data()).toList();

                      final name = snapshot.data.docs
                          .map((doc) => doc["contributorname"])
                          .toList();

                      final domain = snapshot.data.docs
                          .map((doc) => doc["contributorndomain"])
                          .toList();

                      final image = snapshot.data.docs
                          .map((doc) => doc["contributorimage"])
                          .toList();

                      final rate = snapshot.data.docs
                          .map((doc) => doc["contributorrate"].toString())
                          .toList();

                      final numofratings = snapshot.data.docs
                          .map((doc) =>
                              doc["contributornumberofratings"].toString())
                          .toList();

                      final hall = snapshot.data.docs
                          .map((doc) => doc["contributorhall"])
                          .toList();

                      final empNum = snapshot.data.docs
                          .map((doc) =>
                              doc["contributornumofemployees"].toString())
                          .toList();
                      final ceoname = snapshot.data.docs
                          .map((doc) => doc["contributorceoname"])
                          .toList();
                      final ceoimage = snapshot.data.docs
                          .map((doc) => doc["contributorceoimage"])
                          .toList();
                      final about = snapshot.data.docs
                          .map((doc) => doc["contributorabout"])
                          .toList();
                      final location = snapshot.data.docs
                          .map((doc) => doc["contributorlocation"])
                          .toList();
                      final email = snapshot.data.docs
                          .map((doc) => doc["contributoremail"])
                          .toList();
                      final phone = snapshot.data.docs
                          .map(
                              (doc) => doc["contributorphonenumber"].toString())
                          .toList();
                      final website = snapshot.data.docs
                          .map((doc) => doc["contributorwebsite"])
                          .toList();
                      final facebook = snapshot.data.docs
                          .map((doc) => doc["contributorfacebook"])
                          .toList();
                      final expo = snapshot.data.docs
                          .map((doc) => doc["contributorexhibition"])
                          .toList();
                      contributor = Contributor(
                          contributorName: name[i],
                          contributorDomain: domain[i],
                          contributorImage: image[i],
                          contributorRate: rate[i],
                          contributorNumberOfRatings: numofratings[i],
                          contributorHall: hall[i],
                          contributorNumberOfEmployees: (empNum[i] == "")
                              ? "Not Specified"
                              : empNum[i], //
                          ceoName: (ceoname[i] == "")
                              ? "Not Specified"
                              : ceoname[i], //
                          ceoImage: (ceoimage[i] == "")
                              ? "assets/images/dart.png"
                              : ceoimage[i], //
                          contributorAbout:
                              (about[i] == "") ? "Not Specified" : about[i], //
                          contributorLocation: location[i],
                          contributorWebsite: (website[i] == "")
                              ? "Not Specified"
                              : website[i], //
                          contributorPhoneNumber:
                              (phone[i] == "") ? "Not Specified" : phone[i], //
                          contributorEmail: email[i],
                          contributorFacebook: (facebook[i] == "")
                              ? "Not Specified"
                              : facebook[i], //
                          contributorExhibition: expo[i]);

                      bool flag = false;
                      if (contributor.contributorName != "") {
                        for (int i = 0; i < dataList.length; i++) {
                          if (contributor.contributorName ==
                              dataList[i].contributorName) {
                            flag = true;
                          }
                        }
                      }
                      if (flag) {
                        flag = false;
                        continue;
                      }
                      if (contributor.contributorName == "" ||
                          contributor.contributorDomain == "" ||
                          contributor.contributorImage == "" ||
                          contributor.contributorRate == null ||
                          contributor.contributorNumberOfRatings == null ||
                          contributor.contributorHall == "" ||
                          contributor.contributorLocation == "" ||
                          contributor.contributorEmail == "" ||
                          contributor.contributorExhibition == "") {
                        continue;
                      }
                      if (widget.expo.exhibitionName ==
                          contributor.contributorExhibition) {

                      }
                      dataList.add(contributor);
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
                                onPressed: () {},
                                elevation: 10,
                                isClickable: false,
                                initiallyExpanded: false,
                                centralizePrimaryWidget: false,
                                centralizeAdditionalWidget: true,
                                primaryWidget: Container(
                                  width: 300,
                                  height: 60,
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataList[index].contributorName,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(dataList[index]
                                                .contributorDomain),
                                          ],
                                        ),
                                        Spacer(
                                          flex: 2,
                                        ),
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage('assets/images/A.jpg'),
                                          radius: 20.0,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Text(
                                                      dataList[index]
                                                              .contributorNumberOfRatings
                                                              .toString() +
                                                          ' ratings'.tr(),
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Text(
                                                      dataList[index]
                                                          .contributorRate
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                      backgroundImage: AssetImage(
                                                          'assets/images/map.jpg'),
                                                      radius: 15.0,
                                                    ),
                                                    SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Text(
                                                      dataList[index]
                                                          .contributorHall,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                    SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Text(
                                                      '${dataList[index].contributorNumberOfEmployees}',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                      backgroundImage: AssetImage(
                                                          '${dataList[index].ceoImage}'),
                                                      radius: 15.0,
                                                    ),
                                                    SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Text(
                                                      '${dataList[index].ceoName}',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('addfavourites'.tr()),
                                          InkWell(
                                            customBorder: CircleBorder(),
                                            onTap: () => setState(
                                                () => isFavorite = !isFavorite),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                  isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red
                                                      .withOpacity(0.9)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          '${dataList[index].contributorAbout}'),
                                      Text(
                                          '${dataList[index].contributorLocation}'),
                                      Text(
                                          '${dataList[index].contributorPhoneNumber}'),
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
                                                      image: AssetImage(
                                                          'assets/images/map.jpg'),
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              BlendMode.darken),
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
                                                    ),
                                                  ),
                                                ),
                                                // Text(dataList[index].contributorProducts.first.toString()),
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
                                                      image: AssetImage(
                                                          'assets/images/map.jpg'),
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              BlendMode.darken),
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
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
                                                      image: AssetImage(
                                                          'assets/images/map.jpg'),
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              BlendMode.darken),
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
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
                                                      image: AssetImage(
                                                          'assets/images/map.jpg'),
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              BlendMode.darken),
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
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
                                                      image: AssetImage(
                                                          'assets/images/map.jpg'),
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              BlendMode.darken),
                                                    ),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                      const Radius.circular(
                                                          10.0),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'rateexhibitor'.tr(),
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingBar.builder(
                                            initialRating: 3,
                                            minRating: 0.5,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) async {
                                              DocumentReference docRef =
                                                  _firestore
                                                      .collection("contributor")
                                                      .doc();

                                              DocumentSnapshot docSnap =
                                                  await docRef.get();
                                              var docId2 = docSnap.reference.id;
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
                    );
                  }
                })
          ]),
        ),
      ),
    );
  }
}
