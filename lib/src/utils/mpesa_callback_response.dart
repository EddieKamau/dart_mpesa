class MpesaStkCallBackResponse {
  MpesaStkCallBackResponse.fromMap(this.rawResponse) {
    resultDesc = rawResponse['Body']?['stkCallback']?['ResultDesc'];
    merchantRequestID =
        rawResponse['Body']?['stkCallback']?['MerchantRequestID'];
    checkoutRequestID =
        rawResponse['Body']?['stkCallback']?['CheckoutRequestID'];
    responseCode = rawResponse['Body']?['stkCallback']?['ResultCode'];
    // if success
    if (responseCode == 0 &&
        rawResponse['Body']?['stkCallback']?['CallbackMetadata'] != null) {
      callbackMetadata = CallbackMetadata.fromMap(
          rawResponse['Body']?['stkCallback']?['CallbackMetadata']);
    }
  }

  // from http response
  Map<String, dynamic> rawResponse = {};

  //  ****stk ****
  /// Response description is an acknowledgment message from the API that gives the status of the request submission usually maps to a specific ResponseCode value. It can be a Success submission message or an error description.
  String? resultDesc;

  /// This is a global unique Identifier for any submitted payment request.
  String? merchantRequestID;

  /// This is a global unique identifier of the processed checkout transaction request.
  String? checkoutRequestID;

  /// This is a Numeric status code that indicates the status of the transaction submission. 0 means successful submission and any other code means an error occurred.
  int? responseCode;

  ///  This is the JSON object that holds more details for the transaction. It is only returned for Successful transaction.
  CallbackMetadata? callbackMetadata;
}

// ****stk****
///  This is the JSON object that holds more details for the transaction. It is only returned for Successful transaction.
class CallbackMetadata {
  CallbackMetadata.fromMap(this.rawResponse) {
    var _items = List<Map<String, dynamic>>.from(rawResponse['Item']);
    _items.forEach((element) {
      switch (element['Name']) {
        case 'Amount':
          amount = double.tryParse(element['Value'].toString());
          break;
        case 'MpesaReceiptNumber':
          mpesaReceiptNumber = element['Value'];
          break;
        case 'Balance':
          balance = double.tryParse(element['Value'].toString());
          break;
        case 'TransactionDate':
          transactionDate = _dateParser(element['Value'].toString());
          break;
        case 'PhoneNumber':
          phoneNumber = element['Value'].toString();
          break;
        default:
      }
    });
  }

  Map<String, dynamic> rawResponse = {};

  /// This is the Amount that was transacted
  double? amount;

  /// This is the unique M-PESA transaction ID for the payment request. Same value is sent to customer over SMS upon successful processing.
  String? mpesaReceiptNumber;

  /// This is the Balance of the account for the shortcode used as partyB
  double? balance;

  /// This is a timestamp that represents the date and time that the transaction completed in the formart YYYYMMDDHHmmss
  DateTime? transactionDate;

  /// This is the number of the customer who made the payment.
  String? phoneNumber;

  Map<String, dynamic> asMap() => {
        'amount': amount,
        'mpesaReceiptNumber': mpesaReceiptNumber,
        'balance': balance,
        'transactionDate': transactionDate?.toIso8601String(),
        'phoneNumber': phoneNumber,
      };
}

// ****C2B Validation****
class C2BValidation {
  C2BValidation.fromMap(this.rawResponse) {
    transactionType = rawResponse['TransactionType'];
    transID = rawResponse['TransID'];
    transTime = rawResponse[''];
    transAmount = double.tryParse(rawResponse['TransAmount'].toString());
    businessShortCode = rawResponse['BusinessShortCode'];
    billRefNumber = rawResponse['BillRefNumber'];
    invoiceNumber = rawResponse['InvoiceNumber'];
    orgAccountBalance =
        double.tryParse(rawResponse['OrgAccountBalance'].toString());
    thirdPartyTransID = rawResponse['ThirdPartyTransID'];
    mSISDN = rawResponse['MSISDN'];
    firstName = rawResponse['FirstName'];
    middleName = rawResponse['MiddleName'];
    lastName = rawResponse['LastName'];
  }

  Map<String, dynamic> rawResponse = {};

  String? transactionType;
  String? transID;
  DateTime? transTime;
  double? transAmount;
  String? businessShortCode;
  String? billRefNumber;
  String? invoiceNumber;
  double? orgAccountBalance;
  String? thirdPartyTransID;
  String? mSISDN;
  String? firstName;
  String? middleName;
  String? lastName;

