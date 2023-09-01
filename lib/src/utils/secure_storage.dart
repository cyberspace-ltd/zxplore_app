import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String tokenKey = "TOKEN";

  static const String employeeIDKey = "EMPLOYEEID";

  static const String branchNumberKey = "BRANCHNUMBER";

  static const String dataInitializerKey = "DATAINITIALIZED";

  static Future saveAgentInformation({
    String? token,
    String? employeeId,
    String? branchNumber,
  }) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: tokenKey, value: token);
    await storage.write(key: employeeIDKey, value: employeeId);
    await storage.write(key: branchNumberKey, value: branchNumber);
  }

  static Future setInitialDataLoaded() async {
    const storage = FlutterSecureStorage();

    await storage.write(key: dataInitializerKey, value: 'Y');
  }

  static Future<String?> getInitialDataLoaded() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: dataInitializerKey);
  }

  static Future<String?> getEmployeeToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: tokenKey);
  }

  static Future<String?> getEmployeeId() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: employeeIDKey);
  }

  static Future<String?> getBranchNumber() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: branchNumberKey);
  }

  static Future clearSecureInformation() async {
    const storage = FlutterSecureStorage();

    await storage.deleteAll();
  }
}
