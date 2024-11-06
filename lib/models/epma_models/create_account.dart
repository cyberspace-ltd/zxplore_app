class CreateAccountData {
    String? surname;
    String? firstName;
    String? otherNames;
    String? genderCode;
    String? birthDate;
    String? citizenshipCode;
    int? identificationTypeId;
    String? identificationNo;
    String? idCountryCode;
    String? idIssueAuthority;
    String? idIssueDate;
    String? idExpiryDate;
    String? niaVerificationNo;
    String? iddCode;
    String? telNo;
    String? mobileNo;
    String? residentialAddress;
    String? residentialAddress2;
    String? city;

    CreateAccountData({
         this.surname,
         this.firstName,
         this.otherNames,
         this.genderCode,
         this.birthDate,
         this.citizenshipCode,
         this.identificationTypeId,
         this.identificationNo,
         this.idCountryCode,
         this.idIssueAuthority,
         this.idIssueDate,
         this.idExpiryDate,
         this.niaVerificationNo,
         this.iddCode,
         this.telNo,
         this.mobileNo,
         this.residentialAddress,
         this.residentialAddress2,
         this.city,
    });
@override
String toString() {
  return 'CreateAccountData('
      'surname: $surname, '
      'firstName: $firstName, '
      'otherNames: $otherNames, '
      'genderCode: $genderCode, '
      'birthDate: $birthDate, '
      'citizenshipCode: $citizenshipCode, '
      'identificationTypeId: $identificationTypeId, '
      'identificationNo: $identificationNo, '
      'idCountryCode: $idCountryCode, '
      'idIssueAuthority: $idIssueAuthority, '
      'idIssueDate: $idIssueDate, '
      'idExpiryDate: $idExpiryDate, '
      'niaVerificationNo: $niaVerificationNo, '
      'iddCode: $iddCode, '
      'telNo: $telNo, '
      'mobileNo: $mobileNo, '
      'residentialAddress: $residentialAddress, '
      'residentialAddress2: $residentialAddress2, '
      'city: $city'
      ')';
}
}
