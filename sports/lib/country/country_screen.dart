import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sports/league/league_screen.dart';
import 'package:sports/utils/api.dart';

class CountryPage extends StatefulWidget {
  CountryPage({Key key, this.country}) : super(key: key);
  final String country;

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  void initState() {
    API().getSportsListFromServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Sports DB"),
            countryButton("india"),
            countryButton("America"),
            countryButton("Britton"),
            countryButton("UK"),
            countryButton("Data"),
            countryButton("India"),
          ],
        ),
      ),
    );
  }

  Widget countryButton(String countryName) {
    return InkWell(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new LeaguePage(country: countryName)));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Text(countryName),
              Icon(Icons.arrow_forward),
            ],
          ),
        ));
  }
}
