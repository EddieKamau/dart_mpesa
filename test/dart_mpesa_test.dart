import 'package:dart_mpesa_advanced/dart_mpesa.dart';
import 'package:dart_mpesa_advanced/src/mpesa_bb.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'responses.dart';

class MockMpesa extends Mock implements Mpesa {
  MockMpesa([this.identifierT = IdentifierType.OrganizationShortCode]);
  IdentifierType identifierT;
  @override
  IdentifierType get identifierType => identifierT;
  @override
  Future<MpesaResponse> accountBalance(
      {required String remarks,
      required String queueTimeOutURL,
      required String resultURL}) {
    return Future.value(MpesaResponse.fromMap(200, default1));
  }

  @override
  Future<MpesaResponse> b2cTransaction({
    required String phoneNumber,
    required double amount,
    required String remarks,
    required String occassion,
    required String queueTimeOutURL,
    required String resultURL,
    BcCommandId commandID = BcCommandId.BusinessPayment,
  }) {
    return Future.value(MpesaResponse.fromMap(200, default1));
  }

  @override
  Future<MpesaResponse> b2bBuyGoodsTransaction(
      {required String shortCode,
      required double amount,
      required String remarks,
      required String queueTimeOutURL,
      required String resultURL}) {
    return Future.value(MpesaResponse.fromMap(200, default1));
  }

  @override
  Future<MpesaResponse> b2bPaybillTransaction(
      {required String shortCode,
      required double amount,
      required String remarks,
      required String accountReference,
      required String queueTimeOutURL,
      required String resultURL}) {
    return Future.value(MpesaResponse.fromMap(200, default1));
  }

  @override
  Future<MpesaResponse> b2bTransaction(
      {required String shortCode,
      required double amount,
      required String remarks,
      required String queueTimeOutURL,
      required String resultURL,
      required IdentifierType identifierType,
      required BbCommandId commandID,
      String? accountReference}) {
    if (commandID == BbCommandId.MerchantToMerchantTransfer) {
      if (this.identifierType == IdentifierType.OrganizationShortCode) {
        if (identifierType == IdentifierType.OrganizationShortCode) {
          return Future.value(MpesaResponse.fromMap(200, default1));
        } else {
          return Future.value(MpesaResponse.fromMap(
              400, b2bReceiverError(identifierType.value)));
        }
      } else {
        return Future.value(MpesaResponse.fromMap(
            400, b2bPrimaryError(this.identifierType.value)));
      }
    } else {
      return Future.value(MpesaResponse.fromMap(200, default1));
    }
  }

  @override
  Future<MpesaResponse> lipanaMpesaOnline(
      {required String phoneNumber,
      required double amount,
      required String accountReference,
      required String transactionDesc,
      required String callBackURL}) {
    return Future.value(MpesaResponse.fromMap(200, stkSuccess));
  }

  @override
  Future<MpesaResponse> stkPushQuery({required String checkoutRequestID}) {
    return Future.value(MpesaResponse.fromMap(200, stkQuer));
  }

  @override
  Future<MpesaResponse> reversalTransaction(
      {required String transactionID,
      required double amount,
      required String remarks,
      required String occassion,
      required String queueTimeOutURL,
      required String resultURL}) {
    return Future.value(MpesaResponse.fromMap(200, default1));
  }

  @override
  Future<MpesaResponse> transactionStatus(
      {required String transactionID,
      required IdentifierType identifierType,
      required String remarks,
      required String occassion,
      required String queueTimeOutURL,
      required String resultURL}) {
    return Future.value(MpesaResponse.fromMap(200, default1));
  }
}

void main() {
  group('mpesa', () {
    final mpesa = MockMpesa();

    setUp(() {
      // Additional setup goes here.
    });

    test('b2b', () async {
      expect(
          (await mpesa.b2bTransaction(
                  shortCode: "",
                  amount: 0,
                  remarks: '',
                  queueTimeOutURL: '',
                  resultURL: '',
                  identifierType: IdentifierType.OrganizationShortCode,
                  commandID: BbCommandId.BusinessToBusinessTransfer))
              .statusCode,
          200);
    });

    test('lipa na mpesa', () async {
      expect(
          (await mpesa.lipanaMpesaOnline(
                  phoneNumber: "",
                  amount: 0,
                  accountReference: "",
                  transactionDesc: "",
                  callBackURL: "callBackURL"))
              .merchantRequestID,
          "29115-34620561-1");
    });

    test('account balance', () async {
      expect(
          (await mpesa.accountBalance(
                  remarks: "remarks", queueTimeOutURL: "", resultURL: ""))
              .conversationID,
          "AG_20191219_00005797af5d7d75f652");
    });

    test('b2b error', () async {
      expect(
          (await mpesa.b2bTransaction(
                  shortCode: "",
                  amount: 0,
                  remarks: '',
                  queueTimeOutURL: '',
                  resultURL: '',
                  identifierType: IdentifierType.TillNumber,
                  commandID: BbCommandId.MerchantToMerchantTransfer))
              .statusCode,
          400);
    });
  });
}
