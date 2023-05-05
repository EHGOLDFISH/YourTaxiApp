import 'package:flutter/material.dart';
import 'package:your_taxi_dispatcher/api/sheets/user_sheets_api.dart';
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
                  Container(
                    width: 200,
                    child: TextField (
                      controller: indexController,
                      keyboardType:
                      TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Index Number',
                          hintText: 'Enter Your Index Number'
                      ),
                    ),
                  ),
                  Container( width: 300,
                    child: TextField (
                      controller: deviceController,
                      decoration: InputDecoration(
                          labelText: 'Device Name',
                          hintText: 'Enter Your Device Name'
                      ),
                    ),
                  ),
                ],
              ),
              ButtonWidget(text: 'submit FCM', onClicked: (){
                UserSheetsApi.addFCMToSheets(int.parse(indexController.text),widget.fcmToken,deviceController.text);
                indexController.text ='';
                deviceController.text ='';
              })
            ],
          ),
        ),
      ),
    );
  }
}
