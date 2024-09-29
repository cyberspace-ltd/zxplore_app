import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/delete_stake_holder.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_stake_holders_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/widgets/empty_view.dart';

class StackHolderdersScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const StackHolderdersScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<StackHolderdersScreen> createState() =>
      _StackHolderdersScreenState();
}

class _StackHolderdersScreenState
    extends ConsumerState<StackHolderdersScreen> {
  @override
  Widget build(BuildContext context) {
       final ViewAccountRequestResponse? requestData =  ref.watch(activelyViewedRequestProvider);
 final sectionData = requestData?.data?.stakeHolders ?? [];

    return BaseFormScreen(
        title: 'Stack Holders',
        data: _flattenData(widget.formIndividualData),
        showEdit:false,// sectionData.isNotEmpty,
        onTapEdit: () {
          // to navigate to edit this section
        },
          onTapAdd: (){
          // rroute to add new item page 
        },
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:sectionData.isNotEmpty? ListView.builder(
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

class  Item extends ConsumerWidget {
  const Item({super.key, this.data});
  final StakeHolder? data;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return 
    FoldableItem(
      name: 'Name: ${data?.firstName ?? ''} ${data?.lastName ?? ''}',
      number: 'Phone: ${data?.businessPhoneNo ?? ''}\n\nEmail: ${data?.emailAddress ?? ''}\n',
      requestId: data?.reqId,
      subRequestId: data?.stakeHolderId,
      onTapEdit: () {
        // to navigate to edit this section
        ref.read(editStakeHoldersControllerProvider.notifier).getEditData(context,
            RequestId: data?.reqId ?? '',);
      },
      onTapView: () {},
      onTapDelete: () {
        ref.read(editStakeHoldersControllerProvider.notifier).deleteStakeHolder(context,
            RequestId: data?.reqId ?? '',
            delData: DeleteStakeHolder(
              stakeHolderId: data?.stakeHolderId,
              requestId: data?.reqId,
              rowVersion: data?.rowVersion,
            ));
      },
      request: data,
    );
  //   Column(
  //     children: [

  //   // ViewItem(title: 'Stake Holder Id', value: data?.stakeHolderId),
  //   // ViewItem(title: 'Req Id', value: data?.reqId),
  //   // ViewItem(title: 'Row Version', value: data?.rowVersion),
  //   // ViewItem(title: 'Item Stage', value: data?.itemStage),
  //   ViewItem(title: 'Rim No', value: data?.rimNo??0),
  //   ViewItem(title: 'First Name', value: data?.firstName??''),
  //   ViewItem(title: 'Middle Name', value: data?.middleName),
  //   ViewItem(title: 'Last Name', value: data?.lastName),
  //   ViewItem(title: 'Other Name', value: data?.otherName),
  //   ViewItem(title: 'Mother Name', value: data?.motherName),
  //   ViewItem(title: 'Birth Date', value: formatDate(data?.birthDate)),
  //   ViewItem(title: 'Birth Place', value: data?.birthPlace),
  //   ViewItem(title: 'Gender Code', value: data?.genderCode),
  //   ViewItem(title: 'Identification Type Id', value: data?.identificationTypeId),
  //   ViewItem(title: 'Identification No', value: data?.identificationNo),
  //   ViewItem(title: 'ID Country Code', value: data?.idCountryCode),
  //   ViewItem(title: 'ID Issue Authority', value: data?.idIssueAuthority),
  //   ViewItem(title: 'ID Issue Date', value: formatDate(data?.idIssueDate)),
  //   ViewItem(title: 'ID Expiry Date', value: formatDate(data?.idExpiryDate??'')),
  //   ViewItem(title: 'NIA Verification No', value: data?.niaVerificationNo),
  //   ViewItem(title: 'Has Permanent Residence', value: data?.hasPermanentResidence??false),
  //   ViewItem(title: 'Residence Permit No', value: data?.residencePermitNo??''),
  //   ViewItem(title: 'Residence Permit Place Code', value: data?.residencePermitPlaceCode??''),
  //   ViewItem(title: 'Residence Permit Issue Date', value: formatDate(data?.residencePermitIssueDate??'')),
  //   ViewItem(title: 'Residence Permit Expiry Date', value: formatDate(data?.residencePermitExpiryDate??'')),
  //   ViewItem(title: 'Country Code', value: data?.countryCode??''),
  //   ViewItem(title: 'Home Town', value: data?.homeTown??''),
  //   ViewItem(title: 'Occupation', value: data?.occupation??''),
  //   ViewItem(title: 'Job Title', value: data?.jobTitle??''),
  //   ViewItem(title: 'Residential Address', value: data?.residentialAddress??''),
  //   ViewItem(title: 'Residential Address 2', value: data?.residentialAddress2??''),
  //   ViewItem(title: 'Region Code', value: data?.regionCode??''),
  //   ViewItem(title: 'City', value: data?.city??''),
  //   ViewItem(title: 'Permanent Residential Address', value: data?.permanentResidentialAddress??''),
  //   ViewItem(title: 'Permanent Residential Country Code', value: data?.permanentResidentialCountryCode??''),
  //   ViewItem(title: 'Permanent Residential City', value: data?.permanentResidentialCity??''),
  //   ViewItem(title: 'District Assembly Area', value: data?.districtAssemblyArea??''),
  //   ViewItem(title: 'Business Phone No', value: data?.businessPhoneNo??''),
  //   ViewItem(title: 'Email Address', value: data?.emailAddress??''),
  //   ViewItem(title: 'Is Director', value: data?.isDirector??false),
  //   ViewItem(title: 'Is Signatory', value: data?.isSignatory??false),
  //   ViewItem(title: 'Is Principal Officer', value: data?.isPrincipalOfficer??false),
  //   ViewItem(title: 'Rel Auth Code', value: data?.relAuthCode??0),
  //   // ViewItem(title: 'Action Flag', value: data?.actionFlag),
  //   ViewItem(title: 'TIN', value: data?.tin??''),
  //   ViewItem(title: 'Setup Z Prompt', value: data?.setupZPrompt??false),
  //   ViewItem(title: 'Setup Statement Via Email', value: data?.setupStatementViaEmail??false),
  //   ViewItem(title: 'Setup Email Indemnity', value: data?.setupEmailIndemnity??false),
  //   ViewItem(title: 'Is New Request', value: data?.isNewRequest??false),
  //   ViewItem(title: 'Identification Type', value: data?.identificationType?.identificationTypeName??''),
  //   ViewItem(title: 'Country', value: data?.country?.countryName??''),
  //   ViewItem(title: 'Gender', value: data?.gender?.genderName??''),
  //   ViewItem(title: 'Region', value: data?.region?.regionName??''),
  //   ViewItem(title: 'Permanent Residence Country', value: data?.permanentResidenceCountry?.countryName??''),
  //   ViewItem(title: 'ID Country', value: data?.idCountry?.countryName??''),
  //   ViewItem(title: 'GPS Address', value: data?.gpsAddress??''),

  
  //  ]);
}

 
  
}

String kformattedDate(DateTime date) {
  return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}';
}