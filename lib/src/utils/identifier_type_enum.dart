enum IdentifierType { MSISDN, TillNumber, OrganizationShortCode }

extension IdentifierTypeValue on IdentifierType {
  int get value {
    switch (this) {
      case IdentifierType.MSISDN:
        return 1;
      case IdentifierType.TillNumber:
        return 2;
      case IdentifierType.OrganizationShortCode:
        return 4;
      default:
        return 1;
    }
  }

  String get transactionType {
    switch (this) {
      case IdentifierType.TillNumber:
        return 'CustomerBuyGoodsOnline';
      case IdentifierType.OrganizationShortCode:
        return 'CustomerPayBillOnline';
      default:
        return 'CustomerPayBillOnline';
    }
  }
}
