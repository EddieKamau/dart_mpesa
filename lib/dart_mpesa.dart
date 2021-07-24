/// Support for doing something awesome.
///
/// More dartdocs go here.
library dart_mpesa;


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

  String? initiatorName;
  String? securityCredential;
  
  String? passKey;
  
}

enum ApplicationMode{
  test, production
}