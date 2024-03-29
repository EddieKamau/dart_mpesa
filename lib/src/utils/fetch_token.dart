import 'dart:convert';

import 'package:dart_mpesa/dart_mpesa.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchMpesaToken(String username, String password,
    {ApplicationMode applicationMode = ApplicationMode.production}) async {
  final _base64E = base64Encode(utf8.encode('$username:$password'));
  final basicAuth = 'Basic $_base64E';

  try {
    var _url = applicationMode == ApplicationMode.production
        ? mpesaTokenUrl
        : mpesaTokenUrlTest;
    final _res = await http.get(Uri.parse(_url),
        headers: <String, String>{'authorization': basicAuth});
    if (_res.statusCode == 200) {
      final _body = json.decode(_res.body);

      return {'status': 0, 'token': _body['access_token'].toString()};
    } else {
      throw FetchTokenError(_res.body);
    }
  } catch (e) {
    throw FetchTokenError(e.toString());
  }
}

class FetchTokenError extends Error {
  final String? message;
  FetchTokenError([this.message]);
  @override
  String toString() {
    var message = this.message;
    return (message != null) ? 'Token Error: $message' : 'Token Error';
  }
}
