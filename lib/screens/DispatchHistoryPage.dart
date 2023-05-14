import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_taxi_dispatcher/screens/DispatchInfoPage.dart';

import '../data/dispatch.dart';
import '../widget/custom_card.dart';

class DispatchHistoryPage extends StatefulWidget {
  const DispatchHistoryPage({Key? key}) : super(key: key);

  @override
  State<DispatchHistoryPage> createState() => _DispatchHistoryPageState();
}

class _DispatchHistoryPageState extends State<DispatchHistoryPage> {
  List<Dispatch> _dispatch = [];

  Future<List<Dispatch>> readJson() async {
    String testData = await rootBundle.loadString('assets/testData.json');
    return dispatchFromJson(testData);
  }

  //TODO: add a not completed yet logic if payment == null
  //TODO: remove complete and display amount
  //TODO: add button logic to go to history
  //TODO: add icon with badge

  //TODO: save prefs
  //TODO: add to shared pref
  //TODO: add clear shared pref
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
    readJson().then((value) {
      setState(() {
        _dispatch.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                      builder: (context) => DispatchInfoPage(_dispatch[index])),
                );
              },
              child: displayCardHistory(_dispatch[index]));
        },
        itemCount: _dispatch.length,
      ),
    );
  }
}

Widget displayCardHistory(Dispatch dispatch) {
  if (dispatch.paymentType == null || dispatch.paymentType == '') {
    return CustomDisplayCard(
      title: dispatch.callLine.toString(),
      subtitle: dispatch.pickUp!,
      icon: Icons.add_circle,
      color: Colors.orange,
    );
  } else {
    return CustomDisplayCard(
      title: dispatch.callLine.toString(),
      subtitle: dispatch.pickUp!,
      icon: Icons.check,
      color: Colors.green,
    );
  }
}
