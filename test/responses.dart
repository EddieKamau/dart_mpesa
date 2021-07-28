// stkpush
// success
Map<String, dynamic> stkSuccess = {
  "MerchantRequestID": "29115-34620561-1",
  "CheckoutRequestID": "ws_CO_191220191020363925",
  "ResponseCode": "0",
  "ResponseDescription": "Success. Request accepted for processing",
  "CustomerMessage": "Success. Request accepted for processing"
};
// successfull callback
Map<String, dynamic> stkSuccessCallBack = {
  "Body": {
    "stkCallback": {
      "MerchantRequestID": "29115-34620561-1",
      "CheckoutRequestID": "ws_CO_191220191020363925",
      "ResultCode": 0,
      "ResultDesc": "The service request is processed successfully.",
      "CallbackMetadata": {
        "Item": [
          {"Name": "Amount", "Value": 1.00},
          {"Name": "MpesaReceiptNumber", "Value": "NLJ7RT61SV"},
          {"Name": "TransactionDate", "Value": 20191219102115},
          {"Name": "PhoneNumber", "Value": 254708374149}
        ]
      }
    }
  }
};

// failed callback
Map<String, dynamic> stkFailedCallback = {
  "Body": {
    "stkCallback": {
      "MerchantRequestID": "29115-34620561-1",
      "CheckoutRequestID": "ws_CO_191220191020363925",
      "ResultCode": 1032,
      "ResultDesc": "Request cancelled by user."
    }
  }
};

// c2b
// validation
Map<String, dynamic> c2bValidation = {
  "TransactionType": "Pay Bill",
  "TransID": "RKTQDM7W6S",
  "TransTime": "20191122063845",
  "TransAmount": "10",
  "BusinessShortCode": "600638",
  "BillRefNumber": "254708374149",
  "InvoiceNumber": "",
  "OrgAccountBalance": "49197.00",
  "ThirdPartyTransID": "",
  "MSISDN": "254708374149",
  "FirstName": "John",
  "MiddleName": "",
  "LastName": "Doe"
};

// b2c
// success
Map<String, dynamic> b2cSuccesCallback = {
  "Result": {
    "ResultType": 0,
    "ResultCode": 0,
    "ResultDesc": "The service request is processed successfully.",
    "OriginatorConversationID": "10571-7910404-1",
    "ConversationID": "AG_20191219_00004e48cf7e3533f581",
    "TransactionID": "NLJ41HAY6Q",
    "ResultParameters": {
      "ResultParameter": [
        {"Key": "TransactionAmount", "Value": 10},
        {"Key": "TransactionReceipt", "Value": "NLJ41HAY6Q"},
        {"Key": "B2CRecipientIsRegisteredCustomer", "Value": "Y"},
        {"Key": "B2CChargesPaidAccountAvailableFunds", "Value": -4510.00},
        {"Key": "ReceiverPartyPublicName", "Value": "254708374149 - John Doe"},
        {"Key": "TransactionCompletedDateTime", "Value": "19.12.2019 11:45:50"},
        {"Key": "B2CUtilityAccountAvailableFunds", "Value": 10116.00},
        {"Key": "B2CWorkingAccountAvailableFunds", "Value": 900000.00}
      ]
    },
    "ReferenceData": {
      "ReferenceItem": {
        "Key": "QueueTimeoutURL",
        "Value":
            "https:\/\/internalsandbox.safaricom.co.ke\/mpesa\/b2cresults\/v1\/submit"
      }
    }
  }
};

// failed
Map<String, dynamic> b2cFailedCallback = {
  "Result": {
    "ResultType": 0,
    "ResultCode": 2001,
    "ResultDesc": "The initiator information is invalid.",
    "OriginatorConversationID": "29112-34801843-1",
    "ConversationID": "AG_20191219_00006c6fddb15123addf",
    "TransactionID": "NLJ0000000",
    "ReferenceData": {
      "ReferenceItem": {
        "Key": "QueueTimeoutURL",
        "Value":
            "https:\/\/internalsandbox.safaricom.co.ke\/mpesa\/b2cresults\/v1\/submit"
      }
    }
  }
};
// error
Map<String, dynamic> b2cError = {
  "requestId": "11728-2929992-1",
  "errorCode": "401.002.01",
  "errorMessage":
      "Error Occurred - Invalid Access Token - BJGFGOXv5aZnw90KkA4TDtu4Xdyf"
};

