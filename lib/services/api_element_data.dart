import 'package:flutter/foundation.dart';

class APIElementData {
  APIElementData({@required this.value, this.date}) : assert(value != null);
  int value;
  DateTime date;
}
