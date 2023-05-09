import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app_demo/screens/cartScreen.dart';
import 'package:monkey_app_demo/screens/changeAddressScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rive/rive.dart';
import './screens/spashScreen.dart';
import './screens/landingScreen.dart';
import './screens/loginScreen.dart';
import './screens/signUpScreen.dart';
import './screens/forgetPwScreen.dart';
import './screens/sentOTPScreen.dart';
import './screens/newPwScreen.dart';
import './screens/introScreen.dart';
import './screens/homeScreen.dart';
import './screens/menuScreen.dart';
import './screens/moreScreen.dart';
import './screens/offerScreen.dart';
import './screens/profileScreen.dart';
import './screens/dessertScreen.dart';
import './screens/individualItem.dart';
import './screens/paymentScreen.dart';
import './screens/notificationScreen.dart';
import './screens/aboutScreen.dart';
import './screens/inboxScreen.dart';
import './screens/myOrderScreen.dart';
import './screens/checkoutScreen.dart';
import './const/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: RiveAnimation.asset(
                    'assets/4954-10032-fire-skull.riv',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: "Metropolis",
              primarySwatch: Colors.red,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColor.orange,
                  ),
                  shape: MaterialStateProperty.all(
                    StadiumBorder(),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    AppColor.orange,
                  ),
                ),
              ),
              textTheme: TextTheme(
                displaySmall: TextStyle(
                  color: AppColor.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                headlineMedium: TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                headlineSmall: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
                titleLarge: TextStyle(
                  color: AppColor.primary,
                  fontSize: 25,
                ),
                bodyMedium: TextStyle(
                  color: AppColor.secondary,
                ),
              ),
            ),
            home: SplashScreen(),
            routes: {
              CartScreen.routeName:(context) => CartScreen(),
              LandingScreen.routeName: (context) => LandingScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              ForgetPwScreen.routeName: (context) => ForgetPwScreen(),
              SendOTPScreen.routeName: (context) => SendOTPScreen(),
              NewPwScreen.routeName: (context) => NewPwScreen(),
              IntroScreen.routeName: (context) => IntroScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              MenuScreen.routeName: (context) => MenuScreen(),
              OfferScreen.routeName: (context) => OfferScreen(),
              ProfileScreen.routeName: (context) => ProfileScreen(),
              MoreScreen.routeName: (context) => MoreScreen(),
              DessertScreen.routeName: (context) => DessertScreen(),
              IndividualItem.routeName: (context) => IndividualItem(),
              PaymentScreen.routeName: (context) => PaymentScreen(),
              NotificationScreen.routeName: (context) => NotificationScreen(),
              AboutScreen.routeName: (context) => AboutScreen(),
              InboxScreen.routeName: (context) => InboxScreen(),
              MyOrderScreen.routeName: (context) => MyOrderScreen(),
              CheckoutScreen.routeName: (context) => CheckoutScreen(),
              ChangeAddressScreen.routeName: (context) => ChangeAddressScreen(),
            },
          );
        }
        return Text('loading');
      },
    );
  }
}
