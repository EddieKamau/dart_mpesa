import 'package:dart_mpesa/dart_mpesa.dart';

/// Enquire the balance on an M-Pesa BuyGoods (Till Number)
class MpesaAccountBalance implements MpesaService {
    
  MpesaAccountBalance(
    this.mpesa, 
    {
      required this.remarks,
      required this.queueTimeOutURL,
      required this.resultURL,
    }
  );




  @override
  Mpesa mpesa;

  /// Comments that are sent along with the transaction.
  /// Sentence of up to 100 characters
  String remarks;
  /// This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue. 
  String queueTimeOutURL;
  /// This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  String resultURL;


  Map<String, dynamic> get payload => {
    "Initiator": mpesa.initiatorName,    
    "SecurityCredential": mpesa.securityCredential, 
    "CommandID": "AccountBalance", 
    "IdentifierType": "${mpesa.identifierType.value}",  
    "PartyA": mpesa.shortCode,    
    "Remarks": remarks,    
    "QueueTimeOutURL": queueTimeOutURL,    
    "ResultURL": resultURL,  
  };

  String get url => mpesa.applicationMode == ApplicationMode.production ? mpesaAccountBalanceUrL : mpesaAccountBalanceUrLTest;

  @override
  Future<MpesaResponse> process() async{
    late Map<String, dynamic> _tokenRes;
    try {
      _tokenRes = await fetchMpesaToken(mpesa.consumerKey, mpesa.consumerSecret, applicationMode: mpesa.applicationMode);

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
