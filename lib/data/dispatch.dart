import 'dart:convert';

List<Dispatch> dispatchFromJson(String str) => List<Dispatch>.from(json.decode(str).map((x) => Dispatch.fromJson(x)));

String dispatchToJson(List<Dispatch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dispatch {
  String? assignedDriver;
  String? callType;
  String? carType;
  String? pickUp;
  String? dest;
  String? note;
  String? acct;
  double? fare;
  String? paymentType;
  String? submittedTime;//change to date time
  int callLine;

  Dispatch({
    this.assignedDriver,
    this.callType,
    this.carType,
    this.pickUp,
    this.dest,
    this.note,
    this.acct,
    this.fare,
    this.paymentType,
    this.submittedTime,
    required this.callLine,
  });

  factory Dispatch.fromPayloadJson(Map<String, String?> json) => Dispatch(
    assignedDriver: json["AssignedDriver"],
    callType: json["CallType"],
    carType: json["CarType"],
    pickUp: json["PickUP"],
    dest: json["Dest"],
    note: json["Note"],
    acct: json["Acct"],
    callLine: int.parse(json["CallLine"]!),
  );

  factory Dispatch.fromJson(Map<String, dynamic> json) => Dispatch(
    assignedDriver: json["AssignedDriver"],
    callType: json["CallType"],
    carType: json["CarType"],
    pickUp: json["PickUP"],
    dest: json["Dest"],
    note: json["Note"],
    acct: json["Acct"],
    fare: json["Fare"],
    paymentType: json["PaymentType"],
    submittedTime: json["SubmittedTime"],
    callLine: json["CallLine"],
  );

  Map<String, dynamic> toJson() => {
    "AssignedDriver": assignedDriver,
    "CallType": callType,
    "CarType": carType,
    "PickUP": pickUp,
    "Dest": dest,
    "Note": note,
    "Acct": acct,
    "Fare": fare,
    "PaymentType": paymentType,
    "SubmittedTime": submittedTime,
    "CallLine": callLine,
  };
}