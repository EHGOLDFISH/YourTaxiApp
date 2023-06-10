import 'package:flutter/material.dart';
import 'package:your_taxi_dispatcher/api/sheets/user_sheets_api.dart';
import 'package:your_taxi_dispatcher/data/dispatch_list.dart';
import 'package:your_taxi_dispatcher/widget/button_widget.dart';


final indexController = TextEditingController();
final deviceController = TextEditingController();

class AddFCMPage extends StatefulWidget {
  String fcmToken;
  AddFCMPage(this.fcmToken);

  @override
  State<AddFCMPage> createState() => _AddFCMPageState();
}

class _AddFCMPageState extends State<AddFCMPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adding FCM")),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container( width: 400,
                      child: TextField (
                        controller: deviceController,
                        decoration: InputDecoration(
                            labelText: 'Device Name',
                            hintText: 'Enter Your Device Name'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ButtonWidget(text: 'submit FCM', onClicked: ()async{
                DispatchList.prefs.setBool("FCM", true);

                UserSheetsApi.addFCMToSheets(widget.fcmToken,deviceController.text);
                indexController.text ='';
                deviceController.text ='';
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/", (r) => false);
              })
            ],
          ),
        ),
      ),
    );
  }
}