  Map<String, dynamic> asMap() => {
        'transactionType': transactionType,
        'transID': transID,
        'transTime': transTime,
        'transAmount': transAmount,
        'businessShortCode': businessShortCode,
        'billRefNumber': billRefNumber,
        'invoiceNumber': invoiceNumber,
        'orgAccountBalance': orgAccountBalance,
        'thirdPartyTransID': thirdPartyTransID,
        'mSISDN': mSISDN,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
      };
}

// ****B2C****
class B2CCallBackResponse extends CommonCallBackResponse {
  B2CCallBackResponse.fromMap(this.rawResponse) : super(rawResponse) {
    referenceData =
        ReferenceData.fromMap(rawResponse['Result']?['ReferenceData'] ?? {});

    if (resultCode == 0 && rawResponse['Result']?['ResultParameters'] != null) {
      resultParameter = ResultParameters.fromMap(
          rawResponse['Result']?['ResultParameters'] ?? {});
    }
  }

  @override
  Map<String, dynamic> rawResponse = {};

  /// This is a JSON array within the ResultParameters that holds additional transaction details as JSON objects.
  ResultParameters? resultParameter;

  ReferenceData? referenceData;

  @override
  Map<String, dynamic> asMap() => {
        ...super.asMap(),
        'resultParameter': resultParameter?.asMap(),
        'referenceData': referenceData?.asMap(),
      };
}

// ****Reversal****
class ReversalCallBackResponse extends CommonCallBackResponse {
  ReversalCallBackResponse.fromMap(this.rawResponse) : super(rawResponse) {
    referenceData =
        ReferenceData.fromMap(rawResponse['Result']?['ReferenceData'] ?? {});

    if (resultCode == 0 && rawResponse['Result']?['ResultParameters'] != null) {
      resultParameter = ReversalResultParameters.fromMap(
          rawResponse['Result']?['ResultParameters'] ?? {});
    }
  }

  @override
  Map<String, dynamic> rawResponse = {};

  /// This is a JSON array within the ResultParameters that holds additional transaction details as JSON objects.
  ReversalResultParameters? resultParameter;

  ReferenceData? referenceData;

  @override
  Map<String, dynamic> asMap() => {
        ...super.asMap(),
        'resultParameter': resultParameter?.asMap(),
        'referenceData': referenceData?.asMap(),
      };
}

// ****Transaction status****
class TransactionStatusCallBackResponse extends CommonCallBackResponse {
  TransactionStatusCallBackResponse.fromMap(this.rawResponse)
      : super(rawResponse) {
    referenceData =
        ReferenceData.fromMap(rawResponse['Result']?['ReferenceData'] ?? {});

    if (resultCode == 0 && rawResponse['Result']?['ResultParameters'] != null) {
      resultParameter = TransactionStatusResultParameters.fromMap(
          rawResponse['Result']?['ResultParameters'] ?? {});
    }
  }

  @override
  Map<String, dynamic> rawResponse = {};

  /// This is a JSON array within the ResultParameters that holds additional transaction details as JSON objects.
  TransactionStatusResultParameters? resultParameter;

  ReferenceData? referenceData;

  @override
  Map<String, dynamic> asMap() => {
        ...super.asMap(),
        'resultParameter': resultParameter?.asMap(),
        'referenceData': referenceData?.asMap(),
      };
}

class CommonCallBackResponse {
  CommonCallBackResponse(this.rawResponse) {
    resultType = rawResponse['Result']?['ResultType'];
    resultCode = rawResponse['Result']?['ResultCode'];
    resultDesc = rawResponse['Result']?['ResultDesc'];
    originatorConversationID =
        rawResponse['Result']?['OriginatorConversationID'];
    transactionID = rawResponse['Result']?['TransactionID'];
    conversationID = rawResponse['Result']?['ConversationID'];
  }

  Map<String, dynamic> rawResponse = {};

  /// This is a status code that indicates whether the transaction was already sent to your listener. Usual value is 0.
  int? resultType;

  /// This is a numeric status code that indicates the status of the transaction processing. 0 means success and any other code means an error occurred or the transaction failed.
  int? resultCode;

  /// Response description is an acknowledgment message from the API that gives the status of the request submission usually maps to a specific ResponseCode value. It can be a Success submission message or an error description.
  String? resultDesc;

  /// This is a global unique identifier for the transaction request returned by the API proxy upon successful request submission.
  String? originatorConversationID;

