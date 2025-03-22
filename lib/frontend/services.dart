import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'package:proexpo/backend/user.dart';
import 'package:proexpo/frontend/add_service.dart';
import 'package:search_page/search_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proexpo/backend/service.dart';
import 'package:easy_localization/easy_localization.dart';

class Services extends StatefulWidget {
  static String id = 'services';
  final Map<String, String> role;
  final Exhibition expo;
  double res1;

  Services(this.role, this.expo, this.res1);
  @override
  _ServicesState createState() => _ServicesState();
}

List<String> selectedCountList = [];

class _ServicesState extends State<Services> {
  List<Service> dataList = [];
  double res;
  final _firestore = FirebaseFirestore.instance;
  bool isFavorite = false;
  Map<String, String> role1;
  Service service;

  @override
  void initState() {
    role1 = widget.role;
    widget.res1 = res;
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
        backgroundColor: Colors.grey.withOpacity(0.4),
        tooltip: 'searchservice'.tr(),
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Service>(
            onQueryUpdate: (s) => print(s),
            items: dataList,
            searchLabel: 'searchservice'.tr(),
            suggestion: Center(
              child: Container(child: Text('filterservices'.tr())),
            ),
            failure: Center(
              child: Text('noservices'.tr()),
            ),
            filter: (service) => [
              service.serviceName,
              service.serviceProviderName,
              service.serviceType,
            ],
            builder: (service) => LimitedBox(
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
                            width: 300,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.serviceName,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(service.serviceType),
                                    ],
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue,
                                  backgroundImage:
                                      AssetImage(service.serviceImage),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  secondaryWidget: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //Website
                            IconButton(
                              onPressed: () {
                                customLaunch(
                                    'https://' + service.serviceWebsite + '/');
                              },
                              icon: Icon(
                                FontAwesomeIcons.globe,
                              ),
                              color: Colors.purple,
                            ),

                            SizedBox(
                              width: 20.0,
                            ),
                            IconButton(
                              onPressed: () {
                                customLaunch('https://wa.me/963' +
                                    service.servicePhoneNumber);
                              },
                              icon: Icon(
                                FontAwesomeIcons.whatsapp,
                              ),
                              color: Colors.green,
                            ),
                            //Email
                            SizedBox(
                              width: 20.0,
                            ),
                            IconButton(
                              onPressed: () {
                                customLaunch('mailto:' + service.serviceEmail);
                              },
                              icon: Icon(
                                FontAwesomeIcons.at,
                              ),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //Phone & SMS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //Phone
                            IconButton(
                              onPressed: () {
                                customLaunch(
                                    'tel:+963 ' + service.servicePhoneNumber);
                              },
                              icon: Icon(
                                FontAwesomeIcons.phone,
                              ),
                              color: Colors.orange,
                            ),

                            SizedBox(
                              width: 20.0,
                            ),
                            //SMS
                            IconButton(
                              onPressed: () {
                                customLaunch(
                                    'sms:' + service.servicePhoneNumber);
                              },
                              icon: Icon(
                                FontAwesomeIcons.sms,
                              ),
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            IconButton(
                              onPressed: () {
                                customLaunch('https://www.facebook.com/' +
                                    service.serviceFacebook +
                                    '/');
                              },
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                              ),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //Whatsapp & facebook
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'rateservice'.tr(),
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
                  additionalWidget: Text('contactus'.tr()),
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
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/service.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    'services'.tr(),
                    style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                role1.toString() == "{name: I'm a Service Provider, value: 12}"
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddServiceScreen(role1, widget.expo),
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
                                  'addservice'.tr(),
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
                    stream: _firestore.collection('service').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        for (int i = 0; i < snapshot.data.docs.length; i++) {
                          var allData = snapshot.data.docs
                              .map((doc) => doc.data())
                              .toList();

                          var sname = snapshot.data.docs
                              .map((doc) => doc["servicename"])
                              .toList();

                          var stype = snapshot.data.docs
                              .map((doc) => doc["servicetype"])
                              .toList();

                          var simage = snapshot.data.docs
                              .map((doc) => doc["serviceimage"])
                              .toList();

                          var srate = snapshot.data.docs
                              .map((doc) => doc["servicerate"])
                              .toList();

                          var snumofratings = snapshot.data.docs
                              .map((doc) => doc["servicenumberofratings"])
                              .toList();
                          var spemail = snapshot.data.docs
                              .map((doc) => doc["serviceprovideremail"])
                              .toList();
                          var spphone = snapshot.data.docs
                              .map((doc) => doc["serviceproviderphonenumber"])
                              .toList();
                          var spwebsite = snapshot.data.docs
                              .map((doc) => doc["serviceproviderwebsite"])
                              .toList();
                          var spfacebook = snapshot.data.docs
                              .map((doc) => doc["serviceproviderfacebook"])
                              .toList();
                          var sexpo = snapshot.data.docs
                              .map((doc) => doc["serviceexhibition"])
                              .toList();
                          var spname = snapshot.data.docs
                              .map((doc) => doc["serviceprovidername"])
                              .toList();
                          var ssumrate = snapshot.data.docs
                              .map((doc) => doc["servicesumrating"])
                              .toList();

                          service = Service(
                              serviceName: sname[i],
                              serviceType: stype[i],
                              serviceImage: (simage[i] == "")
                                  ? "assets/images/dart.png"
                                  : simage[i], //
                              serviceRate: srate[i],
                              serviceNumOfRatings: snumofratings[i],
                              serviceProviderName: spname[i],
                              serviceWebsite: (spwebsite[i] == "")
                                  ? "Not Specified"
                                  : spwebsite[i], //
                              servicePhoneNumber: spphone[i],
                              serviceEmail: (spemail[i] == "")
                                  ? "Not Specified"
                                  : spemail[i], //
                              serviceFacebook: (spfacebook[i] == "")
                                  ? "Not Specified"
                                  : spfacebook[i], //
                              serviceExhibition: sexpo[i],
                              serviceSumRating: ssumrate[i]);

                          bool flag = false;
                          if (service.serviceName != "") {
                            for (int i = 0; i < dataList.length; i++) {
                              if (service.serviceName ==
                                  dataList[i].serviceName) {
                                flag = true;
                              }
                            }
                          }
                          if (flag) {
                            flag = false;
                            continue;
                          }
                          if (service.serviceName == "" ||
                              service.serviceType == "" ||
                              service.serviceRate == "" ||
                              service.serviceNumOfRatings == "" ||
                              service.serviceProviderName == "" ||
                              service.servicePhoneNumber == "" ||
                              service.serviceExhibition == "" ||
                              service.serviceSumRating == "") {
                            continue;
                          }
                          if (widget.expo.exhibitionName ==
                              service.serviceExhibition) {
                            dataList.add(service);
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
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          dataList[index]
                                                                  .serviceName ??
                                                              'not spec',
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
                                                                .serviceType ??
                                                            'not spec'),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(
                                                    flex: 2,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/map.jpg'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    secondaryWidget: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              //Website
                                              IconButton(
                                                onPressed: () {
                                                  customLaunch('https://' +
                                                      dataList[index]
                                                          .serviceWebsite +
                                                      '/');
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.globe,
                                                ),
                                                color: Colors.purple,
                                              ),

                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  customLaunch(
                                                      'https://wa.me/963' +
                                                          dataList[index]
                                                              .servicePhoneNumber);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.whatsapp,
                                                ),
                                                color: Colors.green,
                                              ),
                                              //Email
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  customLaunch('mailto:' +
                                                      dataList[index]
                                                          .serviceEmail);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.at,
                                                ),
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          //Phone & SMS
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              //Phone
                                              IconButton(
                                                onPressed: () {
                                                  customLaunch('tel:+963 ' +
                                                      dataList[index]
                                                          .servicePhoneNumber);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.phone,
                                                ),
                                                color: Colors.orange,
                                              ),

                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              //SMS
                                              IconButton(
                                                onPressed: () {
                                                  customLaunch('sms:' +
                                                      dataList[index]
                                                          .servicePhoneNumber);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.sms,
                                                ),
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  customLaunch(
                                                      'https://www.facebook.com/' +
                                                          dataList[index]
                                                              .serviceFacebook);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.facebook,
                                                ),
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          //Whatsapp & facebook
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'rateservice'.tr(),
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
                                                  /*print(_firestore.collection('service').);*/

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
                                                  res = rate;
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
                                    additionalWidget: Text('contactus'.tr()),
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
