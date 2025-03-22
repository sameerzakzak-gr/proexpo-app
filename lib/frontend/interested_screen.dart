import 'package:flutter/material.dart';
import 'package:proexpo/frontend/expo_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'datetime_utils.dart';
import 'expo_page.dart';

class InterestedScreen extends StatefulWidget {
  static String id = 'interested_screen';

  @override
  _InterestedScreenState createState() => _InterestedScreenState();
}

class _InterestedScreenState extends State<InterestedScreen> {
  List<Expo> dataList = upcomingEvents;
  @override
  void initState() {
    super.initState();
    dataList = upcomingEvents;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> roles = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('interested'.tr()),
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0))),
              ),
              Container(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: dataList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LimitedBox(
                      maxHeight: 260,
                      child: Column(
                        children: [
                          Container(
                            height: 150.0,
                            margin: EdgeInsets.only(
                                left: 10.0, top: 10.0, right: 10.0),
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
                                  offset: Offset(0.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/sss.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.white.withOpacity(0.8),
                                        BlendMode.darken),
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                width: 56,
                                height: 65,
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 5, bottom: 4),
                                      child: Text(
                                        "${DateTimeUtils.getMonth(dataList[index].expoDate)}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      child: Text(
                                        "${DateTimeUtils.getDayOfMonth(dataList[index].expoDate)}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0, bottom: 0),
                                    child: TextButton(
                                      /*onPressed: () {
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
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          dataList[index].location,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.amber,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
