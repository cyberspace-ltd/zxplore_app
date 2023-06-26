class Endpoints {
  static const googleKey = 'AIzaSyCUECofQTpcRO46CnOHL1q4bmKH8dvmIyA';
// cyb env
  static const String GATEWAY_BASE_API_URL = 'http://41.138.171.45:8190/api/';

  // Ghana Test Environment
//  static const String GATEWAY_BASE_API_URL =
//      'https://zxploretest.zenithbank.com.gh/ZxploreGhanaAPIV6/api/';

  static String getOccupationUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/Occupations';
  }

  static String getAccountClassesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/AccountClass';
  }

  static String getTitlesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/Titles';
  }

  static String getStatesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/States';
  }

  static String getCountriesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/Countries';
  }

  static String getCitiesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/Cities';
  }

  static String getCardTypesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/CardTypes';
  }

  static String getLoginUrl() {
    return '$GATEWAY_BASE_API_URL'
        'Security/authUser';
  }

  static String getAccountsByRsmIdUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/GetAccountsByRsmID/';
  }

  static String getVerifyAccountsByRefIdUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/VerifyReferenceID/';
  }

  static String getSaveAccountsUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/SaveAccount/';
  }

  static String getBvnUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/VerifySingleBVN/';
  }

  static String getVerifyDriverLicenceUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/VerifyDriverLicense/';
  }

  static String getVerifyIdUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/Verify/';
  }

  static String getVerifyPassportUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/VerifyPassport/';
  }

  static String getVerifyVotersUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/VerifyVoter/';
  }

  static String getAccountDetailsUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/GetAccountByRefID/';
  }

  static String getPlaces(String placeName) {
    return 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input= $placeName&components=country:Gh&key=$googleKey';
  }

  static String getEmploymentTypesUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/EmploymentTypes';
  }

  static String getMonthlyAllowanceUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/MonthlyIncomes';
  }

  static String getPurposeOfAcctUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/AccountPurposes';
  }

  static String getSourceOfFundUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/SourceOfFunds';
  }

  static String getTransactionTypeUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/TransactionTypes';
  }

  static String getNoOfTransactionUrl() {
    return '$GATEWAY_BASE_API_URL'
        'accounts/TransactionCounts';
  }
}
