import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proexpo/frontend/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dropdown_menu.dart';

class WhoYouAre extends StatefulWidget {
  static String id = 'who_your';

  @override
  _WhoYouAreState createState() => _WhoYouAreState();
}

List<Map<String, dynamic>> roles = [
  {"value": "12", 'name': "I'm a Visitor"},
  {"value": "12", 'name': "I'm an Exhibitor"},
  {"value": "12", 'name': "I'm a Service Provider"},
];

class _WhoYouAreState extends State<WhoYouAre> {
  bool error = false;
  Map<String, String> _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/back1.png'), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/back1.png'),
                    fit: BoxFit.cover),
              ),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    ///What Is Your Role
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'whatrole'.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              child: CustomDropDown(
                                titleSize: 15,
                                errorMessageSize: 15,
                                withoutHeader: false,
                                bgColor: Colors.white,
                                borderColor: Colors.white,
                                direction: Direction.LTR,
                                dividerColor: Colors.black,
                                error: error,
                                errorMessage: "required",
                                headerColor: Colors.white,
                                headerIcon: Icons.account_circle_rounded,
                                hintText: "I'm a...",
                                iconColor: Colors.black,
                                textColor: Colors.black,
                                title: 'role'.tr(),
                                withBorder: true,
                                items: roles,
                                onSelected:
                                    (Map<String, dynamic> selectedItem) {
                                  print(selectedItem);
                                  setState(() {
                                    _selectedItem = selectedItem;
                                    if (_selectedItem == roles[0]) {
                                      print('im user');
                                    } else if (_selectedItem == roles[1]) {
                                      print('im exhibitor');
                                    } else if (_selectedItem == roles[2]) {
                                      print('im service provider');
                                    }
                                  });
                                },
                                borderRadius: 30,
                                itemsTextSize: 20,
                                iconSize: 20,
                                headerIconColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    ///Done
                    Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedItem.isNotEmpty) {
                              Navigator.pushReplacementNamed(
                                context,
                                LoginScreen.id,
                                arguments: _selectedItem,
                              );
                            } else {
                              print('ssss');
                            }
                          });
                        },
                        child: Center(
                            child: Text(
                          'done'.tr(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