  /// This is a unique M-PESA transaction ID for every payment request. Same value is sent to customer over SMS upon successful processing.
  String? transactionID;

  /// For every unique request made to M-PESA, a new ConversationID is generated and returned in the response. This ConversationID carries the response from M-PESA.
  String? conversationID;

  Map<String, dynamic> asMap() => {
        'resultType': resultType,
        'resultCode': resultCode,
        'resultDesc': resultDesc,
        'originatorConversationID': originatorConversationID,
        'transactionID': transactionID,
        'conversationID': conversationID,
      };
}

class ResultParameters {
  ResultParameters.fromMap(this.rawResponse) {
    var _items =
        List<Map<String, dynamic>>.from(rawResponse['ResultParameter']);

    _items.forEach((element) {
      switch (element['Key']) {
        case 'TransactionAmount':
          transactionAmount = double.tryParse(element['Value'].toString());
          break;
        case 'TransactionReceipt':
          transactionReceipt = element['Value'];
          break;
        case 'B2CWorkingAccountAvailableFunds':
          b2CWorkingAccountAvailableFunds =
              double.tryParse(element['Value'].toString());
          break;
        case 'B2CUtilityAccountAvailableFunds':
          b2CUtilityAccountAvailableFunds =
              double.tryParse(element['Value'].toString());
          break;
        case 'B2CChargesPaidAccountAvailableFunds':
          b2CChargesPaidAccountAvailableFunds =
              double.tryParse(element['Value'].toString());
          break;
        case 'B2CRecipientIsRegisteredCustomer':
          b2CRecipientIsRegisteredCustomer = element['Value'];
          break;
        case 'TransactionCompletedDateTime':
          transactionCompletedDateTime =
              _dateParser(element['Value'].toString());
          break;
        case 'ReceiverPartyPublicName':
          receiverPartyPublicName = element['Value'];
          break;
        default:
      }
    });
  }

  Map<String, dynamic> rawResponse = {};

  /// This is a unique M-PESA transaction ID for every payment request. The same value is sent to a customer over SMS upon successful processing. It is usually returned under the ResultParameter array.
  String? transactionReceipt;

  /// This is the amount that is transacted. It is also returned under the ResultParameter array.
  double? transactionAmount;

  /// This is the available balance of the Working account under the B2C shortcode used in the transaction.
  double? b2CWorkingAccountAvailableFunds;

  /// This is the available balance of the Utility account under the B2C shortcode used in the transaction.
  double? b2CUtilityAccountAvailableFunds;

  /// This is the available balance of the Charges Paid account under the B2C shortcode used in the transaction.
  double? b2CChargesPaidAccountAvailableFunds;

  /// This is a key that indicates whether the customer is a M-PESA registered customer or not. Y for YES, N for NO
  String? b2CRecipientIsRegisteredCustomer;

  /// This is the date and time that the transaction completed M-PESA.
  DateTime? transactionCompletedDateTime;

  /// This is the name and phone number of the customer who received the payment.
  String? receiverPartyPublicName;

  Map<String, dynamic> asMap() => {
        'transactionReceipt': transactionReceipt,
        'transactionAmount': transactionAmount,
        'b2CWorkingAccountAvailableFunds': b2CWorkingAccountAvailableFunds,
        'b2CUtilityAccountAvailableFunds': b2CUtilityAccountAvailableFunds,
        'b2CChargesPaidAccountAvailableFunds':
            b2CChargesPaidAccountAvailableFunds,
        'b2CRecipientIsRegisteredCustomer': b2CRecipientIsRegisteredCustomer,
        'transactionCompletedDateTime':
            transactionCompletedDateTime?.toIso8601String(),
        'receiverPartyPublicName': receiverPartyPublicName,
      };
}

class ReversalResultParameters {
  ReversalResultParameters.fromMap(this.rawResponse) {
    var _items =
        List<Map<String, dynamic>>.from(rawResponse['ResultParameter']);

    _items.forEach((element) {
      switch (element['Key']) {
        case 'DebitAccountBalance':
          debitAccountBalance = element['Value'];
          break;
        case 'Amount':
          amount = double.tryParse(element['Value'].toString());
          break;
        case 'TransCompletedTime':
          transCompletedTime = _dateParser(element['Value'].toString());
          break;
        case 'OriginalTransactionID':
          originalTransactionID = element['Value'];
          break;
        case 'Charge':
          charge = double.tryParse(element['Value'].toString());
          break;
        case 'CreditPartyPublicName':
          creditPartyPublicName = element['Value'];
          break;
        case 'DebitPartyPublicName':
          debitPartyPublicName = element['Value'];
          break;
        default:
      }
    });
  }

