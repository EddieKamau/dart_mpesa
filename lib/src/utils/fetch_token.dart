import 'dart:convert';

import 'package:dart_mpesa_advanced/dart_mpesa.dart';
import 'package:dart_mpesa_advanced/src/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:dart_mpesa_advanced/src/utils/mpesa_token_model.dart';

Future<Map<String, dynamic>> fetchMpesaToken(String username, String password,
    {bool stk = false,
    ApplicationMode applicationMode = ApplicationMode.production}) async {
  final MpesaTokenModel _mpesaTokenModel = MpesaTokenModel();
  // models
  var mpesaTokenModel = await _mpesaTokenModel.fetch(MpesaTokenType.normal);
  var mpesaTokenStkModel = await _mpesaTokenModel.fetch(MpesaTokenType.stk);

  // check if expires
  // final bool _tokenModelRes = (stk ? mpesaTokenStkModel : mpesaTokenModel)?.isNotExpired() ?? false;
  // if( _tokenModelRes){
  //   return {
  //     'status': 0,
  //     'token': (stk ? mpesaTokenStkModel : mpesaTokenModel)!.token
  //     };
  // }

  final _base64E = base64Encode(utf8.encode('$username:$password'));
  final String basicAuth = 'Basic $_base64E';

  try {
    String _url = applicationMode == ApplicationMode.production
        ? mpesaTokenUrl
        : mpesaTokenUrlTest;
    final http.Response _res = await http.get(Uri.parse(_url),
        headers: <String, String>{'authorization': basicAuth});
    if (_res.statusCode == 200) {
      final _body = json.decode(_res.body);

      // save to hive box
      await _mpesaTokenModel.put(
          // token model
          MpesaTokenModel(
              _body['access_token'].toString(), // token
              DateTime.now().add(Duration(
                  seconds: int.tryParse(_body['expires_in'].toString()) ?? 0))),

          // token type
          stk ? MpesaTokenType.stk : MpesaTokenType.normal);

      return {'status': 0, 'token': _body['access_token'].toString()};
    } else {
      throw FetchTokenError(_res.body);
      // return {
      //   'status': 1,
      //   'errorMessage': json.decode(_res.body)
      // };
    }
  } catch (e) {
    throw FetchTokenError(e.toString());
    // return {
    //     'status': 101,
    //     'errorMessage': 'cannot reach mpesa daraja endpoint'
    //   };
  }
}

class FetchTokenError extends Error {
  final String? message;
  FetchTokenError([this.message]);
  String toString() {
    var message = this.message;
    return (message != null) ? "Token Error: $message" : "Token Error";
  }
}
