import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/models/webStorage.dart';

final String url =
    "https://7ec8t75vad.execute-api.ap-southeast-2.amazonaws.com";

/// Gets relevant item information from api and returns Item
Future<AliItem> getAliExpressItemById(String id) async {
  String encodedToken;
  try {
    encodedToken = await WebStorage.getToken();
  } catch (e) {
    throw Exception('you do not have a valid token to access');
  }
  http.Response response;

  final Map<String, String> headers = {
    HttpHeaders.authorizationHeader: encodedToken,
    HttpHeaders.contentTypeHeader: "application/json"
  };

  try {
    response = await http.get('$url/dev/items?item=$id', headers: headers);
  } catch (e) {
    print(e);
    throw e;
  }

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    final Map<String, dynamic> body = json.decode(response.body);
    AliItem.fromJson(body).log();
    return AliItem.fromJson(body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception(jsonDecode(response.body)['message']);
  }
}

/// sends item to API to be added to Square store
Future<SquareItem> postItemToSquare(SquareItem item) async {
  String encodedToken;
  try {
    encodedToken = await WebStorage.getToken();
  } on Exception catch (e) {
    print('something went wrog with token loading');
    throw e;
  }

  String reqBody = jsonEncode({"itemFromClient": item.toJson()});
  print(reqBody);
  Map<String, String> reqHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: encodedToken,
  };
  return http
      .post('$url/dev/items', body: reqBody, headers: reqHeaders)
      .then((res) {
    if (res.statusCode == 200) {
      return item;
    } else {
      throw ('could not send item to square');
    }
  }).catchError((e) {
    throw e;
  });
}
