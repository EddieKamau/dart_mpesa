/// This library contains methods that make it easy to consume Mpesa Api. 
/// It's multi-platform, and supports CLI, server, mobile, desktop, and the browser.
library dart_mpesa;

import 'dart:convert';

import 'package:dart_mpesa/src/mpesa_account_balance.dart';
import 'package:dart_mpesa/src/mpesa_bb.dart';
import 'package:dart_mpesa/src/mpesa_bc.dart';
import 'package:dart_mpesa/src/mpesa_cb.dart';
import 'package:dart_mpesa/src/mpesa_lipanampesa.dart';
import 'package:dart_mpesa/src/mpesa_reversal.dart';
import 'package:dart_mpesa/src/mpesa_stkpush_query.dart';
import 'package:dart_mpesa/src/mpesa_transaction_status.dart';
import 'package:dart_mpesa/src/utils/fetch_token.dart';
import 'package:dart_mpesa/src/utils/identifierType_enum.dart';
import 'package:dart_mpesa/src/utils/mpesa_response.dart';

export 'package:dart_mpesa/src/utils/mpesa_response.dart';
export 'package:dart_mpesa/src/mpesa_service_shell.dart';
export 'package:dart_mpesa/src/utils/urls.dart';
export 'package:dart_mpesa/src/utils/fetch_token.dart';
export 'package:dart_mpesa/src/utils/process_mpesa_post_transaction.dart';
export 'package:dart_mpesa/src/utils/identifierType_enum.dart';
export 'package:dart_mpesa/src/mpesa_bc.dart';
export 'package:dart_mpesa/src/mpesa_bb.dart';
export 'package:dart_mpesa/src/mpesa_cb.dart';

class Mpesa {
  Mpesa({
    required this.shortCode,
    required this.consumerKey,
    required this.consumerSecret,
    this.initiatorName,
    this.securityCredential,
    this.passKey,
    this.applicationMode = ApplicationMode.production,
    this.identifierType = IdentifierType.OrganizationShortCode,
  });

  ApplicationMode applicationMode = ApplicationMode.production;

  String shortCode;
  String consumerSecret;
  String consumerKey;

  /// Type of organization
  IdentifierType identifierType = IdentifierType.OrganizationShortCode;

  /// This is an API user created by the Business Administrator of the M-PESA Bulk disbursement account that is active and authorized to initiate B2C transactions via API.
  String? initiatorName;

  ///  This is the value obtained after encrypting the API initiator password. The password on Sandbox has been provisioned on the simulator. However, on production the password is created when the user is being created on the M-PESA organization portal.
  String? securityCredential;

  String? passKey;

  String get password {
    final String _codeKeyDt = shortCode + passKey! + timestamp;
    final List<int> _bytes = utf8.encode(_codeKeyDt);
    return base64.encode(_bytes);
  }

  String get timestamp {
    final DateTime _now = DateTime.now();
    return _now.year.toString() +
        _now.month.toString().padLeft(2, '0') +
        _now.day.toString().padLeft(2, '0') +
        _now.hour.toString().padLeft(2, '0') +
        _now.minute.toString().padLeft(2, '0') +
        _now.second.toString().padLeft(2, '0');
  }

  // account balance
  /// Enquire the balance on an M-Pesa BuyGoods (Till Number)
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> accountBalance({
    required String remarks,
    required String queueTimeOutURL,
    required String resultURL,
  }) {
    var _res = MpesaAccountBalance(
      this,
      remarks: remarks,
      queueTimeOutURL: queueTimeOutURL,
      resultURL: resultURL,
    );

    return _res.process();
  }

