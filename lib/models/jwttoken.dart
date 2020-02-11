import 'dart:convert';

String _getJsonFromJWT(String splittedToken) {
  String normalizedSource = base64Url.normalize(splittedToken);
  return utf8.decode(base64Url.decode(normalizedSource));
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _getJsonFromJWT(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}
