import 'package:dart_mpesa_advanced/dart_mpesa_advanced.dart';
import 'package:enum_object/enum_object.dart';

/// B2C API is an API used to make payments from a Business to Customers (Pay Outs). Also known as Bulk Disbursements. B2C API is used in several scenarios by businesses that require to either make Salary Payments, Cashback payments, Promotional Payments(e.g. betting winning payouts), winnings, financial institutions withdrawal of funds, loan disbursements etc.
class MpesaB2c implements MpesaService {
  MpesaB2c(this.mpesa,
      {required this.phoneNumber,
      required this.amount,
      required this.remarks,
      required this.occassion,
      required this.queueTimeOutURL,
      required this.resultURL,
      this.commandID = BcCommandId.BusinessPayment});
  @override
  Mpesa mpesa;

  /// The amount of money being sent to the customer.
  double amount;

  /// This is the customer mobile number to receive the amount. - The number should have the country code (254) without the plus sign.
  String phoneNumber;

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

  /// This is a unique command that specifies B2C transaction type.
  /// SalaryPayment: This supports sending money to both registered and unregistered M-Pesa customers.
  /// BusinessPayment: This is a normal business to customer payment, supports only M-PESA registered customers.
  /// PromotionPayment: This is a promotional payment to customers. The M-PESA notification message is a congratulatory message. Supports only M-PESA registered customers.
  BcCommandId commandID;

  Map<String, dynamic> get payload => {
        "InitiatorName": mpesa.initiatorName,
        "SecurityCredential": mpesa.securityCredential,
        "CommandID": commandID.enumValue,
        "Amount": amount,
        "PartyA": mpesa.shortCode,
        "PartyB": phoneNumber,
        "Remarks": remarks,
        "QueueTimeOutURL": queueTimeOutURL,
        "ResultURL": resultURL,
        "Occassion": occassion
      };

  String get url => mpesa.applicationMode == ApplicationMode.production
      ? mpesaBcUrL
      : mpesaBcUrLTest;

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

/// [BcCommandId.SalaryPayment] This supports sending money to both registered
/// [BcCommandId.BusinessPayment] BusinessPayment: This is a normal business to customer payment, supports only M-PESA registered customers.
/// [PromotionPayment] PromotionPayment: This is a promotional payment to customers. The M-PESA notification message is a congratulatory message. Supports only M-PESA registered customers.
enum BcCommandId { SalaryPayment, BusinessPayment, PromotionPayment }
