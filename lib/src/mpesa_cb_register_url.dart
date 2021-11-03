import 'package:dart_mpesa/dart_mpesa.dart';

/// Register validation and confirmation URLs on M-Pesa
class MpesaC2BRegisterUrl implements MpesaService {
  MpesaC2BRegisterUrl(this.mpesa,{
    required this.responseType, required this.validationURL, required this.confirmationURL
  });

  @override
  Mpesa mpesa;

  /// [responseType] parameter specifies what is to happen if for any reason the validation URL is not reachable. Only two value are allowed: Completed or Cancelled .
  String responseType;
  /// [confirmationURL] is the URL that receives the confirmation request from API upon payment completion
  String confirmationURL;
  /// [validationURL] is the URL that receives the validation request from API upon payment submission. The validation URL is only called if external validation on the registered shortcode is enabled. (By default external validation is disabled)
  String validationURL;


  Map<String, dynamic> get payload => {
        'ShortCode': mpesa.shortCode,
        'ResponseType': responseType,
        'ConfirmationURL': confirmationURL,
        'ValidationURL': validationURL,
      };

  String get url => mpesa.applicationMode == ApplicationMode.test ?
                     mpesaCbRegisterUrlUrLTest: mpesaCbRegisterUrlUrL;

  @override
  Future<MpesaResponse> process() async{
    late Map<String, dynamic> _tokenRes;
    try {
      _tokenRes = await fetchMpesaToken(mpesa.consumerKey, mpesa.consumerSecret,
          applicationMode: mpesa.applicationMode);
    } catch (e) {
      rethrow;
    }

    var headers = <String, String>{
      'content-type': 'application/json',
      'Authorization': 'Bearer ${_tokenRes["token"]}'
    };

    return await processMpesaTransaction(url, headers, payload);
  }
}

