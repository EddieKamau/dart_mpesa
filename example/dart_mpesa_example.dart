import 'package:dart_mpesa_advanced/dart_mpesa.dart';
import 'package:dart_mpesa_advanced/src/mpesa_bb.dart';
import 'package:dart_mpesa_advanced/src/mpesa_bc.dart';

void main() async {
  var mpesa = Mpesa(
      shortCode: "",
      consumerKey: "",
      consumerSecret: "",
      initiatorName: "",
      securityCredential: "",
      passKey: "",
      identifierType: IdentifierType
          .OrganizationShortCode, // Type of organization, options, OrganizationShortCode, TillNumber, OrganizationShortCode
      applicationMode: ApplicationMode.test);

  // lipa na mpesa online
  MpesaResponse _res = await mpesa.lipanaMpesaOnline(
    phoneNumber: "",
    amount: 0,
    accountReference: "",
    transactionDesc: "",
    callBackURL: "",
  );

  print(_res.statusCode);
  print(_res.rawResponse);

  // b2c
  _res = await mpesa.b2cTransaction(
      phoneNumber: "",
      amount: 0,
      remarks: "",
      occassion: "",
      resultURL: "",
      queueTimeOutURL: "",
      commandID: BcCommandId.BusinessPayment // default
      );

  print(_res.statusCode);
  print(_res.rawResponse);

  // b2b paybill
  _res = await mpesa.b2bPaybillTransaction(
    shortCode: "",
    amount: 0,
    remarks: "",
    accountReference: "",
    resultURL: "",
    queueTimeOutURL: "",
  );

  print(_res.statusCode);
  print(_res.rawResponse);

  // b2b buy goods
  _res = await mpesa.b2bBuyGoodsTransaction(
    shortCode: "",
    amount: 0,
    remarks: "",
    resultURL: "",
    queueTimeOutURL: "",
  );

  print(_res.statusCode);
  print(_res.rawResponse);

  // b2b
  _res = await mpesa.b2bTransaction(
    shortCode: "",
    amount: 0,
    remarks: "",
    accountReference: "", // optional
    resultURL: "",
    queueTimeOutURL: "",
    identifierType: IdentifierType
        .OrganizationShortCode, // options, OrganizationShortCode, TillNumber, OrganizationShortCode
    commandID: BbCommandId
        .BusinessToBusinessTransfer, // options, BusinessToBusinessTransfer, BusinessPayBill, BusinessBuyGoods, DisburseFundsToBusiness, MerchantToMerchantTransfer
  );

  print(_res.statusCode);
  print(_res.rawResponse);

  // account balance
  _res = await mpesa.accountBalance(
    remarks: "",
    resultURL: "",
    queueTimeOutURL: "",
  );

  // transaction status
  _res = await mpesa.transactionStatus(
    transactionID: "",
    identifierType:
        IdentifierType.MSISDN, // Type of organization receiving the transaction
    remarks: "",
    occassion: "",
    resultURL: "",
    queueTimeOutURL: "",
  );

  print(_res.statusCode);
  print(_res.rawResponse);
}
