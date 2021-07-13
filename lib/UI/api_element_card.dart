import 'package:coronavirus_rest_api/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class APIElementCardData {
  APIElementCardData({this.title, this.assetName, this.color});
  String title;
  String assetName;
  Color color;
}

// ignore: must_be_immutable
class APIElementCard extends StatelessWidget {
  APIElementCard({this.apiElement, this.value});
  API_Element apiElement;
  int value;

  Map<API_Element, APIElementCardData> cardsData = {
    API_Element.cases: APIElementCardData(
        title: 'Cases',
        assetName: 'assets/count.png',
        color: Color(0xFFFFF492)),
    API_Element.casesSuspected: APIElementCardData(
        title: 'Suspected cases',
        assetName: 'assets/suspect.png',
        color: Color(0xFFEEDA28)),
    API_Element.casesConfirmed: APIElementCardData(
        title: 'Confirmed cases',
        assetName: 'assets/fever.png',
        color: Color(0xFFE99600)),
    API_Element.deaths: APIElementCardData(
        title: 'Deaths',
        assetName: 'assets/death.png',
        color: Color(0xFFE40000)),
    API_Element.recovered: APIElementCardData(
        title: 'Recovered',
        assetName: 'assets/patient.png',
        color: Color(0xFF70A901)),
  };

  String formattedValue(int _value) {
    if (_value == null)
      return '';
    else
      return NumberFormat('###,###,###,###').format(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardsData[apiElement].title,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: cardsData[apiElement].color),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardsData[apiElement].assetName,
                      color: cardsData[apiElement].color,
                    ),
                    Text(
                      formattedValue(value),
                      style: Theme.of(context).textTheme.display1.copyWith(
                          color: cardsData[apiElement].color,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
