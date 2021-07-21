import 'dart:convert';

import 'package:dart_mpesa/src/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:dart_mpesa/src/utils/mpesa_token_model.dart';

Future<Map<String, dynamic>> fetchMpesaToken(String username, String password, {bool stk = false, bool live = true})async{

  final MpesaTokenModel _mpesaTokenModel = MpesaTokenModel();
  // models
  var mpesaTokenModel = _mpesaTokenModel.fetch(MpesaTokenType.normal) as MpesaTokenModel?;
  var mpesaTokenStkModel = _mpesaTokenModel.fetch(MpesaTokenType.stk) as MpesaTokenModel?;


  // check if expires
  final bool _tokenModelRes = (stk ? mpesaTokenStkModel : mpesaTokenModel)?.isNotExpired() ?? false;
  if( _tokenModelRes){
    return {
      'status': 0,
      'token': (stk ? mpesaTokenStkModel : mpesaTokenModel)!.token
      };
  }


  final _base64E = base64Encode(utf8.encode('$username:$password'));
  final String basicAuth = 'Basic $_base64E';


  try{
    String _url = live ? mpesaTokenUrl : mpesaTokenUrlTest;
    final http.Response _res = await http.get(Uri.parse(mpesaTokenUrl),headers: <String, String>{'authorization': basicAuth});
    if(_res.statusCode == 200){
      final _body = json.decode(_res.body);

      // save to hive box
      await _mpesaTokenModel.put(
        // token model
        MpesaTokenModel(
          _body['access_token'].toString(), // token
          DateTime.now().add(Duration(seconds: int.tryParse(_body['expires_in'].toString()) ?? 0))
        ),

        // token type
        stk ? MpesaTokenType.stk : MpesaTokenType.normal
      );


      return {
        'status': 0,
        'token': _body['access_token'].toString()
        };
    } else {
      return {
        'status': 1,
        'errorMessage': json.decode(_res.body)
      };
    }
  }catch (e){
    return {
        'status': 101,
        'errorMessage': 'cannot reach mpesa daraja endpoint'
      };
  }
}
