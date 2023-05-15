import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_taxi_dispatcher/data/dispatch_list.dart';
import 'package:your_taxi_dispatcher/screens/DispatchInfoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../data/dispatch.dart';
import '../widget/custom_card.dart';

class DispatchHistoryPage extends StatefulWidget {
  const DispatchHistoryPage({Key? key}) : super(key: key);

  @override
  State<DispatchHistoryPage> createState() => _DispatchHistoryPageState();
}

class _DispatchHistoryPageState extends State<DispatchHistoryPage> {
  //List<Dispatch> _dispatch = [];

  Future<List<Dispatch>> readJsonFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dispatchDataJson = prefs.getString('DispatchData')!;

    //local test data
    //String testData = await rootBundle.loadString('assets/testData.json');
    return dispatchFromJson(dispatchDataJson);
  }

  //TODO: remove time > 24 hrs current time based on time
  //TODO: Pull a list of dispatches from shared pref

  //TODO: hook up new google sheets

  //TODO: FCM page
  //TODO: Create one time push to sheets
  //TODO: Save to shared pref and send to sheets

  //TODO: Code refactoring

  //TODO: test on device

  @override
  void initState() {
    DispatchList.dispatchList.clear();
    DispatchList.counter = 0;
    readJsonFromSharedPref().then((value) {
      setState(() {
        DispatchList.dispatchList.addAll(value);
        DispatchList.dispatchList.forEach((element) {
          if(element.paymentType == null || element.paymentType=='')
            DispatchList.counter++;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/yourtaxi.png',
          height: 75,
          width: 150,
        ),

      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DispatchInfoPage(DispatchList.dispatchList[index])),
                );
              },
              child: displayCardHistory(DispatchList.dispatchList[index]));
        },
        itemCount: DispatchList.dispatchList.length,
      ),
    );
  }
}

Widget displayCardHistory(Dispatch dispatch) {
  if (dispatch.paymentType == null || dispatch.paymentType == '') {
    return CustomDisplayCard(
      title: "Call Line ID: "+dispatch.callLine.toString(),
      subtitle: dispatch.pickUp!,
      icon: Icons.access_time_outlined,
      color: Colors.orange,
    );
  } else {
    return CustomDisplayCard(
      title: "Call Line ID: "+dispatch.callLine.toString(),
      subtitle: dispatch.pickUp!,
      icon: Icons.check,
      color: Colors.green,
    );
  }
}



