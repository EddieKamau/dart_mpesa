import 'package:dart_mpesa/dart_mpesa.dart';

class MpesaLipanaMpesa implements MpesaService {
  MpesaLipanaMpesa(
    this.mpesa, 
    {
      required this.phoneNumber,
      required this.amount,
      required this.accountReference,
      required this.transactionDesc,
      required this.callBackURL,
    }
  );
  @override
  Mpesa mpesa;
  

  /// The amount of money being sent to the customer.
  double amount;
  /// The Mobile Number to receive the STK Pin Prompt.
  String phoneNumber;
  /// Account Reference: This is an Alpha-Numeric parameter that is defined by your system as an Identifier of the transaction for CustomerPayBillOnline transaction type.
  /// Maximum of 12 characters.
  String accountReference;
  /// This is any additional information/comment that can be sent along with the request from your system.
  /// Any string between 1 and 13 characters.
  String transactionDesc;
  /// A CallBack URL is a valid secure URL that is used to receive notifications from M-Pesa API. It is the endpoint to which the results will be sent by M-Pesa API.
  String callBackURL;


  Map<String, dynamic> get payload => {
    "BusinessShortCode": mpesa.shortCode,    
    "Password": mpesa.password, 
    "Timestamp": mpesa.timestamp, 
    "TransactionType": "CustomerPayBillOnline",  
    "Amount": amount,    
    "PartyA": phoneNumber,   
    "PartyB": mpesa.shortCode,   
    "PhoneNumber": phoneNumber,  
    "CallBackURL": callBackURL,    
    "AccountReference": accountReference,    
    "TransactionDesc": transactionDesc
  };

  String get url => mpesa.applicationMode == ApplicationMode.production ? mpesaLipanaMpesaOnlineUrL : mpesaLipanaMpesaOnlineUrLTest;

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
