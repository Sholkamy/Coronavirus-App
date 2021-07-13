import 'dart:convert';
import 'package:coronavirus_rest_api/services/api.dart';
import 'package:coronavirus_rest_api/services/api_element_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final http.Response response = await http.post(api.tokenUri(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      String accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    throw response;
  }

  Future<APIElementData> getElementData(
      {@required String accessToken, @required API_Element apiElement}) async {
    http.Response response = await http.get(api.apiElementUri(apiElement),
        headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      if (data != null) {
        String responseJsonKey = _responseJsonCode[apiElement];
        int value = data[0][responseJsonKey];
        String dateString = data[0]['date'];
        var date = DateTime.tryParse(dateString);
        if (value != null) return APIElementData(value: value, date: date);
      }
    }
    throw response;
  }

  static Map<API_Element, String> _responseJsonCode = {
    API_Element.cases: 'cases',
    API_Element.casesConfirmed: 'data',
    API_Element.casesSuspected: 'data',
    API_Element.deaths: 'data',
    API_Element.recovered: 'data',
  };
}
