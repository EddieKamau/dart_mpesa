import 'package:dart_mpesa/dart_mpesa.dart';

/// Check the status of a transaction
class MpesaTransactionStatus implements MpesaService {
  MpesaTransactionStatus(
    this.mpesa, {
    required this.transactionID,
    required this.identifierType,
    required this.remarks,
    required this.occassion,
    required this.queueTimeOutURL,
    required this.resultURL,
  });
  @override
  Mpesa mpesa;

  /// Type of organization receiving the transaction
  IdentifierType identifierType;

  /// This is the Mpesa Transaction ID of the transaction which you wish to reverse.
  String transactionID;

  /// Any additional information to be associated with the transaction.
  /// Sentence of up to 100 characters
  String remarks;

  /// Any additional information to be associated with the transaction.
  /// Sentence of upto 100 characters
  String occassion;

  /// This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  String queueTimeOutURL;

  /// This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  String resultURL;

  Map<String, dynamic> get payload => {
        'Initiator': mpesa.initiatorName,
        'SecurityCredential': mpesa.securityCredential,
        'CommandID': 'TransactionStatusQuery',
        'IdentifierType': identifierType.value,
        'TransactionID': transactionID,
        'PartyA': mpesa.shortCode,
        'Remarks': remarks,
        'QueueTimeOutURL': queueTimeOutURL,
        'ResultURL': resultURL,
        'Occassion': occassion,
      };

  String get url => mpesa.applicationMode == ApplicationMode.production
      ? mpesaTransactionStatusUrL
      : mpesaTransactionStatusUrLTest;

  @override
  Future<MpesaResponse> process() async {
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
