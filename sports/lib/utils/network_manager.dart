import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api.dart';

class NetworkManager {
  static NetworkManager _instance = new NetworkManager.internal();

  NetworkManager.internal();

  factory NetworkManager() => _instance;

  Future<ParsedResponse> post(String url, {Map headers, body, encoding, Map params}) {
    url += encodeUrl(params);
    print("URL : $url \nHeaders $headers\nBody $body\nEnconding $encoding");
    return http.post(url, body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res == null || res.isEmpty) {
        throw Exception("Empty response");
      } else {
        return new ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      throw e;
    }).timeout(Duration(seconds: 5), onTimeout: () {
      throw TimeoutException("Timeout");
    });
  }

  String encodeUrl(Map<String, dynamic> parameters) {
    if (parameters == null) {
      return "";
    }

    String paramsString = "";
    bool first = true;

    for (String key in parameters.keys) {
      if (first) {
        first = false;
        paramsString += "?";
      } else {
        paramsString += "&";
      }
      paramsString += key + "=" + parameters[key]?.toString() ?? "";
    }
    return paramsString;
  }
}
