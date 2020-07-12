import 'package:sports/country/data_classes.dart';

List<Sports> globalSportsList = new List();

Map<String, Sports> getSportsMap() {
  Map<String, Sports> nameUnitMap = new Map();
  globalSportsList?.forEach((sport) {
    if (null != sport && null != sport.strSport && sport.strSport.isNotEmpty) {
      nameUnitMap[sport.strSport] = sport;
    }
  });
  return nameUnitMap;
}
