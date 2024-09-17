import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/empty_view.dart';
// import 'package:zxplore_app/utils/app_sizes.dart';
// import 'package:zxplore_app/utils/string_extentions.dart';

class ViewNextOfKinScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewNextOfKinScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewNextOfKinScreen> createState() =>
      _ViewNextOfKinScreenState();
}

class _ViewNextOfKinScreenState
    extends ConsumerState<ViewNextOfKinScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.nextOfKin ?? [];

    return BaseFormScreen(
        title: 'Next of Kin',
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
          child: sectionData.isNotEmpty?ListView.builder(
              shrinkWrap: true,
              itemCount: sectionData.length,
              itemBuilder: (BuildContext context, index) {
                return Item(data:sectionData[index] ,);
              }):EmptyViewWidget(),
        ));
  }
  Map<String, String> _flattenData(Map<String, dynamic> data) {
    Map<String, String> flattened = {};
    data?.forEach((key, value) {
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
  final NextOfKin? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    ViewItem(title: 'Item Stage', value: data?.itemStage??''),
    ViewItem(title: 'Full Name', value: data?.fullName??''),
    ViewItem(title: 'Tel No', value: data?.telNo??''),
    ViewItem(title: 'Relationship', value: data?.relationship??''),
    ViewItem(title: 'Gender Code', value: data?.genderCode??''),
    ViewItem(title: 'Residential Address', value: data?.residentialAddress??''),
    ViewItem(title: 'Action Flag', value: data?.actionFlag??''),
    ViewItem(title: 'Gender Name', value: data?.gender?.genderName??''),
   ]);
}

 
  
}