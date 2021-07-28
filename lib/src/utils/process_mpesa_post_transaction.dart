import 'dart:convert';

import 'package:dart_mpesa_advanced/src/utils/mpesa_response.dart';
import 'package:http/http.dart' as http;

Future<MpesaResponse> processMpesaTransaction(String url,
    Map<String, String> headers, Map<String, dynamic> payload) async {
  try {
    final http.Response _res = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(payload));
    dynamic _body;
    Map<String, dynamic>? _bodyAsmap;
    try {
      _body = json.decode(_res.body);
      _bodyAsmap = _body as Map<String, dynamic>?;
      print(_bodyAsmap);
    } catch (e) {
      _body = _res.body;
    }

    var _mpesaRespone =
        MpesaResponse.fromMap(_res.statusCode, _bodyAsmap ?? {});

    return _mpesaRespone;
  } catch (e) {
    rethrow;
  }
}
