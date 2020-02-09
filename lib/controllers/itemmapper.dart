import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/squareItem.dart';

final String url =
    "https://7ec8t75vad.execute-api.ap-southeast-2.amazonaws.com";

Future<AliItem> getAliExpressItemById(String id) async {
  print('in item net');
  final response = await http.get('$url/dev/items?item=$id');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    Map<String, dynamic> body = json.decode(response.body);
    // print(body);
    return AliItem.fromJson(body);
  } else {
    print('errors');
    // If that response was not OK, throw an error.
    throw Exception('Failed to load item');
  }
}

Future<SquareItem> postItemToSquare(SquareItem item) async {
  String reqBody = jsonEncode({"itemFromClient": item.toJson()});
  Map<String, String> reqHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
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
