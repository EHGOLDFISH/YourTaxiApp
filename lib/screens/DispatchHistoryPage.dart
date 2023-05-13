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

  //TODO: create a list of dispatches -
  //TODO: display a list of dispatches -
  //TODO: De couple dispatch page from notification make dispatch page info
  //TODO: make it pretty
  //TODO: add a not completed yet
  //TODO: click on one list item
  //TODO: Pull a list of dispatches from shared pref
  //TODO: remove time > 24 hrs current time based on time
  //TODO: save prefs

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
              child: CustomDisplayCard(
                  title: _dispatch[index].callLine.toString(),
                  subtitle: _dispatch[index].pickUp!,
                  icon: Icons.check));
          //   Card(
          //   elevation: 2,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: InkWell(
          //       borderRadius: BorderRadius.circular(8),
          //       onTap: (){
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => DispatchInfoPage(_dispatch[index])),
          //         );
          //       },
          //     child: Column(
          //       children: [
          //         Text(_dispatch[index].callLine.toString()),
          //         Text(_dispatch[index].pickUp.toString())
          //       ],
          //     ),
          //   ),
          // );
        },
        itemCount: _dispatch.length,
      ),
    );
  }
}
