import 'dart:convert';

class Dispatch {
  late final String? assignedDriver;
  late final String? callType;
  late final String? carType;
  late final String? pickUp;
  late final String? dest;
  late final String? notes;
  late final String? accountNum;
  late final int? callLine;

  Dispatch(this.assignedDriver, this.callType, this.carType, this.pickUp,
      this.dest, this.notes, this.accountNum, this.callLine);

  Dispatch.fromJson(Map<String, String?>? json)
      : assignedDriver = json!['AssignedDriver'],
        callType = json!['CallType'],
        carType = json!['CarType'],
        pickUp = json!['PickUP'],
        dest = json!['Dest'],
        notes = json!['Note'],
        accountNum = json!['Acct'],
        callLine = int.parse(json!['CallLine']!);

  //wont be used
  Map<String, dynamic> toJson() => {
        'AssignedDriver': assignedDriver,
        'CallType': callType,
        'CarType': carType,
        'PickUP': pickUp,
        'Dest': dest,
        'Note': notes,
        'Acct': accountNum,
        'CallLine' : callLine.toString()
      };
}
