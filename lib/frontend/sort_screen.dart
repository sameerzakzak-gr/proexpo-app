import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:proexpo/backend/product.dart';
import 'package:easy_localization/easy_localization.dart';

class SortScreen extends StatefulWidget {
  static String id = 'sort_screen';
  List<Product> products = [];

  final Map<String, String> role;
  SortScreen(this.role, this.products);
  @override
  _SortScreenState createState() => _SortScreenState();
}

int selectedIndex = 0;

class _SortScreenState extends State<SortScreen> {
  @override
  void initState() {
    super.initState();
    widget.products.sort((a, b) {
      return a.productName
          .toString()
          .toLowerCase()
          .compareTo(b.productName.toString().toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sort'.tr()),
      ),
      body: Column(
        children: [
          Expanded(
            child: AlphabetScrollView(
              list: widget.products
                  .map((e) => AlphaModel(e.productName))
                  .toList(),
              // isAlphabetsFiltered: false,
              alignment: LetterAlignment.right,
              itemExtent: 250,
              unselectedTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
              selectedTextStyle: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
              overlayWidget: (value) => Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 50,
                    color: Colors.red,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$value'.toUpperCase(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              itemBuilder: (_, index, id) {
                return LimitedBox(
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
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
                                Text('price'),
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
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
