import 'dart:convert';

import '../api/sheets/user_sheets_api.dart';
import 'dispatch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DispatchList {
  DispatchList._privateConstructor();
  static final DispatchList _instance = DispatchList._privateConstructor();
  static late SharedPreferences prefs;

  factory DispatchList() {
    return _instance;
  }

  static List<Dispatch> dispatchList = [];
  static int counter = 0;


  //Get Dispatch List()
  static Future<List<Dispatch>> readJsonFromSharedPref() async{
    String dispatchDataJson = prefs.getString('DispatchData')!;

    DispatchList.dispatchList.forEach((element)  {
      if(element.paymentType == null || element.paymentType=='') {
        DispatchList.counter++;
      }

      if(element.submittedTime != null && element.submittedTime!='') {

        DateTime parsedDate = DateTime.parse(element.submittedTime!);
        DateTime timeNow = DateTime.now();
        //check if submitted time > 24hrs
        if(timeNow.isAfter(parsedDate.add(const Duration(hours: 24)))){
          DispatchList.removeDispatch(element);
        }
      }
    });
    return dispatchFromJson(dispatchDataJson);
  }

  //Update Dispatch
  static Future<void> updateDispatch(Dispatch dispatch) async{
    DispatchList.dispatchList[DispatchList.dispatchList.indexWhere((element) => element.callLine == dispatch.callLine)] = dispatch;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dispatchListJson = json.encode(DispatchList.dispatchList);
    await prefs.setString('DispatchData', dispatchListJson);
    UserSheetsApi.updateDispatch( dispatch.callLine,dispatch.paymentType!, dispatch.fare.toString());
  }

  //Remove Dispatch
  static Future<void> removeDispatch(Dispatch dispatch) async{
      //remove element
      DispatchList.dispatchList.removeWhere((dispatch) => dispatch.callLine == dispatch.callLine);
      //remove from pref
      String dispatchListJson = json.encode(DispatchList.dispatchList);
      await prefs.setString('DispatchData', dispatchListJson);
  }

  //load sharedprefs once
  static Future<void> initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
    dispatchList = await readJsonFromSharedPref();
  }

  //get incomplete dispatch count
  static int getIncompleteDispatchCount(){
    DispatchList.counter = 0;
    DispatchList.dispatchList.forEach((element) {
      if (element.paymentType == null || element.paymentType == '') {
        DispatchList.counter++;
      }
    });
    return counter;
  }

  static Future<void> setIncompleteDispatchCount() async{

  }


}