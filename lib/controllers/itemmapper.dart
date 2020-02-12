import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/jwttoken.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/models/webStorage.dart';

final String url =
    "https://7ec8t75vad.execute-api.ap-southeast-2.amazonaws.com";

///
Future<AliItem> getAliExpressItemById(String id) async {
  print('in item net');
  String encodedToken;
  try {
    encodedToken = await WebStorage.getToken();
  } catch (e) {
    throw Exception('you do not have a valid token to access');
  }
  http.Response response;
  // final Map<String, dynamic> decodedToken = parseJwt(encodedToken);
  // print(decodedToken);
  // final String encryptedSquareToken =
  //     decodedToken['squareInfo']['access_token'];
  final Map<String, String> headers = {
    HttpHeaders.authorizationHeader: encodedToken
  };
  print(headers);
  try {
    response = await http.get('$url/dev/items?item=$id', headers: headers);
  } catch (e) {
    print(e);
    throw Exception('$e');
  }

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final Map<String, dynamic> body = json.decode(response.body);
    // print(body);
    return AliItem.fromJson(body);
  } else {
    print('errors');
    // If that response was not OK, throw an error.
    throw Exception('Failed to load item');
  }
}

Future<SquareItem> postItemToSquare(SquareItem item) async {
  String encodedToken;
  try {
    encodedToken = await WebStorage.getToken();
  } catch (e) {
    throw Exception('you do not have a valid token to access');
  }

  String reqBody = jsonEncode({"itemFromClient": item.toJson()});
  Map<String, String> reqHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '$encodedToken'
  };

  return http
      .post(Uri.parse('$url/dev/items'), body: reqBody, headers: reqHeaders)
      .then((res) {
    if (res.statusCode == 200) {
      return item;
    } else {
      print('response stat: ${res.statusCode} and the body is : ${res.body}');
      throw ('could not send item to square');
    }
  }).catchError((e) {
    throw e;
  });
}