  Map<String, dynamic> rawResponse = {};

  String? debitAccountBalance;

  double? amount;

  DateTime? transCompletedTime;

  String? originalTransactionID;

  double? charge;

  String? creditPartyPublicName;

  String? debitPartyPublicName;

  Map<String, dynamic> asMap() => {
        'debitAccountBalance': debitAccountBalance,
        'amount': amount,
        'transCompletedTime': transCompletedTime?.toIso8601String(),
        'originalTransactionID': originalTransactionID,
        'charge': charge,
        'creditPartyPublicName': creditPartyPublicName,
        'debitPartyPublicName': debitPartyPublicName,
      };
}

class TransactionStatusResultParameters {
  TransactionStatusResultParameters.fromMap(this.rawResponse) {
    var _items =
        List<Map<String, dynamic>>.from(rawResponse['ResultParameter']);

    _items.forEach((element) {
      switch (element['Key']) {
        case 'DebitPartyCharges':
          debitPartyCharges = element['Value']?.toString();
          break;
        case 'Amount':
          amount = double.tryParse(element['Value'].toString());
          break;
        case 'InitiatedTime':
          initiatedTime = _dateParser(element['Value'].toString());
          break;
        case 'FinalisedTime':
          finalisedTime = _dateParser(element['Value'].toString());
          break;
        case 'ConversationID':
          conversationID = element['Value']?.toString();
          break;
        case 'ReceiptNo':
          receiptNo = element['Value']?.toString();
          break;
        case 'CreditPartyPublicName':
          creditPartyPublicName = element['Value']?.toString();
          break;
        case 'DebitPartyPublicName':
          debitPartyPublicName = element['Value']?.toString();
          break;
        case 'TransactionStatus':
          transactionStatus = element['Value']?.toString();
          break;
        case 'ReasonType':
          reasonType = element['Value']?.toString();
          break;
        case 'TransactionReason':
          transactionReason = element['Value']?.toString();
          break;
        case 'DebitAccountType':
          debitAccountType = element['Value']?.toString();
          break;
        case 'OriginatorConversationID':
          originatorConversationID = element['Value']?.toString();
          break;
        default:
      }
    });
  }

  Map<String, dynamic> rawResponse = {};

  String? debitPartyCharges;

  double? amount;

  DateTime? initiatedTime;

  DateTime? finalisedTime;

  String? conversationID;

  String? receiptNo;

  String? creditPartyPublicName;

  String? debitPartyPublicName;

  String? transactionStatus;

  String? reasonType;

  String? transactionReason;

  String? debitAccountType;

  String? originatorConversationID;

  Map<String, dynamic> asMap() => {
        'debitPartyCharges': debitPartyCharges,
        'amount': amount,
        'initiatedTime': initiatedTime?.toIso8601String(),
        'finalisedTime': finalisedTime?.toIso8601String(),
        'conversationID': conversationID,
        'receiptNo': receiptNo,
        'creditPartyPublicName': creditPartyPublicName,
        'debitPartyPublicName': debitPartyPublicName,
        'transactionStatus': transactionStatus,
        'reasonType': reasonType,
        'transactionReason': transactionReason,
        'debitAccountType': debitAccountType,
        'originatorConversationID': originatorConversationID,
      };
}

class ReferenceData {
  ReferenceData.fromMap(this.rawResponse) {
    referenceItem = rawResponse['ReferenceItem']['Value'];
  }
  Map<String, dynamic> rawResponse = {};

  String? referenceItem;
  Map<String, dynamic> asMap() => {'referenceItem': referenceItem};
}

DateTime _dateParser(String val) {
  try {
    var _list = val.split('');
    var _dt = '${_list.sublist(0, 4).join()}-'; // year
    _dt = '$_dt${_list.sublist(4, 6).join()}-'; // month
    _dt = '$_dt${_list.sublist(6, 8).join()} '; // day
    _dt = '$_dt${_list.sublist(8, 10).join()}:'; // hour
    _dt = '$_dt${_list.sublist(10, 12).join()}:'; // min
    _dt = '$_dt${_list.sublist(12, 14).join()}'; // hour

    return DateTime.parse(_dt);
  } catch (e) {
    return DateTime.now();
  }
}
