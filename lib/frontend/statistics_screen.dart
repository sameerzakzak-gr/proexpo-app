import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proexpo/backend/user.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';

class StatisticsScreen extends StatefulWidget {
  static String id = 'statistics_screen';

  double res1;
  StatisticsScreen(this.res1);
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  TooltipBehavior _tooltipBehavior;
  double res1;

  Timer timer3;
  Timer timer4;
  Timer timer5;
  Timer timer6;
  var random;
  var random2;
  var random3;
  var random4;
  int value3 = 45;
  int value4 = 10;
  int value5 = 760;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    widget.res1 = res1;
    timer3 = Timer.periodic(Duration(milliseconds: 500), (t) {
      setState(() {
        value3 = value3 + 8;
      });
    });
    timer4 = Timer.periodic(Duration(milliseconds: 500), (t) {
      setState(() {
        value4 = value4 + 4;
      });
    });
    timer5 = Timer.periodic(Duration(milliseconds: 1200), (t) {
      setState(() {
        value5 = value5 - 3;
        if (value5 < 0) {
          timer5.cancel();
        }
      });
    });
    timer6 = Timer.periodic(Duration(milliseconds: 1600), (t) {
      setState(() {
        random = new Random().nextInt(5);
        random2 = new Random().nextInt(5);
        random3 = new Random().nextDouble() * max(10, 26);
        random4 = new Random().nextDouble() * max(10, 43);
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
                                    '$value3',
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
                                    '$value4',
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
                                    '$value5',
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
    _PieData('Likes', 22, '👍'),
    _PieData('DisLikes', 35, '👎'),
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