  // b2c
  /// B2C API is an API used to make payments from a Business to Customers (Pay Outs). Also known as Bulk Disbursements. B2C API is used in several scenarios by businesses that require to either make Salary Payments, Cashback payments, Promotional Payments(e.g. betting winning payouts), winnings, financial institutions withdrawal of funds, loan disbursements etc.
  /// [phoneNumber] This is the customer mobile number to receive the amount. - The number should have the country code (254) without the plus sign.
  /// [amount] The amount of money being sent to the customer.
  /// [commandID] This is a unique command that specifies B2C transaction type.(BusinessPayment, SalaryPayment, PromotionPayment)
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> b2cTransaction({
    required String phoneNumber,
    required double amount,
    required String remarks,
    required String occassion,
    required String queueTimeOutURL,
    required String resultURL,
    BcCommandId commandID = BcCommandId.BusinessPayment,
  }) {
    var _bc = MpesaB2c(this,
        phoneNumber: phoneNumber,
        amount: amount,
        remarks: remarks,
        occassion: occassion,
        queueTimeOutURL: queueTimeOutURL,
        resultURL: resultURL,
        commandID: commandID);

    return _bc.process();
  }

  // b2b
  /// The Business to Business (B2B) API is used to transfer money from one business to another business.
  /// [shortCode] This is the customer business number to receive the amount.
  /// [amount] The amount of money being sent to the customer.
  /// [identifierType] Type of organization receiving the transaction
  /// [accountReference] Any additional information to be associated with the transaction. Sentence of upto 100 characters
  /// [commandID] This is a unique command that specifies B2B transaction type. (BusinessPayBill,  BusinessBuyGoods, DisburseFundsToBusiness, BusinessToBusinessTransfer, MerchantToMerchantTransfer)
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> b2bTransaction({
    required String shortCode,
    required IdentifierType identifierType,
    required double amount,
    required String remarks,
    String? accountReference,
    required String queueTimeOutURL,
    required String resultURL,
    required BbCommandId commandID,
  }) {
    var _bb = MpesaB2B(this,
        shortCode: shortCode,
        identifierType: identifierType,
        amount: amount,
        remarks: remarks,
        accountReference: accountReference,
        queueTimeOutURL: queueTimeOutURL,
        resultURL: resultURL,
        commandID: commandID);

    return _bb.process();
  }

  // b2b paybill
  /// This is a transfer of funds from one Organization's Working Account to another Organization's Utility Account.
  /// [shortCode] This is the customer business number to receive the amount.
  /// [amount] The amount of money being sent to the customer.
  /// [accountReference] Any additional information to be associated with the transaction. Sentence of upto 100 characters
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> b2bPaybillTransaction({
    required String shortCode,
    required double amount,
    required String remarks,
    required String accountReference,
    required String queueTimeOutURL,
    required String resultURL,
  }) {
    var _bc = MpesaB2B.paybill(
      this,
      shortCode: shortCode,
      amount: amount,
      remarks: remarks,
      accountReference: accountReference,
      queueTimeOutURL: queueTimeOutURL,
      resultURL: resultURL,
    );

    return _bc.process();
  }

  // b2b buyGoods
  /// A transfer of funds from one Organization's Working Account to another Organization's Merchant Account.
  /// [shortCode] This is the customer business number to receive the amount.
  /// [amount] The amount of money being sent to the customer.
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> b2bBuyGoodsTransaction({
    required String shortCode,
    required double amount,
    required String remarks,
    required String queueTimeOutURL,
    required String resultURL,
  }) {
    var _bc = MpesaB2B.buyGoods(
      this,
      shortCode: shortCode,
      amount: amount,
      remarks: remarks,
      queueTimeOutURL: queueTimeOutURL,
      resultURL: resultURL,
    );

    return _bc.process();
  }

  // reversal
  /// Reverses a B2B, B2C or C2B M-Pesa transaction.
  /// [transactionID] This is the Mpesa Transaction ID of the transaction which you wish to reverse.
  /// [amount] The amount of money being sent to the customer.
  /// [occassion] Any additional information to be associated with the transaction. Sentence of upto 100 characters
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> reversalTransaction({
    required String transactionID,
    required double amount,
    required String remarks,
    required String occassion,
    required String queueTimeOutURL,
    required String resultURL,
  }) {
    var _revers = MpesaReversal(
      this,
      transactionID: transactionID,
      amount: amount,
      remarks: remarks,
      occassion: occassion,
      queueTimeOutURL: queueTimeOutURL,
      resultURL: resultURL,
    );

    return _revers.process();
  }

