# dart_mpesa
<a href="https://www.buymeacoffee.com/EddieGenius" target="_blank"><img src="https://i.imgur.com/aV6DDA7.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important; box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" > </a>

This library contains methods that make it easy to consume Mpesa Api. It's multi-platform, and supports CLI, server, mobile, desktop, and the browser.

Ready Methods/APIs include
- [x] LIPA NA MPESA
- [x] STKPUSH QUERY
- [x] C2BSIMULATE
- [x] B2B
- [x] B2C
- [x] C2B
- [x] TRANSACTION STATUS
- [x] ACCOUNT BALANCE
- [x] REVERSAL

## Usage

Create an instance of Mpesa, then use its methods to consume the Api

```dart
import 'package:dart_mpesa/dart_mpesa.dart';

main() {
  var mpesa = Mpesa(
    shortCode: "",
    consumerKey: "",
    consumerSecret: "",
    initiatorName: "",
    securityCredential: "",
    passKey: "",
    identifierType: IdentifierType.OrganizationShortCode, // Type of organization, options, OrganizationShortCode, TillNumber, OrganizationShortCode
    applicationMode: ApplicationMode.test
  );
}
```

### lipa na mpesa online

LIPA NA M-PESA ONLINE API also know as M-PESA express (STK Push) is a Merchant/Business initiated C2B (Customer to Business) Payment.

```dart
  MpesaResponse _res = await mpesa.lipanaMpesaOnline(
    phoneNumber: "",
    amount: 0,
    accountReference: "",
    transactionDesc: "",
    callBackURL: "", 
  );

  print(_res.statusCode);
  print(_res.rawResponse);
  print(_res.responseDescription);
```

### B2B
The Business to Business (B2B) API is used to transfer money from one business to another business.
```dart
  _res = await mpesa.b2bTransaction(
    shortCode: "",
    amount: 0,
    remarks: "",
    accountReference: "", // optional
    resultURL: "", 
    queueTimeOutURL: "",
    identifierType: IdentifierType.OrganizationShortCode, // options, OrganizationShortCode, TillNumber, OrganizationShortCode
    commandID: BbCommandId.BusinessToBusinessTransfer, // options, BusinessToBusinessTransfer, BusinessPayBill, BusinessBuyGoods, DisburseFundsToBusiness, MerchantToMerchantTransfer
  );
```

### B2B buy goods
 A transfer of funds from one Organization's Working Account to another Organization's Merchant Account.
```dart
  _res = await mpesa.b2bBuyGoodsTransaction(
    shortCode: "",
    amount: 0,
    remarks: "",
    resultURL: "", 
    queueTimeOutURL: "",
  );
```

### fetch token
```dart
  try{
    _res = await mpesa.fetchToken;
    print(_res['token'])
  }catch(e){
    print(e)
  }
```

See examples or docs for more
