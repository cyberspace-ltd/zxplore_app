import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_personal_details_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_section_screen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class ViewInitialCreationInfoScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewInitialCreationInfoScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewInitialCreationInfoScreen> createState() =>
      _ViewInitialCreationInfoScreenState();
}

class _ViewInitialCreationInfoScreenState
    extends ConsumerState<ViewInitialCreationInfoScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      viewPersonalDetailsControllerProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {},errorMsg: state.error),
    );


    final ViewAccountRequestResponse? requestData =
        ref.watch(activelyViewedRequestProvider);
    final sectionData = requestData?.data?.formIndividual ?? [];

    return ZxploreProgress(
      inAsyncCall: ref.watch(viewPersonalDetailsControllerProvider).isLoading,
      child: BaseFormScreen(
          showHomeIcon: false,
          title: 'Form Individual',
          data: _flattenData(widget.formIndividualData),
          onTapSectionMenu: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SectionScreen()),
            );
          },
          onTapEdit: () {
            // to navigate to edit this section
            ref
                .read(viewPersonalDetailsControllerProvider.notifier)
                .getEditData(context,
                    RequestId: requestData?.data?.reqId ?? '');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: sectionData.length,
                itemBuilder: (BuildContext context, index) {
                  return FormIndividualItem(
                    data: sectionData[index],
                  );
                }),
          )),
    );
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

class FormIndividualItem extends StatelessWidget {
  const FormIndividualItem({super.key, this.data});
  final FormIndividual? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewItem(
          title: 'Full name',
          value: data?.fullName ?? '',
        ),
        ViewItem(
          title: 'Email',
          value: data?.emailAddress ?? '',
        ),
        ViewItem(
          title: 'Mobile',
          value: data?.mobileNo ?? '',
        ),
        ViewItem(
          title: 'Telephone',
          value: data?.telNo ?? '',
        ),
        ViewItem(
          title: 'Marital Satus',
          value: data?.maritalStatus ?? '',
        ),
        ViewItem(
          title: 'Spouse',
          value: data?.spouseName ?? '',
        ),
        ViewItem(
          title: 'Spouse occupation',
          value: data?.spouseOccupation ?? '',
        ),
        ViewItem(
          title: 'Business',
          value: data?.businessNature?.businessNatureName ?? '',
        ),
        ViewItem(
          title: 'Sub-Business Category',
          value: data?.subBusinessNature?.subBusinessNatureName ?? '',
        ),
        ViewItem(
          title: 'Eployer Name',
          value: data?.employerName ?? '',
        ),
        ViewItem(
          title: 'Eployer Email',
          value: data?.employerEmail ?? '',
        ),
        ViewItem(
          title: 'Eployer Tel.',
          value: data?.employerTel ?? '',
        ),
        ViewItem(
          title: 'Eployer Type',
          value: data?.employmentType?.employmentTypeName ?? '',
        ),
        ViewItem(
          title: 'Account Creation Stage',
          value: data?.itemStage ?? '',
        ),
        ViewItem(
          title: 'DOB',
          value: formatDate(data?.birthDate ?? ''),
        ),
        ViewItem(
          title: 'Gender',
          value: data?.gender?.genderName ?? '',
        ),
        ViewItem(
          title: 'Birth place',
          value: data?.birthPlace ?? '',
        ),
          ViewItem(
          title: 'GPS-Address',
          value: data?.gpsAddress ?? '',
        ),
        ViewItem(
          title: 'ID Number',
          value: data?.identificationNo ?? '',
        ),
        ViewItem(
          title: 'Country',
          value: data?.country?.countryName ?? '',
        ),
        ViewItem(
          title: 'Citizenship',
          value: data?.country?.countryName ?? '',
        ),
        ViewItem(
          title: 'Country',
          value: data?.country?.countryName ?? '',
        ),
        ViewItem(
          title: 'ID Type',
          value: data?.identificationType?.identificationTypeName ?? '',
        ),
        ViewItem(
          title: 'ID Issuer',
          value: data?.idIssueAuthority ?? '',
        ),
        ViewItem(
          title: 'ID Issue Date',
          value: data?.idIssueDate ?? '',
        ),
        ViewItem(
          title: 'ID Expiry Date',
          value: data?.idExpiryDate ?? '',
        ),
        ViewItem(
          title: 'IDD Code',
          value: data?.iddCode ?? '',
        ),
        ViewItem(
          title: 'NIA',
          value: data?.niaVerificationNo ?? '',
        ),
        ViewItem(
          title: 'Home Town',
          value: data?.homeTown ?? '',
        ),
        ViewItem(
          title: 'Permanent Address',
          value: data?.hasPermanentResidence ?? '',
        ),
        ViewItem(
          title: 'Residential Address 1',
          value: data?.residentialAddress ?? '',
        ),
        ViewItem(
          title: 'Residential Address 2',
          value: data?.residentialAddress2 ?? '',
        ),
        ViewItem(
          title: 'City',
          value: data?.country?.countryName ?? '',
        ),
        ViewItem(
          title: 'Customer Classification',
          value: data?.customerClassification?.customerClassificationId ?? '',
        ),
        ViewItem(
          title: 'Resides in GH',
          value: data?.customerResidentInGhana ?? false,
        ),
        ViewItem(
          title: 'Physically Challenged',
          value: data?.isPhysicallyChallanged ?? false,
        ),
        ViewItem(
          title: 'Customer is PEP',
          value: data?.customerIsPep ?? false,
        ),
        ViewItem(
          title: 'Email Indemnity',
          value: data?.setupEmailIndemnity ?? false,
        ),
        ViewItem(
          title: 'Statement to Email',
          value: data?.setupStatementViaEmail ?? false,
        ),
        ViewItem(
          title: 'Customer on ZPrompt',
          value: data?.setupZPrompt ?? false,
        ),
        ViewItem(
          title: 'Customer on IBank',
          value: data?.setupIbank ?? false,
        ),
        ViewItem(
          title: 'Account Ownership',
          value: data?.setupIbank ?? false,
        ),
        ViewItem(
          title: 'Monthly Income',
          value: data?.monthlyIncome ?? 0.0,
        ),
      ],
    );
  }
}

class ViewItem extends StatelessWidget {
  const ViewItem({super.key, required this.title, this.value});
  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return Card(
      color: brightness == Brightness.light? Color(0xfff0eeee):ZxplorePrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            Wrap(
              children: [
                Text(
                  '$value',
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.normal, fontSize: 16),
                ),
              ],
            ),
            gapH12
          ],
        ),
      ),
    );
  }
}
