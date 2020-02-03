import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:squareneumorphic/models/item.dart';

Future<Item> getAliExpressItemById(String id) async {
  print('in item net');
  final response = await http.get(
      'https://7ec8t75vad.execute-api.ap-southeast-2.amazonaws.com/dev/items?item=$id');
  print("response is: $response");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    Map<String, dynamic> body = json.decode(response.body);
    print(body);
    return Item.fromJson(body);
  } else {
    print('errors');
    // If that response was not OK, throw an error.
    throw Exception('Failed to load item');
  }
}
