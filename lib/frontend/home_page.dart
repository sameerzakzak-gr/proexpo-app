import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'package:proexpo/backend/sponsor.dart';
import 'package:proexpo/frontend/expo_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'camera_preview.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('exhibition');

  var firebaseUser = FirebaseAuth.instance.currentUser;
  List<Exhibition> dataList = [];
  List<Sponsor> datas = [];
  final _firestore = FirebaseFirestore.instance;
  Exhibition exhibition;
  Sponsor sponsor;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> role = ModalRoute.of(context).settings.arguments;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back1.png'), fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          body: DraggableHome(
            backgroundColor: Colors.white,
            floatingActionButton: AnimSearchBar(
                rtl: true,
                width: 310,
                textController: textController,
                onSuffixTap: () {
                  print(textController);
                  setState(() {
                    print(textController);
                    textController.clear();
                  });
                }),
            alwaysShowLeadingAndAction: true,
            title: Text(
              "expos".tr(),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            headerWidget: headerWidget(context),
            body: [
              ///the Top Of the The Header Before Exhibitions List
              Container(
                child: Column(
                  children: [
                    ///SlideUp To ...
                    Center(
                        child: Text(
                      'slideup'.tr(),
                      style: TextStyle(fontSize: 15.0, color: Colors.grey),
                    )),

                    ///Expos & Button
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'expos'.tr(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.filter_list_outlined),
                              onPressed: () {})
                        ],
                      ),
                    ),

                    ///Exhibitions List
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('exhibition').snapshots(),
                          builder: (context, snapshot) {
                            // getData();
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else
                              for (int i = 0;
                                  i < snapshot.data.docs.length;
                                  i++) {
                                final allData = snapshot.data.docs
                                    .map((doc) => doc.data())
                                    .toList();
                                final name = snapshot.data.docs
                                    .map((doc) => doc["exponame"])
                                    .toList();
                                final image = snapshot.data.docs
                                    .map((doc) => doc["expoimage"])
                                    .toList();
                                final day = snapshot.data.docs
                                    .map((doc) => doc["expoday"].toString())
                                    .toList();
                                final month = snapshot.data.docs
                                    .map((doc) => doc["expomonth"])
                                    .toList();
                                final year = snapshot.data.docs
                                    .map((doc) => doc["expoyear"].toString())
                                    .toList();
                                final startTime = snapshot.data.docs
                                    .map((doc) => doc["expostarttime"])
                                    .toList();
                                final endTime = snapshot.data.docs
                                    .map((doc) => doc["expoendtime"])
                                    .toList();

                                final description = snapshot.data.docs
                                    .map((doc) => doc["expodescription"])
                                    .toList();

                                final organizerName = snapshot.data.docs
                                    .map((doc) => doc["expoorganizername"])
                                    .toList();
                                final location = snapshot.data.docs
                                    .map((doc) => doc["location"])
                                    .toList();

                                final venue = snapshot.data.docs
                                    .map((doc) => doc["expovenue"])
                                    .toList();
                                exhibition = Exhibition(
                                  exhibitionName: name[i],
                                  exhibitionImage: (image[i] == "")
                                      ? 'assets/images/expo.png'
                                      : image[i],
                                  exhibitionDay: day[i],
                                  exhibitionMonth: month[i],
                                  exhibitionYear: year[i],
                                  exhibitionStartTime: startTime[i],
                                  exhibitionEndTime: endTime[i],
                                  exhibitionDescription: (description[i] == "")
                                      ? 'Not Specified'
                                      : description[i],
                                  exhibitionOrganizerName:
                                      (organizerName[i] == "")
                                          ? 'Not Specified'
                                          : organizerName[i],
                                  exhibitionLocation: (location[i] == "")
                                      ? 'Not Specified'
                                      : location[i],
                                  exhibitionVenue: venue[i],
                                );
                                bool flag = false;
                                if (exhibition.exhibitionName != "") {
                                  for (int i = 0; i < dataList.length; i++) {
                                    if (exhibition.exhibitionName ==
                                        dataList[i].exhibitionName) {
                                      flag = true;
                                    }
                                  }
                                }
                                if (flag) {
                                  flag = false;
                                  continue;
                                }
                                if (exhibition.exhibitionName == "" ||
                                    exhibition.exhibitionDay == null ||
                                    exhibition.exhibitionMonth == "" ||
                                    exhibition.exhibitionYear == "" ||
                                    exhibition.exhibitionStartTime == "" ||
                                    exhibition.exhibitionEndTime == "" ||
                                    exhibition.exhibitionVenue == "") {
                                  print('hiiii');
                                  print(dataList.length);
                                  continue;
                                }
                                print('byeeeee');
                                print(dataList.length);
                                dataList.add(exhibition);
                              }
                            return Container(
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                itemCount: dataList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
/*                                      Timestamp stamp = snapshot.data.docs[index]['date'];
                                      DateTime date = stamp.toDate();*/
                                  return LimitedBox(
                                    maxHeight: 260,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150.0,
                                          margin: EdgeInsets.only(
                                              left: 10.0,
                                              top: 10.0,
                                              right: 10.0),
                                          decoration: new BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    dataList[index]
                                                        .exhibitionImage),
                                                fit: BoxFit.cover),
                                            borderRadius: new BorderRadius.all(
                                              const Radius.circular(20.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(0.0,
                                                    2.0), // shadow direction: bottom right
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/sss.png'),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.white
                                                          .withOpacity(0.8),
                                                      BlendMode.darken),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              width: 56,
                                              height: 65,
                                              margin: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            top: 5,
                                                            bottom: 4),
                                                    child: Text(
                                                      dataList[index]
                                                          .exhibitionDay,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            bottom: 5),
                                                    child: Text(
                                                      dataList[index]
                                                          .exhibitionMonth,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0, bottom: 0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ExpoPage(
                                                                  dataList[
                                                                      index],
                                                                  role),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      dataList[index]
                                                          .exhibitionName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, bottom: 20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        dataList[index]
                                                            .exhibitionVenue,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                      ],
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
                          }),
                    ),
                  ],
                ),
              ),
            ],
            fullyStretchable: true,
            expandedBody: CameraPreview(role),
          ),
        ),
      ),
    );
  }

  Container headerWidget(BuildContext context) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/back1.png'),
          fit: BoxFit.cover,
        )),
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Our Sponsors & Logo
              Container(
                margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'oursponsors'.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10.0),
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),

              ///Sponsors List
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('sponsor').snapshots(),
                      builder: (context, snapshot) {
                        // getData();
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            final allData = snapshot.data.docs
                                .map((doc) => doc.data())
                                .toList();
                            final spname = snapshot.data.docs
                                .map((doc) => doc["sponsorname"])
                                .toList();
                            final spimage = snapshot.data.docs
                                .map((doc) => doc["sponsorimage"])
                                .toList();
                            final spexpo = snapshot.data.docs
                                .map((doc) => doc["sponsorexhibition"])
                                .toList();

                            sponsor = Sponsor(
                                sponsorName: spname[i],
                                sponsorImage: (spimage[i] =='')?
                                    'assets/images/CHAM WINGS.png':spimage[i],
                                sponsorExhibition: (spexpo[i]=='' )?
                                    'Not Specified':spexpo[i]);

                            bool flag = false;
                            if (sponsor.sponsorName != "") {
                              for (int i = 0; i < datas.length; i++) {
                                if (sponsor.sponsorName ==
                                    datas[i].sponsorName) {
                                  flag = true;
                                }
                              }
                            }
                            if (flag) {
                              flag = false;
                              continue;
                            }
                            if (sponsor.sponsorName == "" ||
                                sponsor.sponsorExhibition == "") {
                              continue;
                            }
                            datas.add(sponsor);
                          }
                        return Container(
                          margin: EdgeInsets.only(left: 5.0, right: 20.0),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
/*                                      Timestamp stamp = snapshot.data.docs[index]['date'];
                                        DateTime date = stamp.toDate();*/
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: LimitedBox(
                                      maxWidth: 200,
                                      child: Container(
                                        height: 60,
                                        margin: EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  datas[index].sponsorImage),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(0.0,
                                                  2.0), // shadow direction: bottom right
                                            )
                                          ],
                                        ),
                                        child: TextButton(
                                          child: Text(
                                            datas[index].sponsorName,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (builder, index) {
                              return VerticalDivider(
                                width: 10,
                                thickness: 0,
                              );
                            },
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
}
