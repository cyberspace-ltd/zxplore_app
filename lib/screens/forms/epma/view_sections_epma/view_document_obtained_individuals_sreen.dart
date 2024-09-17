import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/empty_view.dart';

class DocumentsObtainIndividual extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const DocumentsObtainIndividual(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<DocumentsObtainIndividual> createState() =>
      _DocumentsObtainIndividualState();
}

class _DocumentsObtainIndividualState
    extends ConsumerState<DocumentsObtainIndividual> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.documentsObtainedIndividuals ?? [];

    return BaseFormScreen(
        title: 'Documents Obtained',
        data: _flattenData(widget.formIndividualData),
         showEdit: sectionData.isNotEmpty,
        onTapEdit: () {
          // to navigate to edit this section
        },
        onTapAdd: (){
          // rroute to add new item page 
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: sectionData.isNotEmpty? ListView.builder(
              shrinkWrap: true,
              itemCount: sectionData.length,
              itemBuilder: (BuildContext context, index) {
                return Item(data:sectionData[index] ,);
              }):EmptyViewWidget(),
        ));
  }
  Map<String, String> _flattenData(Map<String, dynamic> data) {
    Map<String, String> flattened = {};
    data.forEach((key, value) {
      if (value is Map) {
        value.forEach((subKey, subValue) {
          flattened['$key - $subKey'] = subValue.toString();
        });
      } else {
        flattened[key] = value.toString();
      }
    });
    return flattened;
  }
}

class  Item extends StatelessWidget {
  const Item({super.key, this.data});
  final DocumentsObtainedIndividual? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
 
    ViewItem(title: 'Identification', value: data?.identification ?? ''),
    ViewItem(title: 'Identification Submission Date', value: formatDate(data?.identificationSubmissionDate??'')),
    ViewItem(title: 'Reference Letter', value: data?.referenceLetter?? ''),
    ViewItem(title: 'Reference Letter Submission Date', value: formatDate(data?.referenceLetterSubmissionDate??'')),
    ViewItem(title: 'Passport Photograph', value: data?.passportPhotograph??''),
    ViewItem(title: 'Passport Photograph Submission Date', value: formatDate(data?.passportPhotographSubmissionDate??'')),
    ViewItem(title: 'Mandate Card', value: data?.mandateCard??''),
    ViewItem(title: 'Mandate Card Submission Date', value: formatDate(data?.mandateCardSubmissionDate??'')),
    ViewItem(title: 'Residence Permit', value: data?.residencePermit??''),
    ViewItem(title: 'Residence Permit Submission Date', value: formatDate(data?.residencePermitSubmissionDate??'')),
    ViewItem(title: 'Utility Bill', value: data?.utilityBill??''),
    ViewItem(title: 'Utility Bill Submission Date', value: formatDate(data?.utilityBillSubmissionDate??'')),
    ViewItem(title: 'Location Sketch', value: data?.locationSketch??''),
    ViewItem(title: 'Location Sketch Submission Date', value: formatDate(data?.locationSketchSubmissionDate??'')),
    ViewItem(title: 'Enhance Due Diligence', value: data?.enhanceDueDiligence ?? ''),
    ViewItem(title: 'Enhance Due Diligence Submission Date', value: formatDate(data?.enhanceDueDiligenceSubmissionDate??'')),
    ViewItem(title: 'Attestation', value: data?.attestation ?? ''),
    ViewItem(title: 'Attestation Submission Date', value: formatDate(data?.attestationSubmissionDate??'')),
    ViewItem(title: 'Longroduction Letter', value: data?.longroductionLetter?? ''),
    ViewItem(title: 'Longroduction Letter Submission Date', value: formatDate(data?.longroductionLetterSubmissionDate??'')),
    ViewItem(title: 'Non-Citizen Card', value: data?.nonCitizenCard??'' ),
    ViewItem(title: 'Non-Citizen Card Submission Date', value: formatDate(data?.nonCitizenCardSubmissionDate??'')),
    ViewItem(title: 'Visitation Report', value: data?.visitationReport??''),
    ViewItem(title: 'Visitation Report Submission Date', value: formatDate(data?.visitationReportSubmissionDate??'')),
    ViewItem(title: 'Other Documents Provided', value: data?.otherDocumentsProvided??''),
    ViewItem(title: 'Other Documents Provided Submission Date', value: formatDate(data?.otherDocumentsProvidedSubmissionDate??'')),
    ViewItem(title: 'Other Documents Deferred', value: data?.otherDocumentsDeferred??''),
    ViewItem(title: 'Other Documents Deferred Submission Date', value: formatDate(data?.otherDocumentsDeferredSubmissionDate??'')),
  ]);
}

 
  
}