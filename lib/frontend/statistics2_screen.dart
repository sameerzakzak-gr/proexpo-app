import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proexpo/backend/user.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';

class Statistics2Screen extends StatefulWidget {
  static String id = 'statistics2_screen';
  double res1;

  Statistics2Screen(this.res1);
  @override
  _Statistics2ScreenState createState() => _Statistics2ScreenState();
}

class _Statistics2ScreenState extends State<Statistics2Screen> {
  TooltipBehavior _tooltipBehavior;
  Timer timer;

  Timer timer1;
  Timer timer2;
  Timer timer7;
  Timer timer8;
  int value = 45;
  int value1 = 10;
  int value2 = 260;
  var random;
  var random2;
  var random3;
  var random4;

  num va;
  num val;
  num valu;
  num v;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1400), (t) {
      setState(() {
        value = value + 9;
      });
    });
    timer1 = Timer.periodic(Duration(milliseconds: 1100), (t) {
      setState(() {
        value1 = value1 + 4;
      });
    });
    timer2 = Timer.periodic(Duration(milliseconds: 1800), (t) {
      setState(() {
        value2 = value2 - 2;
        if (value2 < 0) {
          timer2.cancel();
        }
      });
    });
    timer7 = Timer.periodic(Duration(milliseconds: 1600), (t) {
      setState(() {
        random = new Random().nextInt(5);
        random2 = new Random().nextInt(5);
        random3 = new Random().nextDouble() * max(10, 40);
        random4 = new Random().nextDouble() * max(16, 43);
      });
    });
    timer8 = Timer.periodic(Duration(milliseconds: 1200), (t) {
      setState(() {
        va = random4;
        val = random4;
        valu = random4;
        v = random4;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.all(30),
                    child: Text(
                      'numbers'.tr(),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.users),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '$value',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'totalvisitors'.tr(),
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.peopleCarry),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '$value1',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'totalorders'.tr(),
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.starHalfAlt),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '$random' + '.' + '$random2',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'totalrate'.tr(),
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.boxes),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '$value2',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'totalproducts'.tr(),
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(30),
                    child: Text(
                      'charts'.tr(),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                SfCircularChart(
                    title: ChartTitle(
                        text: 'Community Statistics in Year 2020-2021 Expos'),
                    legend: Legend(isVisible: true),
                    series: <PieSeries<_PieData, String>>[
                      PieSeries<_PieData, String>(
                          explode: true,
                          explodeIndex: 0,
                          dataSource: pieData,
                          xValueMapper: (_PieData data, _) => data.xData,
                          yValueMapper: (_PieData data, _) => data.yData,
                          dataLabelMapper: (_PieData data, _) => data.text,
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                    ]),
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Sales Due Contributed Expos'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: _tooltipBehavior,
                    series: <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          dataSource: <SalesData>[
                            SalesData('Jan', random3),
                            SalesData('Feb', random4),
                            SalesData('Mar', random3),
                            SalesData('Apr', random4),
                            SalesData('Jun', random4),
                            SalesData('Jul', random4),
                            SalesData('Aug', random3),
                            SalesData('Sep', random4),
                            SalesData('Oct', random3),
                            SalesData('Nov', random4),
                            SalesData('Dec', random4),
                          ],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_PieData> pieData = [
    _PieData('Likes', 35, '👍'),
    _PieData('DisLikes', 22, '👎'),
    _PieData('Loves', 28, '💖'),
    _PieData('Participates', 15, '📋'),
  ];
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String text;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
