import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/empty_view.dart';

class ViewChildrenScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewChildrenScreen(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewChildrenScreen> createState() =>
      _ViewChildrenScreenState();
}

class _ViewChildrenScreenState
    extends ConsumerState<ViewChildrenScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.children ?? [];

    return BaseFormScreen(
        title: 'Children',
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
  final Child? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//  ViewItem(title: 'Chid Id', value: data?.chidId),
    // ViewItem(title: 'Req Id', value: data?.reqId),
    // ViewItem(title: 'Row Version', value: data?.rowVersion),
    // ViewItem(title: 'Item Stage', value: data?.itemStage),
    ViewItem(title: 'Surname', value: data?.surname??''),
    ViewItem(title: 'Other Names', value: data?.otherNames??''),
    ViewItem(title: 'Birth Date', value: formatDate(data?.birthDate??'')),
    ViewItem(title: 'Gender Code', value: data?.genderCode??''),
    ViewItem(title: 'Country Orig Code', value: data?.countryOrigCode??''),
    ViewItem(title: 'Age', value: data?.age??0),
    ViewItem(title: 'School', value: data?.school??''),
    ViewItem(title: 'Mother Name', value: data?.motherName??''),
    ViewItem(title: 'Maturity Age', value: data?.maturityAge??''),
    ViewItem(title: 'Create Date', value: formatDate(data?.createDate)),
    ViewItem(title: 'Action Flag', value: data?.actionFlag??''),
    ViewItem(title: 'Gender', value: data?.gender?.genderName),
    ViewItem(title: 'Nationality', value: data?.nationality?.countryName??''),
    ViewItem(title: 'Origin Country', value: data?.originCountry?.countryName??''),
  
   ]);
}

 
  
}