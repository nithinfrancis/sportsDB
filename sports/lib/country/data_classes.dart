import 'package:sports/utils/globals.dart';

class SportsList {
  List<Sports> sportsList;

  SportsList({this.sportsList});

  SportsList.fromJson(Map<String, dynamic> json) {
    if (json['sports'] != null) {
      globalSportsList.clear();
      sportsList = new List<Sports>();
      json['sports'].forEach((v) {
        Sports temp = new Sports.fromJson(v);
        sportsList.add(temp);
        globalSportsList.add(temp);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sportsList != null) {
      data['sports'] = this.sportsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sports {
  String idSport;
  String strSport;
  String strFormat;
  String strSportThumb;
  String strSportThumbGreen;
  String strSportDescription;

  Sports(
      {this.idSport,
        this.strSport,
        this.strFormat,
        this.strSportThumb,
        this.strSportThumbGreen,
        this.strSportDescription});

  Sports.fromJson(Map<String, dynamic> json) {
    idSport = json['idSport'];
    strSport = json['strSport'];
    strFormat = json['strFormat'];
    strSportThumb = json['strSportThumb'];
    strSportThumbGreen = json['strSportThumbGreen'];
    strSportDescription = json['strSportDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSport'] = this.idSport;
    data['strSport'] = this.strSport;
    data['strFormat'] = this.strFormat;
    data['strSportThumb'] = this.strSportThumb;
    data['strSportThumbGreen'] = this.strSportThumbGreen;
    data['strSportDescription'] = this.strSportDescription;
    return data;
  }
}