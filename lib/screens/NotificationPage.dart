import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:your_taxi_dispatcher/data/dispatch.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:your_taxi_dispatcher/screens/DispatchInfoPage.dart';

import '../theme/colors.dart';
import '../widget/button_widget.dart';
import 'CompletedDispatchPage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.receivedAction})
      : super(key: key);

  final ReceivedAction receivedAction;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    Dispatch dispatch = Dispatch.fromPayloadJson(
        widget.receivedAction.payload!);
    return DispatchInfoPage(dispatch);
  }
}