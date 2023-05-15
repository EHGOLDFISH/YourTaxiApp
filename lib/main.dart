import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:your_taxi_dispatcher/AddFCMPage.dart';
import 'package:your_taxi_dispatcher/NotificationController.dart';
import 'package:your_taxi_dispatcher/api/sheets/user_sheets_api.dart';
import 'package:your_taxi_dispatcher/screens/CompletedDispatchPage.dart';
import 'package:your_taxi_dispatcher/screens/DispatchHistoryPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_taxi_dispatcher/screens/DispatchInfoPage.dart';
import 'package:your_taxi_dispatcher/screens/NotificationPage.dart';
import 'package:your_taxi_dispatcher/theme/colors.dart';
import 'package:badges/badges.dart' as badges;

import 'data/dispatch_list.dart';
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Fire store,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
//
// }

//gmail account
//yourtaxicar24@gmail.com

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String fcmToken = '';

late bool _showDispatchBadge;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  fcmToken = await getFirebaseMessagingToken();

  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // //test if empty
  // String dispatchDataJson = prefs.getString('DispatchData')!;
  //
  // return dispatchFromJson(testData);
  await UserSheetsApi.init();
  await Firebase.initializeApp();
  await DispatchList.initSharedPref();

  AwesomeNotifications().initialize('resource://drawable/ic_taxi_logo', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: "basic Notification",
      channelDescription: 'Notification channel for basic test',
    )
  ]);

   runApp(const MyApp());
}

ReceivedAction? initialAction;

// Request FCM token to Firebase
Future<String> getFirebaseMessagingToken() async {
  String firebaseAppToken = '';
  if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
    try {
      firebaseAppToken =
          await AwesomeNotificationsFcm().requestFirebaseAppToken();
    } catch (exception) {
      debugPrint('$exception');
    }
  } else {
    debugPrint('Firebase is not available on this project');
  }
  return firebaseAppToken;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'Your Taxi',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Your Taxi'));

          case '/notification-page':
            return MaterialPageRoute(builder: (context) {
              final ReceivedAction receivedAction =
                  settings.arguments as ReceivedAction;
              return NotificationPage(receivedAction: receivedAction);
            });

          default:
            assert(false, 'Page ${settings.name} not found');
            return null;
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
          if (!isAllowed)
            AwesomeNotifications().requestPermissionToSendNotifications()
        });

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _showDispatchBadge = DispatchList.counter > 0;

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset('assets/yourtaxi.png',height: 75,width: 150,),
        ),
        actions: <Widget>[
          _dispatchInfoBadge(context),
        ],
      ),
      body:
      //  AddFCMPage(fcmToken)
      Center(
        child: SafeArea(
          child: Center(
            child: Container(
              width: 500.0,
              height: 200.0,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Waiting for dispatch"),
              ),
            ),
          ),
        ),
      ),
        //CompletedDispatchPage(19)
    );
  }
}

Widget _dispatchInfoBadge(BuildContext context) {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 0, end: 3),
    badgeAnimation: badges.BadgeAnimation.slide(
      // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
      // curve: Curves.easeInCubic,
    ),
    showBadge: _showDispatchBadge,
    badgeStyle: badges.BadgeStyle(
      badgeColor: Colors.red,
    ),
    badgeContent: Text(
      DispatchList.getIncompleteDispatchCount().toString(),
      style: TextStyle(color: Colors.white),
    ),
    child: IconButton(icon: Icon(Icons.history_outlined), onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DispatchHistoryPage()),
      );
    }),
  );
}
