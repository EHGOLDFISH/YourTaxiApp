import 'package:flutter/material.dart';
import 'package:your_taxi_dispatcher/data/dispatch.dart';

import '../widget/button_widget.dart';
import '../widget/custom_card.dart';
import 'CompletedDispatchPage.dart';

class DispatchInfoPage extends StatelessWidget {
  Dispatch dispatch;

  DispatchInfoPage(this.dispatch);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if(stringNullCheck(dispatch.pickUp))
              CustomDisplayCard(
                  title: 'Pick Up',
                  subtitle: dispatch.pickUp!,
                  icon: Icons.arrow_upward_rounded),
            //newDispatchSection('Pick Up',dispatch.pickUp,Icons.arrow_upward_rounded,size),
            if (stringNullCheck(dispatch.dest))
              CustomDisplayCard(
                title:'Drop Off',
                subtitle: dispatch.dest!,
                icon: Icons.arrow_downward_rounded),
            if (stringNullCheck(dispatch.note))
              CustomDisplayCard(
                  title:'Notes',
                  subtitle: dispatch.note!,
                  icon: Icons.notes),
            if (stringNullCheck(dispatch.carType))
              CustomDisplayCard(
                  title:'Vehicle Type',
                  subtitle: dispatch.carType!,
                  icon: Icons.drive_eta),
            if (stringNullCheck(dispatch.acct))
              CustomDisplayCard(
                  title:'Account Number',
                  subtitle: dispatch.acct!,
                  icon: Icons.account_box),
            if (stringNullCheck(dispatch.callType))
              CustomDisplayCard(
                  title:'Call Type',
                  subtitle: dispatch.callType!,
                  icon: Icons.call),
            if (stringNullCheck(dispatch.paymentType))
              CustomDisplayCard(
                  title:'Payment Type',
                  subtitle: dispatch.paymentType!,
                  icon: Icons.payment),
            if (stringNullCheck(dispatch.fare.toString()))
              CustomDisplayCard(
                  title:'Payment Amount',
                  subtitle: dispatch.fare!.toString(),
                  icon: Icons.payments_outlined),
            if(!stringNullCheck(dispatch.fare.toString()))
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
              child: ButtonWidget(
                text: 'Completed',
                onClicked: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CompletedDispatchPage(dispatch.callLine)),
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

bool stringNullCheck(String? value)=>(value != null && value != "");
