import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:squareneumorphic/models/aliItem.dart';
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

  final Map<String, String> headers = {
    HttpHeaders.authorizationHeader: encodedToken,
    // HttpHeaders.contentTypeHeader: "application/json"
  };
  // print(headers);
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
    print('+++++++++++++++++++++ IN ITEMMAPPED GET +++++++++++++++++++++++++');
    print('${response.statusCode}');
    print('${response.body}');
    throw Exception('Failed to load item');
  }
}

Future<SquareItem> postItemToSquare(SquareItem item) async {
  print('in post');
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
      print(
          '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print("body is: ${res.body}");
      return item;
    } else {
      print('response stat: ${res.statusCode} and the body is : ${res.body}');
      throw ('could not send item to square');
    }
  }).catchError((e) {
    print('+++++++++++++++++ the eroor was ++++++++++++++++++');
    print('$e');
    throw e;
  });
}
