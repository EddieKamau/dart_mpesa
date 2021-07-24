/// Support for doing something awesome.
///
/// More dartdocs go here.
library dart_mpesa;

import 'package:dart_mpesa/src/mpesa_bc.dart';
import 'package:dart_mpesa/src/utils/mpesa_response.dart';


export 'package:dart_mpesa/src/utils/mpesa_response.dart';
export 'package:dart_mpesa/src/mpesa_service_shell.dart';
export 'package:dart_mpesa/src/utils/urls.dart';
export 'package:dart_mpesa/src/utils/fetch_token.dart';
export 'package:dart_mpesa/src/utils/process_mpesa_post_transaction.dart';


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

  /// This is an API user created by the Business Administrator of the M-PESA Bulk disbursement account that is active and authorized to initiate B2C transactions via API.
  String? initiatorName;
  ///  This is the value obtained after encrypting the API initiator password. The password on Sandbox has been provisioned on the simulator. However, on production the password is created when the user is being created on the M-PESA organization portal.
  String? securityCredential;
  
  String? passKey;

  Future<MpesaResponse> b2cTransaction({
    required String phoneNumber,
    required double amount,
    required String remarks,
    required String occassion,
    required String queueTimeOutURL,
    required String resultURL,
    BcCommandId commandID = BcCommandId.BusinessPayment,
  }){

    var _bc = MpesaB2c(
      this, applicationMode, 
      phoneNumber: phoneNumber,
      amount: amount,
      remarks: remarks,
      occassion: occassion,
      queueTimeOutURL: queueTimeOutURL,
      resultURL: resultURL,
      commandID: commandID
    );

    return _bc.process();

  }
  
}

enum ApplicationMode{
  test, production
}