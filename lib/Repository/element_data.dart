import 'package:coronavirus_rest_api/services/api.dart';
import 'package:coronavirus_rest_api/services/api_element_data.dart';
import 'package:flutter/foundation.dart';

class ElementData {
  ElementData({@required this.values});
  Map<API_Element, APIElementData> values;
  APIElementData get cases => values[API_Element.cases];
  APIElementData get casesConfirmed => values[API_Element.casesConfirmed];
  APIElementData get casesSuspected => values[API_Element.casesSuspected];
  APIElementData get deaths => values[API_Element.deaths];
  APIElementData get recovered => values[API_Element.recovered];

  @override
  String toString() =>
      'cases: $cases ,confirmed: $casesConfirmed ,suspected: $casesSuspected ,deaths: $deaths ,recovered: $recovered';
}
