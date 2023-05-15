import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:your_taxi_dispatcher/main.dart';

import 'api/sheets/user_sheets_api.dart';
import 'data/dispatch.dart';
import 'data/dispatch_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationController {

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {

  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {

   //var data = receivedNotification;

  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {


  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    DispatchList.counter++;

    Dispatch dispatch = Dispatch.fromPayloadJson(receivedAction.payload!);
    DispatchList.dispatchList.add(dispatch);
    String dispatchListJson = json.encode(DispatchList.dispatchList);

    await prefs.setString('DispatchData', dispatchListJson);

    // remove
    //await prefs.remove('DispatchData');
    UserSheetsApi.updateTenFourDispatch(dispatch.callLine);
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
            (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }
}