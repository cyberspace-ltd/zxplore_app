abstract class MetaRepository {
  Future<dynamic> getCountries();
  Future<dynamic> getGenders();
  Future<dynamic> getIdentificationTypes();
  Future<dynamic> getAccoutTypes();
  Future<dynamic> getReconStatus();
  Future<dynamic> getAccountSeries({required String? requestId,required String? accountType});
  Future<dynamic> getAccountClass(      {
      required String? requestId,
      required String? accountType,
    required String? seriesCode});
  Future<dynamic> getBusinessNatures();
  Future<dynamic> getCustomerClassification();
  Future<dynamic> getEmployTypes();
  Future<dynamic> getRegions();
  Future<dynamic> getMaritalStatus();
  Future<dynamic> getSubBusinessNatures({required int? businessNatureId});
  Future<dynamic> getAnticipatedAmounts();
  Future<dynamic> getAnticipatedTransactions();
  Future<dynamic> getFatcaStatus();
  Future<dynamic> getDocumentTypes();
  Future<dynamic> getSearchOptions();



}