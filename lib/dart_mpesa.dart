/// Support for doing something awesome.
///
/// More dartdocs go here.
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
import 'package:dart_mpesa/src/utils/identifierType_enum.dart';
import 'package:dart_mpesa/src/utils/mpesa_response.dart';


export 'package:dart_mpesa/src/utils/mpesa_response.dart';
export 'package:dart_mpesa/src/mpesa_service_shell.dart';
export 'package:dart_mpesa/src/utils/urls.dart';
export 'package:dart_mpesa/src/utils/fetch_token.dart';
export 'package:dart_mpesa/src/utils/process_mpesa_post_transaction.dart';
export 'package:dart_mpesa/src/utils/identifierType_enum.dart';


class Mpesa {
  Mpesa({
    required this.shortCode,
    required this.consumerKey,
    required this.consumerSecret,
    this.initiatorName,
    this.securityCredential,
    this.passKey
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

  String get password{
    final String _codeKeyDt = shortCode + passKey! + timestamp;
    final List<int> _bytes = utf8.encode(_codeKeyDt);
    return base64.encode(_bytes);
  }
  String get timestamp{
    final DateTime _now = DateTime.now();
    return _now.year.toString() + _now.month.toString().padLeft(2, '0') + _now.day.toString().padLeft(2, '0') + _now.hour.toString().padLeft(2, '0') + _now.minute.toString().padLeft(2, '0') + _now.second.toString().padLeft(2, '0');
  }


  // account balance
  /// Enquire the balance on an M-Pesa BuyGoods (Till Number)
  Future<MpesaResponse> accountBalance({
    required String remarks, required String queueTimeOutURL, required String resultURL,
  }){
    var _res = MpesaAccountBalance(
      this, 
      remarks: remarks, queueTimeOutURL: queueTimeOutURL, resultURL: resultURL, 
    );

    return _res.process();
  }


  // b2c
  Future<MpesaResponse> b2cTransaction({
    required String phoneNumber, required double amount, required String remarks,
    required String occassion, required String queueTimeOutURL, required String resultURL,
    BcCommandId commandID = BcCommandId.BusinessPayment,
  }){
    var _bc = MpesaB2c(
      this, 
      phoneNumber: phoneNumber, amount: amount, remarks: remarks, occassion: occassion,
      queueTimeOutURL: queueTimeOutURL, resultURL: resultURL, commandID: commandID
    );

    return _bc.process();
  }

  // b2b
  Future<MpesaResponse> b2bTransaction({
    required String shortCode, required IdentifierType identifierType, required double amount, required String remarks,
    String? accountReference, required String queueTimeOutURL, required String resultURL,
    required BbCommandId commandID,
  }){
    var _bb = MpesaB2B(
      this, 
      shortCode: shortCode, identifierType: identifierType, amount: amount, remarks: remarks, 
      accountReference: accountReference, queueTimeOutURL: queueTimeOutURL, resultURL: resultURL, commandID: commandID
    );

    return _bb.process();
  }


  // b2b paybill
  Future<MpesaResponse> b2bPaybillTransaction({
    required String shortCode, required double amount, required String remarks,
    required String accountReference, required String queueTimeOutURL, required String resultURL,
  }){
    var _bc = MpesaB2B.paybill(
      this, 
      shortCode: shortCode, amount: amount, remarks: remarks, accountReference: accountReference,
      queueTimeOutURL: queueTimeOutURL, resultURL: resultURL,
    );

    return _bc.process();
  }


  // b2b buyGoods
  Future<MpesaResponse> b2bBuyGoodsTransaction({
    required String shortCode, required double amount, required String remarks,
    required String queueTimeOutURL, required String resultURL,
  }){
    var _bc = MpesaB2B.buyGoods(
      this, 
      shortCode: shortCode, amount: amount, remarks: remarks,
      queueTimeOutURL: queueTimeOutURL, resultURL: resultURL,
    );

    return _bc.process();
  }

  // reversal
  Future<MpesaResponse> reversalTransaction({
    required String transactionID, required double amount, required String remarks,
    required String occassion, required String queueTimeOutURL, required String resultURL,
  }){
    var _revers = MpesaReversal(
      this, 
      transactionID: transactionID, amount: amount, remarks: remarks, occassion: occassion,
      queueTimeOutURL: queueTimeOutURL, resultURL: resultURL, 
    );

    return _revers.process();
  }

  // transaction status
  Future<MpesaResponse> transactionStatus({
    required String transactionID, required IdentifierType identifierType, required String remarks,
    required String occassion, required String queueTimeOutURL, required String resultURL,
  }){
    var _status = MpesaTransactionStatus(
      this, 
      transactionID: transactionID, identifierType: identifierType, remarks: remarks, occassion: occassion,
      queueTimeOutURL: queueTimeOutURL, resultURL: resultURL, 
    );

    return _status.process();
  }


  
  // lipana mpesa online
  Future<MpesaResponse> lipanaMpesaOnline({
    required String phoneNumber, required double amount, required String accountReference,
    required String transactionDesc, required String callBackURL,
  }){
    var _res = MpesaLipanaMpesa(
      this, 
      phoneNumber: phoneNumber, amount: amount, accountReference: accountReference, transactionDesc: transactionDesc,
      callBackURL: callBackURL
    );

    return _res.process();
  }


  // stk push query
  Future<MpesaResponse> stkPushQuery({
    required String checkoutRequestID, 
  }){
    var _res = MpesaStkPushQuery(
      this, 
      checkoutRequestID: checkoutRequestID,
    );

    return _res.process();
  }


  // c2b simulation
  Future<MpesaResponse> c2bOnlineSimulation({
    required String phoneNumber, required double amount, 
    String? billRefNumber, CbCommandID commandID = CbCommandID.CustomerPayBillOnline, 
  }){
    var _res = MpesaC2BSimulation(
      this, 
      phoneNumber: phoneNumber,
      amount: amount,
      billRefNumber: billRefNumber,
      commandID: commandID,
    );

    return _res.process();
  }


  
  
  
}

enum ApplicationMode{
  test, production
}