import 'dispatch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DispatchList {
  DispatchList._privateConstructor();
  static final DispatchList _instance = DispatchList._privateConstructor();

  factory DispatchList() {
    return _instance;
  }

  static List<Dispatch> dispatchList = [];
  static int counter = 0;

  //get incomplete dispatch count
  static int getIncompleteDispatchCount(){
    return 0;
  }


}