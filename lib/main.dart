import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proexpo/backend/product.dart';
import 'package:proexpo/frontend/about_screen.dart';
import 'package:proexpo/frontend/expo_page.dart';
import 'package:proexpo/frontend/home_page.dart';
import 'package:proexpo/frontend/interested_screen.dart';
import 'package:proexpo/frontend/my_products.dart';
import 'package:proexpo/frontend/profile.dart';
import 'package:proexpo/frontend/settings.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'backend/exhibition.dart';
import 'backend/user.dart';
import 'frontend/my_services.dart';
import 'package:proexpo/frontend/welcome_screen.dart';
import 'package:proexpo/frontend/who_your.dart';
import 'frontend/exhibitors_screen.dart';
import 'frontend/favorites_screen.dart';
import 'frontend/products_screen.dart';
import 'frontend/login_screen.dart';
import 'frontend/signup_screen.dart';
import 'frontend/signup_screen2.dart';
import 'frontend/statistics_screen.dart';
import 'frontend/add_products.dart';
import 'frontend/services.dart';
import 'frontend/add_service.dart';
import 'frontend/sort_screen.dart';
import 'frontend/profile2.dart';
import 'frontend/statistics2_screen.dart';
import 'backend/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     systemNavigationBarColor:
  //         SystemUiOverlayStyle.dark.systemNavigationBarColor,
  //   ),
  // );
  await Firebase.initializeApp();
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('it', 'IT'),
      ],
      path: 'assets/languages', // <-- change the path of the translation files
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Exhibition expo;
  Map<String, String> role;
  List<Product> products = [];
  double res1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Pro Expo',
      initialRoute: ContinueAsScreen.id,
      routes: <String, WidgetBuilder>{
        MyProducts.id: (context) => MyProducts(),
        AddServiceScreen.id: (context) => AddServiceScreen(role, expo),
        ProfileScreen.id: (context) => ProfileScreen(),
        HomePage.id: (context) => HomePage(),
        ExhibitorsScreen.id: (context) => ExhibitorsScreen(role, expo),
        ProductsScreen.id: (context) => ProductsScreen(role, expo),
        ExpoPage.id: (context) => ExpoPage(expo, role),
        LoginScreen.id: (context) => LoginScreen(),
        ContinueAsScreen.id: (context) => ContinueAsScreen(),
        WhoYouAre.id: (context) => WhoYouAre(),
        SettingsScreen.id: (context) => SettingsScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignUpScreen2.id: (context) => SignUpScreen2(),
        AboutScreen.id: (context) => AboutScreen(),
        FavouritesScreen.id: (context) => FavouritesScreen(),
        InterestedScreen.id: (context) => InterestedScreen(),
        StatisticsScreen.id: (context) => StatisticsScreen(res1),
        AddProducts.id: (context) => AddProducts(role, expo),
        Services.id: (context) => Services(role, expo, res1),
        MyServicesScreen.id: (context) => MyServicesScreen(),
        SortScreen.id: (context) => SortScreen(role, products),
        Profile2.id: (context) => Profile2(),
        Statistics2Screen.id: (context) => Statistics2Screen(res1),
      },
    );
  }
}
