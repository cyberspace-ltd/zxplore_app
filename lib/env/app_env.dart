/// The Application Enivronment
class AppEnv {
  /// encrypt key
  static const String encryptKey = String.fromEnvironment(
    'ENCRYPT_KEY',
    defaultValue: 'CYBER400SPACE',
  );

  /// initialising vector key
  static const String initialisingVectorKey = String.fromEnvironment(
    'INITIALISING_VECTOR_KEY',
    defaultValue: 'f7431c8d00b85a6d',
  );

  /// base url
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://zenorms.zenithbank.com:8443/api',
  );
}

// static const String GATEWAY_BASE_API_URL =
//     "https://41.203.113.10:8443/api/"; // Old Live Environment