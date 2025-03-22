import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:proexpo/backend/exhibition.dart';
import 'exhibitors_screen.dart';
import 'package:flutter/material.dart';
import 'package:proexpo/frontend/home_page.dart';
import 'package:proexpo/frontend/text_style.dart';
import 'package:proexpo/frontend/ui_helper.dart';
import 'products_screen.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpoPage extends StatefulWidget {
  static String id = 'expo_page';

  final Exhibition expo;
  final Map<String, String> role;
  ExpoPage(this.expo, this.role);
  @override
  _ExpoPageState createState() => _ExpoPageState();
}

class _ExpoPageState extends State<ExpoPage> with TickerProviderStateMixin {
  Exhibition expo;
  double res2;
  Map<String, String> role1;
  AnimationController controller;
  AnimationController bodyScrollAnimationController;
  ScrollController scrollController;
  Animation<double> scale;
  Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;
  @override
  void initState() {
    expo = widget.expo;
    role1 = widget.role;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    bodyScrollAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= headerImageSize / 2) {
          if (!bodyScrollAnimationController.isCompleted)
            bodyScrollAnimationController.forward();
        } else {
          if (bodyScrollAnimationController.isCompleted)
            bodyScrollAnimationController.reverse();
        }
      });

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
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
    headerImageSize = MediaQuery.of(context).size.height / 2.5;
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeaderImage(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildExpoTitle(),
                          UIHelper.verticalSpace(16),
                          buildEventDate(),
                          UIHelper.verticalSpace(24),
                          buildAboutEvent(),
                          UIHelper.verticalSpace(24),
                          buildOrganizeInfo(),
                          UIHelper.verticalSpace(24),
                          buildEventLocation(),
                          UIHelper.verticalSpace(124),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                child: buildPriceInfo(),
                alignment: Alignment.bottomCenter,
              ),
              AnimatedBuilder(
                animation: appBarSlide,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, -1000 * (1 - appBarSlide.value)),
                    child: Material(
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      child: buildHeaderButton(hasTitle: true),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderImage() {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.pushNamed(context, HomePage.id, arguments: role1);
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: expo.exhibitionImage,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Image.asset(
                  expo.exhibitionImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildHeaderButton(),
        ],
      ),
    );
  }

  Widget buildHeaderButton({bool hasTitle = false}) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              child: InkWell(
                onTap: () {
                  if (bodyScrollAnimationController.isCompleted)
                    bodyScrollAnimationController.reverse();
                  Navigator.pushNamed(context, HomePage.id, arguments: role1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              color: hasTitle ? Colors.white : Colors.transparent,
            ),
            if (hasTitle)
              Text(expo.exhibitionName,
                  style: titleStyle.copyWith(color: Colors.black)),
            Card(
              shape: CircleBorder(),
              elevation: 0,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red.withOpacity(0.9)),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpoTitle() {
    return Container(
      child: Text(
        expo.exhibitionName,
        style: headerStyle.copyWith(fontSize: 32),
      ),
    );
  }

  Widget buildEventDate() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 234, 248, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(expo.exhibitionMonth, style: monthStyle),
                Text(expo.exhibitionDay.toString(), style: titleStyle),
              ],
            ),
          ),
          UIHelper.horizontalSpace(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  expo.exhibitionDay.toString() +
                      '/' +
                      expo.exhibitionMonth +
                      '/' +
                      expo.exhibitionYear.toString(),
                  style: titleStyle),
              UIHelper.verticalSpace(4),
              Text(
                  expo.exhibitionStartTime +
                      "-" +
                      expo.exhibitionEndTime +
                      "PM",
                  style: subtitleStyle),
            ],
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: Color.fromRGBO(240, 234, 248, 1)),
            child: Row(
              children: <Widget>[
                UIHelper.horizontalSpace(3),
                Text('interested'.tr(),
                    style: subtitleStyle.copyWith(color: Colors.blue)),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAboutEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('about'.tr(), style: headerStyle),
        UIHelper.verticalSpace(),
        Text(expo.exhibitionDescription, style: subtitleStyle),
        UIHelper.verticalSpace(8),
        InkWell(
          child: Text(
            'more'.tr(),
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget buildOrganizeInfo() {
    // final Map<String, String>  = ModalRoute.of(context).settings.arguments;

    return Column(
      children: [
        Row(
          children: <Widget>[
            /*CircleAvatar(
              child: Text(expo.organizer[0]),
            ),*/
            UIHelper.horizontalSpace(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(expo.exhibitionOrganizerName, style: titleStyle),
                UIHelper.verticalSpace(4),
                Text('organizer'.tr(), style: subtitleStyle),
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 234, 248, 1),
                  borderRadius: BorderRadius.circular(20.0)),
              width: 80,
              height: 35.0,
              child: TextButton(
                child:
                    Text('follow'.tr(), style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  print(role1);
                },
                // shape: StadiumBorder(),
                // color: primaryLight,
              ),
            ),
          ],
        ),
        role1.toString() == "{name: I'm an Exhibitor, value: 12}"
            ? Container(
                margin: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 234, 248, 1),
                    borderRadius: BorderRadius.circular(20.0)),
                width: 150,
                height: 40.0,
                child: TextButton(
                  onPressed: () {
                    _showDialog();
                  },
                  child: Text('contribute'.tr()),
                ))
            : SizedBox(),
      ],
    );
  }

  Widget buildEventLocation() {
    return TextButton(
      onPressed: () {
        // Navigator.pushNamed(context, SVG.id, arguments: role1);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/map-s.jpg',
          height: MediaQuery.of(context).size.height / 3,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildPriceInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/exhibit.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.6), BlendMode.darken),
                ),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ExhibitorsScreen.id,
                      arguments: role1);
                },
                child: Text(
                  'exhibitors'.tr(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/product.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.6), BlendMode.darken),
                ),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsScreen(role1, expo),
                    ),
                  );
                },
                child: Text(
                  'products'.tr(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.6), BlendMode.darken),
                ),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  openMapsSheet(context);
                },
                child: Text(
                  'location'.tr(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 60,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/service.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.6), BlendMode.darken),
                ),
                borderRadius: new BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Services(role1, expo, res2),
                    ),
                  );
                },
                child: Text(
                  'services'.tr(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openMapsSheet(context) async {
    try {
      final coords = Coords(33.429975, 36.390779);
      final title = "Damascus Fairgrounds";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
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
                    'tocontribue'.tr(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(
                    flex: 2,
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
