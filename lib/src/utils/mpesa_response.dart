class MpesaResponse {
  MpesaResponse.fromMap(this.statusCode, this.rawResponse) {
    responseCode = int.tryParse(rawResponse['ResponseCode'] ?? "");
    responseDescription = rawResponse['ResponseDescription'];
    conversationID = rawResponse['ConversationID'];
    originatorConversationID = rawResponse['OriginatorConversationID'];

    // stk, stk query
    merchantRequestID = rawResponse['MerchantRequestID'];
    checkoutRequestID = rawResponse['CheckoutRequestID'];

    // stk
    customerMessage = rawResponse['CustomerMessage'];

    // stk query
    resultCode = rawResponse['ResultCode'];
    resultDesc = rawResponse['ResultDesc'];

    // error
    requestId = rawResponse[''];
    errorCode = rawResponse[''];
    errorMessage = rawResponse[''];
  }

  // from http response
  int statusCode;
  // from http response
  Map<String, dynamic> rawResponse = {};

  /// This is a global unique Identifier for any submitted payment request.
  String? merchantRequestID;

  /// This is a global unique identifier of the processed checkout transaction request.
  String? checkoutRequestID;

  /// Response description is an acknowledgment message from the API that gives the status of the request submission usually maps to a specific ResponseCode value. It can be a Success submission message or an error description.
  String? responseDescription;

  /// This is a Numeric status code that indicates the status of the transaction submission. 0 means successful submission and any other code means an error occurred.
  int? responseCode;

  /// This is a message that your system can display to the Customer as an acknowledgement of the payment request submission.
  String? customerMessage;

  /// For every unique request made to M-PESA, a new ConversationID is generated and returned in the response. This ConversationID carries the response from M-PESA.
  String? conversationID;

  /// The unique identifier of the transaction request, the purpose of this identifier is to track the transaction request.
  // String? originatorCoversationID;

  /// This is a global unique identifier for the transaction request returned by the API proxy upon successful request submission.
  String? originatorConversationID;

  // stk query
  String? resultCode;
  String? resultDesc;

  // error
  /// This is a unique requestID for the payment request
  String? requestId;

  /// This is a predefined code that indicates the reason for request failure. This are defined in the Response Error Details below. The error codes maps to specific error message
  String? errorCode;

  /// This is a short descriptive message of the failure reason.
  String? errorMessage;
}
