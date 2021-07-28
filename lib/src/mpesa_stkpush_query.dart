import 'package:dart_mpesa_advanced/dart_mpesa_advanced.dart';

/// Use this API to check the status of a Lipa Na M-Pesa Online Payment.
class MpesaStkPushQuery implements MpesaService {
  MpesaStkPushQuery(
    this.mpesa, {
    required this.checkoutRequestID,
  });
  @override
  Mpesa mpesa;

  /// This is a global unique identifier of the processed checkout transaction request.
  String checkoutRequestID;

  Map<String, dynamic> get payload => {
        "BusinessShortCode": mpesa.shortCode,
        "Password": mpesa.password,
        "Timestamp": mpesa.timestamp,
        "CheckoutRequestID": checkoutRequestID,
      };

  String get url => mpesa.applicationMode == ApplicationMode.production
      ? mpesaStkpushQueryUrL
      : mpesaStkpushQueryUrLTest;

  @override
  Future<MpesaResponse> process() async {
    late Map<String, dynamic> _tokenRes;
    try {
      _tokenRes = await fetchMpesaToken(mpesa.consumerKey, mpesa.consumerSecret,
          applicationMode: mpesa.applicationMode);
    } catch (e) {
      rethrow;
    }

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${_tokenRes["token"]}'
    };

    return await processMpesaTransaction(url, headers, payload);
  }
}
