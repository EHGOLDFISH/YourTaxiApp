import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:your_taxi_dispatcher/data/dispatch.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
    Dispatch dispatch = Dispatch.fromJson(widget.receivedAction.payload);
    //temp fix for back  under title:       automaticallyImplyLeading: false,
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/yourtaxi.png',height: 75,width: 150,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if(dispatch.pickUp!=null && dispatch.pickUp!="")
            newDispatchSection('Pick Up',dispatch.pickUp,Icons.arrow_upward_rounded,size),
            if(dispatch.dest!=null&&dispatch.dest!="")
            newDispatchSection('Drop Off',dispatch.dest,Icons.arrow_downward_rounded,size),
            if(dispatch.notes!=null&&dispatch.notes!="")
              newDispatchSection('Notes',dispatch.notes,Icons.notes,size),
            if(dispatch.carType!=null&&dispatch.carType!="")
              newDispatchSection('Vehicle Type',dispatch.carType,Icons.drive_eta,size),
            if(dispatch.accountNum!=null&&dispatch.accountNum!="")
              newDispatchSection('Account Number',dispatch.accountNum,Icons.account_box,size),
            if(dispatch.callType!=null&&dispatch.callType!="")
              newDispatchSection('Call Type',dispatch.callType,Icons.call,size),

            Padding(
              padding: const EdgeInsets.fromLTRB(24.0,8.0,24.0,8.0),
              child: ButtonWidget(
                text: 'Completed',
                onClicked: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CompletedDispatchPage(dispatch.callLine)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InkWell _buildButtonColumn(
    Color color, IconData icon, String label, String address) {
  return InkWell(
    onTap: () {
      MapsLauncher.launchQuery('${address}, St Thomas, ON Canada');
    },
    child: Ink(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget newDispatchSection(String type,String? address,IconData icon , Size size) {
  return Column(children: [
    Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 25,
              right: 25,
            ),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.03),
                    spreadRadius: 10,
                    blurRadius: 3,
                    // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: arrowbgColor,
                      borderRadius: BorderRadius.circular(15),
                      // shape: BoxShape.circle
                    ),
                    child: Center(child: Icon(icon)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      width: (size.width - 90) * 0.7,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              type,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if(type!='Drop Off' && type != 'Pick Up')
                              Text(
                              address!,
                              style:
                              TextStyle(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.w400),
                            )
                            else
                              Text(
                                address!,
                                style:
                                TextStyle(
                                    fontSize: 18,
                                    color: black,

                                    fontWeight: FontWeight.bold),
                              )
                            ,
                          ]),
                    ),
                  ),
                  if(type=='Drop Off' || type == 'Pick Up')
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildButtonColumn(Colors.black, Icons.near_me, 'ROUTE', address)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget dispatchSection(String locationType, String address) {
  return Container(
    padding: const EdgeInsets.all(32),
    color: Colors.white60,
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Text(
                locationType,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                address,
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
        _buildButtonColumn(Colors.black, Icons.near_me, 'ROUTE', address)
      ],
    ),
  );
}