  // transaction status
  /// Check the status of a transaction
  /// [transactionID] This is the Mpesa Transaction ID of the transaction which you wish to reverse.
  /// [identifierType] Type of organization receiving the transaction (MSISDN, TillNumber, OrganizationShortCode)
  /// [occassion] Any additional information to be associated with the transaction. Sentence of upto 100 characters
  /// [remarks] Comments that are sent along with the transaction. Sentence of up to 100 characters
  /// [queueTimeOutURL] This is the URL to be specified in your request that will be used by API Proxy to send notification incase the payment request is timed out while awaiting processing in the queue.
  /// [resultURL] This is the URL to be specified in your request that will be used by M-PESA to send notification upon processing of the payment request.
  Future<MpesaResponse> transactionStatus({
    required String transactionID,
    required IdentifierType identifierType,
    required String remarks,
    required String occassion,
    required String queueTimeOutURL,
    required String resultURL,
  }) {
    var _status = MpesaTransactionStatus(
      this,
      transactionID: transactionID,
      identifierType: identifierType,
      remarks: remarks,
      occassion: occassion,
      queueTimeOutURL: queueTimeOutURL,
      resultURL: resultURL,
    );

    return _status.process();
  }

  // lipana mpesa online
  /// LIPA NA M-PESA ONLINE API also know as M-PESA express (STK Push) is a Merchant/Business initiated C2B (Customer to Business) Payment.
  /// [phoneNumber] The Mobile Number to receive the STK Pin Prompt.
  /// [amount] The amount of money being sent to the customer.
  /// [accountReference] Account Reference: This is an Alpha-Numeric parameter that is defined by your system as an Identifier of the transaction for CustomerPayBillOnline transaction type. Maximum of 12 characters.
  /// [transactionDesc] This is any additional information/comment that can be sent along with the request from your system. Any string between 1 and 13 characters.
  /// [callBackURL] A CallBack URL is a valid secure URL that is used to receive notifications from M-Pesa API. It is the endpoint to which the results will be sent by M-Pesa API.
  Future<MpesaResponse> lipanaMpesaOnline({
    required String phoneNumber,
    required double amount,
    required String accountReference,
    required String transactionDesc,
    required String callBackURL,
  }) {
    var _res = MpesaLipanaMpesa(this,
        phoneNumber: phoneNumber,
        amount: amount,
        accountReference: accountReference,
        transactionDesc: transactionDesc,
        callBackURL: callBackURL);

    return _res.process();
  }

  // stk push query
  /// Use this API to check the status of a Lipa Na M-Pesa Online Payment.
  /// [checkoutRequestID] This is a global unique identifier of the processed checkout transaction request.
  Future<MpesaResponse> stkPushQuery({
    required String checkoutRequestID,
  }) {
    var _res = MpesaStkPushQuery(
      this,
      checkoutRequestID: checkoutRequestID,
    );

    return _res.process();
  }

  // c2b simulation
  /// Make payment requests from Client to Business (C2B). Simulate is available on sandbox only
  /// [phoneNumber] This is the phone number initiating the C2B transaction.
  /// [amount] This is the amount being transacted. The parameter expected is a numeric value.
  /// [billRefNumber] This is used on CustomerPayBillOnline option only. This is where a customer is expected to enter a unique bill identifier, e.g. an Account Number. Alpha-Numeric less then 20 digits.
  /// [commandID] This is a unique identifier of the transaction type. (CustomerPayBillOnline, CustomerBuyGoodsOnline)
  Future<MpesaResponse> c2bOnlineSimulation({
    required String phoneNumber,
    required double amount,
    String? billRefNumber,
    CbCommandID commandID = CbCommandID.CustomerPayBillOnline,
  }) {
    var _res = MpesaC2BSimulation(
      this,
      phoneNumber: phoneNumber,
      amount: amount,
      billRefNumber: billRefNumber,
      commandID: commandID,
    );

    return _res.process();
  }

  // fetch token
  Future<Map<String, dynamic>> get fetchToken =>
      fetchMpesaToken(consumerKey, consumerSecret,
          applicationMode: applicationMode);
}

enum ApplicationMode { test, production }
