// ignore_for_file: omit_local_variable_types

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
          rawResponse['Body']?['stkCallback']?['CallbackMetadata'] ?? {});
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
    List<Map<String, dynamic>> _items = List.from(rawResponse['Item']);
    _items.forEach((element) {
      switch (element['Name']) {
        case 'Amount':
          amount = element['Value'];
          break;
        case 'MpesaReceiptNumber':
          mpesaReceiptNumber = element['Value'];
          break;
        case 'Balance':
          balance = element['Value'];
          break;
        case 'TransactionDate':
          transactionDate = element['Value'];
          break;
        case 'PhoneNumber':
          phoneNumber = element['Value'];
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
    orgAccountBalance = rawResponse['OrgAccountBalance'];
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
}

class ResultParameters {
  ResultParameters.fromMap(this.rawResponse) {
    List<Map<String, dynamic>> _items = List.from(rawResponse['ResultParameter']);

    _items.forEach((element) {
      switch (element['Key']) {
        case 'TransactionAmount':
          transactionAmount = element['Value'];
          break;
        case 'TransactionReceipt':
          transactionReceipt = element['Value'];
          break;
        case 'B2CWorkingAccountAvailableFunds':
          b2CWorkingAccountAvailableFunds = element['Value'];
          break;
        case 'B2CUtilityAccountAvailableFunds':
          b2CUtilityAccountAvailableFunds = element['Value'];
          break;
        case 'B2CChargesPaidAccountAvailableFunds':
          b2CChargesPaidAccountAvailableFunds = element['Value'];
          break;
        case 'B2CRecipientIsRegisteredCustomer':
          b2CRecipientIsRegisteredCustomer = element['Value'];
          break;
        case 'TransactionCompletedDateTime':
          transactionCompletedDateTime = element['Value'];
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
}

class ReversalResultParameters {
  ReversalResultParameters.fromMap(this.rawResponse) {
    List<Map<String, dynamic>> _items = List.from(rawResponse['ResultParameter']);

    _items.forEach((element) {
      switch (element['Key']) {
        case 'DebitAccountBalance':
          debitAccountBalance = element['Value'];
          break;
        case 'Amount':
          amount = element['Value'];
          break;
        case 'TransCompletedTime':
          transCompletedTime = element['Value'];
          break;
        case 'OriginalTransactionID':
          originalTransactionID = element['Value'];
          break;
        case 'Charge':
          charge = element['Value'];
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
}

class TransactionStatusResultParameters {
  TransactionStatusResultParameters.fromMap(this.rawResponse) {
    List<Map<String, dynamic>> _items = List.from(rawResponse['ResultParameter']);

    _items.forEach((element) {
      switch (element['Key']) {
        case 'DebitPartyCharges':
          debitPartyCharges = element['Value'];
          break;
        case 'Amount':
          amount = element['Value'];
          break;
        case 'InitiatedTime':
          initiatedTime = element['Value'];
          break;
        case 'FinalisedTime':
          finalisedTime = element['Value'];
          break;
        case 'ConversationID':
          conversationID = element['Value'];
          break;
        case 'ReceiptNo':
          receiptNo = element['Value'];
          break;
        case 'CreditPartyPublicName':
          creditPartyPublicName = element['Value'];
          break;
        case 'DebitPartyPublicName':
          debitPartyPublicName = element['Value'];
          break;
        case 'TransactionStatus':
          transactionStatus = element['Value'];
          break;
        case 'ReasonType':
          reasonType = element['Value'];
          break;
        case 'TransactionReason':
          transactionReason = element['Value'];
          break;
        case 'DebitAccountType':
          debitAccountType = element['Value'];
          break;
        case 'OriginatorConversationID':
          originatorConversationID = element['Value'];
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
}

class ReferenceData {
  ReferenceData.fromMap(this.rawResponse) {
    referenceItem = rawResponse['ReferenceItem']['Value'];
  }
  Map<String, dynamic> rawResponse = {};

  String? referenceItem;
}