// accept
Map<String, dynamic> default1 = {
  "ConversationID": "AG_20191219_00005797af5d7d75f652",
  "OriginatorConversationID": "16740-34861180-1",
  "ResponseCode": "0",
  "ResponseDescription": "Accept the service request successfully."
};

// reversal
// succes
Map<String, dynamic> reversalSuccess = {
  "OriginatorConversationID": "71840-27539181-07",
  "ConversationID": "AG_20210709_12346c8e6f8858d7b70a",
  "ResponseCode": "0",
  "ResponseDescription": "Accept the service request successfully."
};

// callback
Map<String, dynamic> reversalCallbackSuccess = {
  "Result": {
    "ResultType": 0,
    "ResultCode": 21,
    "ResultDesc": "The service request is processed successfully",
    "OriginatorConversationID": "8521-4298025-1",
    "ConversationID": "AG_20181005_00004d7ee675c0c7ee0b",
    "TransactionID": "MJ561H6X5O",
    "ResultParameters": {
      "ResultParameter": [
        {
          "Key": "DebitAccountBalance",
          "Value": "Utility Account|KES|51661.00|51661.00|0.00|0.00"
        },
        {"Key": "Amount", "Value": 100},
        {"Key": "TransCompletedTime", "Value": 20181005153225},
        {"Key": "OriginalTransactionID", "Value": "MJ551H6X5D"},
        {"Key": "Charge", "Value": 0},
        {"Key": "CreditPartyPublicName", "Value": "254708374149 - John Doe"},
        {"Key": "DebitPartyPublicName", "Value": "601315 - Safaricom1338"}
      ]
    },
    "ReferenceData": {
      "ReferenceItem": {
        "Key": "QueueTimeoutURL",
        "Value":
            "https://internalsandbox.safaricom.co.ke/mpesa/reversalresults/v1/submit"
      }
    }
  }
};

// transaction status
// success
Map<String, dynamic> transactionSuccess = {
  "OriginatorConversationID": "1236-7134259-1",
  "ConversationID": "AG_20210709_1234409f86436c583e3f",
  "ResponseCode": "0",
  "ResponseDescription": "Accept the service request successfully."
};
Map<String, dynamic> transactionSuccessCallback = {
  "Result": {
    "ConversationID": "AG_20180223_0000493344ae97d86f75",
    "OriginatorConversationID": "3213-416199-2",
    "ReferenceData": {
      "ReferenceItem": {"Key": "Occasion"}
    },
    "ResultCode": 0,
    "ResultDesc": "The service request is processed successfully.",
    "ResultParameters": {
      "ResultParameter": [
        {"Key": "DebitPartyName", "Value": "600310 - Safaricom333"},
        {"Key": "CreditPartyName", "Value": "254708374149 - John Doe"},
        {"Key": "OriginatorConversationID", "Value": "3211-416020-3"},
        {"Key": "InitiatedTime", "Value": 20180223054112},
        {"Key": "DebitAccountType", "Value": "Utility Account"},
        {"Key": "DebitPartyCharges", "Value": "Fee For B2C Payment|KES|22.40"},
        {"Key": "TransactionReason"},
        {"Key": "ReasonType", "Value": "Business Payment to Customer via API"},
        {"Key": "TransactionStatus", "Value": "Completed"},
        {"Key": "FinalisedTime", "Value": 20180223054112},
        {"Key": "Amount", "Value": 300},
        {"Key": "ConversationID", "Value": "AG_20180223_000041b09c22e613d6c9"},
        {"Key": "ReceiptNo", "Value": "MBN31H462N"}
      ]
    },
    "ResultType": 0,
    "TransactionID": "MBN0000000"
  }
};

// stkQuery
// success
Map<String, dynamic> stkQuer = {
  "ResponseCode": "0",
  "ResponseDescription": "The service request has been accepted successsfully",
  "MerchantRequestID": "22205-34066-1",
  "CheckoutRequestID": "ws_CO_13012021093521236557",
  "ResultCode": "0",
  "ResultDesc": "The service request is processed successfully."
};

Map<String, dynamic> b2bReceiverError(int value) => {
      "requestId": "11728-2929992-1",
      "errorCode": "401.002.01",
      "errorMessage":
          "The element The value of Request.Identity.ReceiverParty.IdentifierType can not be $value is invalid."
    };

Map<String, dynamic> b2bPrimaryError(int value) => {
      "requestId": "11728-2929992-1",
      "errorCode": "401.002.01",
      "errorMessage":
          "The element The value of Request.Identity.PrimaryParty.IdentifierType can not be $value is invalid."
    };
