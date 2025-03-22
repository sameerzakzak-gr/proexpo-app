import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proexpo/backend/service.dart';

class MyServicesScreen extends StatefulWidget {
  static const String id = 'my_services';
  @override
  _MyServicesScreenState createState() => _MyServicesScreenState();
}

List<Service> myServices = [];
Service service;
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class _MyServicesScreenState extends State<MyServicesScreen> {
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
                    image: AssetImage('assets/images/service.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  'myservices'.tr(),
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
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
                            .map((doc) => doc["servicerate"].toString())
                            .toList();

                        var snumofratings = snapshot.data.docs
                            .map((doc) =>
                                doc["servicenumberofratings"].toString())
                            .toList();
                        var spemail = snapshot.data.docs
                            .map((doc) => doc["serviceprovideremail"])
                            .toList();
                        var spphone = snapshot.data.docs
                            .map((doc) =>
                                doc["serviceproviderphonenumber"].toString())
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

                        service = Service(
                            serviceName: sname[i],
                            serviceType: stype[i],
                            serviceImage: (simage[i] == "")
                                ? "assets/images/dart.png"
                                : simage[i],
                            //
                            serviceRate: srate[i],
                            serviceNumOfRatings: snumofratings[i],
                            serviceProviderName: spname[i],
                            serviceWebsite: (spwebsite[i] == "")
                                ? "Not Specified"
                                : spwebsite[i],
                            //
                            servicePhoneNumber: spphone[i],
                            serviceEmail: spemail[i],
                            //
                            serviceFacebook: (spfacebook[i] == "")
                                ? "Not Specified"
                                : spfacebook[i],
                            //
                            serviceExhibition: sexpo[i]);

                        bool flag = false;
                        if (service.serviceName != "") {
                          for (int i = 0; i < myServices.length; i++) {
                            if (service.serviceName ==
                                myServices[i].serviceName) {
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
                            service.serviceRate == null ||
                            service.serviceNumOfRatings == null ||
                            service.serviceProviderName == "" ||
                            service.servicePhoneNumber == null ||
                            service.serviceExhibition == "" ||
                            service.serviceEmail == "") {
                          continue;
                        }
                        // if (_auth.currentUser.email == service.serviceEmail) {
                        // }
                        myServices.add(service);

                      }
                      return Container(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: myServices.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SwipeActionCell(
                                backgroundColor: Colors.transparent,
                                key: ObjectKey(myServices[index]),

                                ///this key is necessary
                                performsFirstActionWithFullSwipe: true,
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                      title: 'delete'.tr(),
                                      onTap: (CompletionHandler handler) async {
                                        myServices.removeAt(index);
                                        setState(() {});
                                      },
                                      color: Colors.red),
                                ],
                                child: Container(
                                  height: 160.0,
                                  margin:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 20.0, right: 20.0, left: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  myServices[index]
                                                      .serviceImage),
                                              radius: 40.0,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    myServices[index]
                                                        .serviceName,
                                                    style: TextStyle(
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    myServices[index]
                                                        .serviceType,
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                /*    Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text("this is index of ${products[index]}",
                              style: TextStyle(fontSize: 40)),
                        ),*/
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
      ),
    );
  }
}
