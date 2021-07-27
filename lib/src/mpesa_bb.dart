import 'package:dart_mpesa/dart_mpesa.dart';
import 'package:enum_object/enum_object.dart';

class MpesaB2B implements MpesaService {
    
  MpesaB2B(
    this.mpesa, 
    {
      required this.shortCode,
      required this.identifierType,
      required this.amount,
      required this.remarks,
      required this.commandID,
      this.accountReference,
      required this.queueTimeOutURL,
      required this.resultURL,
    }
  );


  MpesaB2B.paybill(
    this.mpesa, 
    {
      required this.shortCode,
      required this.amount,
      required this.remarks,
      required this.accountReference,
      required this.queueTimeOutURL,
      required this.resultURL,
    }
  ){
    commandID = BbCommandId.BusinessPayBill;
    identifierType = IdentifierType.OrganizationShortCode;
  }

  MpesaB2B.buyGoods(
    this.mpesa, 
    {
      required this.shortCode,
      required this.amount,
      required this.remarks,
      required this.queueTimeOutURL,
      required this.resultURL,
    }
  ){
    commandID = BbCommandId.BusinessBuyGoods;
    identifierType = IdentifierType.TillNumber;
  }



  @override
  Mpesa mpesa;

  /// The amount of money being sent to the customer. 
  double amount;
  /// This is the customer business number to receive the amount.
  String shortCode;
  /// Type of organization receiving the transaction
  IdentifierType identifierType = IdentifierType.OrganizationShortCode;
  /// Any additional information to be associated with the transaction.
  /// Sentence of up to 100 characters
  String remarks;
  /// Any additional information to be associated with the transaction.
  /// Sentence of upto 100 characters
  String? accountReference;
  /// This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue. 
  String queueTimeOutURL;
  /// This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  String resultURL;
  /// This is a unique command that specifies B2C transaction type.
  /// SalaryPayment: This supports sending money to both registered and unregistered M-Pesa customers.
  BbCommandId commandID = BbCommandId.BusinessToBusinessTransfer;


  Map<String, dynamic> get payload => {
    "Initiator": mpesa.initiatorName,    
    "SecurityCredential": mpesa.securityCredential, 
    "CommandID": commandID.enumValue, 
    "SenderIdentifierType": "${mpesa.identifierType.value}",
    "RecieverIdentifierType": "${identifierType.value}",   
    "Amount": amount,    
    "PartyA": mpesa.shortCode,    
    "PartyB": shortCode,   
    if(accountReference != null) "AccountReference": accountReference, 
    "Remarks": remarks,    
    "QueueTimeOutURL": queueTimeOutURL,    
    "ResultURL": resultURL,  
  };

  String get url => mpesa.applicationMode == ApplicationMode.production ? mpesaBbUrL : mpesaBbUrLTest;

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

enum BbCommandId{
  BusinessPayBill, BusinessBuyGoods, DisburseFundsToBusiness, 
  BusinessToBusinessTransfer, MerchantToMerchantTransfer
}