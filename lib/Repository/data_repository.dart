import 'package:coronavirus_rest_api/Repository/element_data.dart';
import 'package:coronavirus_rest_api/services/api.dart';
import 'package:coronavirus_rest_api/services/api_element_data.dart';
import 'package:coronavirus_rest_api/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  APIService apiService;

  String accessToken;

  Future<APIElementData> getElementData(
          {@required API_Element apiElement}) async =>
      await getDataRefreshingToken<APIElementData>(
          onGetData: () => apiService.getElementData(
              accessToken: accessToken, apiElement: apiElement));

  Future<ElementData> getAllApiElementData() async =>
      await getDataRefreshingToken<ElementData>(
          onGetData: _getAllApiElementData);

  Future<T> getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (accessToken == null) {
        accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<ElementData> _getAllApiElementData() async {
    //to get API element data in parallel without waiting for them one after the other
    List<APIElementData> values = await Future.wait([
      apiService.getElementData(
          accessToken: accessToken, apiElement: API_Element.cases),
      apiService.getElementData(
          accessToken: accessToken, apiElement: API_Element.casesConfirmed),
      apiService.getElementData(
          accessToken: accessToken, apiElement: API_Element.casesSuspected),
      apiService.getElementData(
          accessToken: accessToken, apiElement: API_Element.deaths),
      apiService.getElementData(
          accessToken: accessToken, apiElement: API_Element.recovered),
    ]);
    return ElementData(
      values: {
        API_Element.cases: values[0],
        API_Element.casesConfirmed: values[1],
        API_Element.casesSuspected: values[2],
        API_Element.deaths: values[3],
        API_Element.recovered: values[4],
      },
    );
  }
}
