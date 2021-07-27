import 'package:dart_mpesa/dart_mpesa.dart';
import 'package:enum_object/enum_object.dart';

/// Make payment requests from Client to Business (C2B). Simulate is available on sandbox only
class MpesaC2BSimulation implements MpesaService {
  MpesaC2BSimulation(
    this.mpesa, 
    {
      required this.phoneNumber,
      required this.amount,
      this.billRefNumber,
      this.commandID = CbCommandID.CustomerPayBillOnline,
    }
  );
  @override
  Mpesa mpesa;


  /// This is the phone number initiating the C2B transaction.
  String phoneNumber;
  /// This is the amount being transacted. The parameter expected is a numeric value.
  double amount;
  /// This is used on CustomerPayBillOnline option only. This is where a customer is expected to enter a unique bill identifier, e.g. an Account Number.
  /// Alpha-Numeric less then 20 digits.
  String? billRefNumber;
  /// This is a unique identifier of the transaction type: There are two types of these Identifiers:
  /// CustomerPayBillOnline: This is used for Pay Bills shortcodes.
  /// CustomerBuyGoodsOnline: This is used for Buy Goods shortcodes.
  CbCommandID commandID;


  Map<String, dynamic> get payload => {
    "ShortCode": mpesa.shortCode,  
    "CommandID": commandID.enumValue,
    "Amount": amount, 
    "Msisdn": phoneNumber, 
    if(billRefNumber != null) "BillRefNumber": billRefNumber,
  };

  String get url => mpesacbSimulationUrLTest;

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

/// [CbCommandID.CustomerPayBillOnline] This is used for Pay Bills shortcodes.
/// [CbCommandID.CustomerBuyGoodsOnline] This is used for Buy Goods shortcodes.
enum CbCommandID{
  CustomerPayBillOnline, CustomerBuyGoodsOnline
}