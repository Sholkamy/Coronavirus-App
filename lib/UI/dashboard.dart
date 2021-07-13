import 'dart:io';

import 'package:coronavirus_rest_api/Repository/data_repository.dart';
import 'package:coronavirus_rest_api/Repository/element_data.dart';
import 'package:coronavirus_rest_api/UI/api_element_card.dart';
import 'package:coronavirus_rest_api/UI/last_updated_status_text.dart';
import 'package:coronavirus_rest_api/UI/show_alert_dialog.dart';
import 'package:coronavirus_rest_api/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ElementData numOfElements;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future<void> updateData() async {
    try {
      DataRepository dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      ElementData _numOfElements = await dataRepository.getAllApiElementData();
      setState(() => numOfElements = _numOfElements);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Couldn\'t retrieve data. Please try again Later.',
          defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Please contact support or try again later.',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    LastUpdatedDateFormatter formater = LastUpdatedDateFormatter(
        lastUpdated: numOfElements != null
            ? numOfElements.values[API_Element.cases].date
            : null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(text: formater.lastUpdatedStatusText()),
            for (var element in API_Element.values)
              APIElementCard(
                apiElement: element,
                value: numOfElements != null
                    ? numOfElements.values[element].value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
