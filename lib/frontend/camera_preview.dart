import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:proexpo/frontend/about_screen.dart';
import 'package:proexpo/frontend/interested_screen.dart';
import 'package:proexpo/frontend/my_products.dart';
import 'package:proexpo/frontend/profile.dart';
import 'package:proexpo/frontend/settings.dart';
import 'package:proexpo/frontend/who_your.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorites_screen.dart';
import 'statistics_screen.dart';
import 'my_services.dart';
import 'profile2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'statistics2_screen.dart';

class CameraPreview extends StatefulWidget {
  final Map<String, String> role;
  CameraPreview(this.role);
  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
  display() {
    if (displayName != null) {
      return Text(
        displayName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    } else {
      return Text(
        'Sameer Zakzak',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }
  }

  display1() {
    if (email != null) {
      return Text(
        'email:' + email,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      );
    } else {
      return Text(
        'email:samirzaczac@outlook.com',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      );
    }
  }

  display2() {
    if (phone != null) {
      return Text(
        'phone:' + phone,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      );
    } else {
      return Text(
        'phone:+963932370101',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      );
    }
  }

  Map<String, String> role1;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    role1 = widget.role;
    super.initState();
    getDataName();
    getDataEmail();
    getDataPhone();
  }

  String displayName = "";
  String email = "";
  String phone = "";
  getDataName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
  }

  getDataEmail() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    setState(() {
      email = prefs2.getString('email');
    });
  }

  getDataPhone() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs1.getString('phone');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _role = ModalRoute.of(context).settings.arguments;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back1.png'),
                fit: BoxFit.cover),
          ),
        ),
        SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/back1.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 30,
                    left: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/A.jpg'),
                          radius: 52,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                display(),
                                Text(
                                  '( AI Engineer )',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            display1(),
                            SizedBox(
                              height: 10.0,
                            ),
                            display2(),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Location: Damascus,Syria',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),

                ///Edit
                Positioned(
                    top: 30,
                    right: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(.5),
                          child: IconButton(
                            onPressed: () {
                              if (_role.toString() ==
                                  "{name: I'm a Visitor, value: 12}") {
                                print('visit');
                                Navigator.pushNamed(context, Profile2.id,
                                    arguments: _role);
                              } else if (_role.toString() ==
                                  "{name: I'm an Exhibitor, value: 12}") {
                                Navigator.pushNamed(context, ProfileScreen.id,
                                    arguments: _role);

                                print('exhibit');
                              } else if (_role.toString() ==
                                  "{name: I'm a Service Provider, value: 12}") {
                                Navigator.pushNamed(context, Profile2.id,
                                    arguments: _role);

                                print('serv');
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),

                ///Home
                Positioned(
                    top: 200,
                    left: 40,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              Text(
                                'home'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    )),

                ///Interested
                Positioned(
                    top: 200,
                    right: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, InterestedScreen.id,
                            arguments: role1);
                      },
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.7),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.bookmarks,
                                color: Colors.white,
                              ),
                              Text(
                                'interested'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    )),

                ///Favorites
                Positioned(
                    top: 275,
                    left: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, FavouritesScreen.id,
                            arguments: role1);
                      },
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.7),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              Text(
                                'favorites'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    )),

                ///AboutUs
                Positioned(
                    top: 275,
                    right: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AboutScreen.id);
                      },
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.yellowAccent.withOpacity(.8),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              Text(
                                'aboutus'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    )),

                ///Settings
                Positioned(
                    top: 350,
                    left: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SettingsScreen.id);
                      },
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(.7),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              Text(
                                'settings'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    )),

                ///LogOut
                Positioned(
                    top: 350,
                    right: 40,
                    child: TextButton(
                      onPressed: () {
                        Future logout() async {
                          await _firebaseAuth.signOut().then((value) =>
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  WhoYouAre.id, (route) => false,
                                  arguments: _role));
                        }

                        logout();
                      },
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.7),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.directions_walk,
                                color: Colors.white,
                              ),
                              Text(
                                'logout'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    )),
                role1.toString() == "{name: I'm an Exhibitor, value: 12}"

                    ///MyProducts (Exhibitor)
                    ? Positioned(
                        top: 430,
                        right: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyProducts.id);
                          },
                          child: Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.fastfood,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'myproducts'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ))
                    : Positioned(
                        top: 430,
                        right: 40,
                        child: TextButton(onPressed: () {}, child: Text(''))),
                role1.toString() == "{name: I'm a Service Provider, value: 12}"

                    ///MyServices (Service Provider)
                    ? Positioned(
                        top: 430,
                        right: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyServicesScreen.id);
                          },
                          child: Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.fastfood,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'myservices'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ))
                    : Positioned(
                        top: 430,
                        right: 40,
                        child: TextButton(onPressed: () {}, child: Text(''))),
                role1.toString() == "{name: I'm an Exhibitor, value: 12}"

                    ///MyStatistics (Exhibitor)
                    ? Positioned(
                        top: 430,
                        left: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, StatisticsScreen.id);
                          },
                          child: Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.swap_vertical_circle,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'mystatistics'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ))
                    : Positioned(
                        top: 430,
                        left: 40,
                        child: TextButton(onPressed: () {}, child: Text(''))),
                role1.toString() == "{name: I'm a Service Provider, value: 12}"

                    ///MyStatistics (ServiceProvider)
                    ? Positioned(
                        top: 430,
                        left: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Statistics2Screen.id);
                          },
                          child: Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.swap_vertical_circle,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'mystatistics'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ))
                    : Positioned(
                        top: 430,
                        left: 40,
                        child: TextButton(onPressed: () {}, child: Text(''))),

                ///RateApp
                Positioned(
                    top: 530,
                    right: 130,
                    child: TextButton(
                      onPressed: _showRatingDialog,
                      child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.7),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.starHalfAlt,
                                color: Colors.white,
                              ),
                              Text(
                                'rateapp'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
  // void _showDialog() {
  //   slideDialog.showSlideDialog(
  //     context: context,
  //     child:
  //     barrierColor: Colors.white.withOpacity(0.7),
  //     pillColor: Colors.red,
  //     backgroundColor: Colors.yellow,
  //   );
  // }

  // actual store listing review & rating
  void _rateAndReviewApp() async {
    final _inAppReview = InAppReview.instance;

    if (await _inAppReview.isAvailable()) {
      print('request actual review from store');
      _inAppReview.requestReview();
    } else {
      print('open actual store listing');
      // TODO: use your own store ids
      _inAppReview.openStoreListing(
        appStoreId: '<your app store id>',
        microsoftStoreId: '<your microsoft store id>',
      );
    }
  }

  // show the rating dialog
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'rateapp'.tr(),
      // encourage your user to leave a high rating?
      message: 'support&rate'.tr(),
      // your app's logo?
      image: Image.asset('assets/images/logo.png'),
      submitButton: 'submit'.tr(),
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}
