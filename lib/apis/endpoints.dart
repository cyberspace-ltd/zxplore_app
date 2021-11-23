class Endpoints {
  // static const String ZENITH_API_BASE_URL = "https://webservicestest.zenithbank.com:8443/ZenithAccountService/api/";

  static const String GATEWAY_BASE_API_URL = "http://41.138.171.45/zxploreghanaapi/api/";

  // static const String GATEWAY_BASE_API_URL = "https://aspd.zenithbank.com.gh/ZxploreGhanaAPI/api/"; //Live Environment
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
}
