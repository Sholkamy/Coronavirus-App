import 'package:coronavirus_rest_api/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum API_Element { cases, casesSuspected, casesConfirmed, deaths, recovered }

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandbox);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(scheme: 'https', host: host, path: 'token');

  Uri apiElementUri(API_Element apiElement) =>
      Uri(scheme: 'https', host: host, path: _paths[apiElement]);

  static Map<API_Element, String> _paths = {
    API_Element.cases: 'cases',
    API_Element.casesConfirmed: 'casesConfirmed',
    API_Element.casesSuspected: 'casesSuspected',
    API_Element.deaths: 'deaths',
    API_Element.recovered: 'recovered',
  };
}
