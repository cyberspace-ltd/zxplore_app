import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/empty_view.dart';

class ViewProductServicesScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> requestData;

  const ViewProductServicesScreen(
      {Key? key, required this.requestData})
      : super(key: key);

  @override
  ConsumerState<ViewProductServicesScreen> createState() =>
      _ViewProductServicesScreenState();
}

class _ViewProductServicesScreenState
    extends ConsumerState<ViewProductServicesScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.requestData);
    final sectionData = requestData?.data?.productsServices ?? [];

    return BaseFormScreen(
        title: 'Product Services',
        data: _flattenData(widget.requestData),
         showEdit: sectionData.isNotEmpty,
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
                return ProductServicesItem(data:sectionData[index] ,);
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

class ProductServicesItem extends StatelessWidget {
  const ProductServicesItem({super.key, this.data});
  final ProductsService? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ViewItem(title: 'Customer on EasyPay',value: data?.easyPay??false,),
       ViewItem(title: 'Email notification',value: data?.emailNotification??false,),
       ViewItem(title: 'Internet Banking',value: data?.internetBanking??false,),
       ViewItem(title: 'Master Card',value: data?.masterCard??false,),
       ViewItem(title: 'VISA Card',value: data?.visaCard??false,),
       ViewItem(title: 'Sms Banking',value: data?.smsBanking??false,),
      ],
    );
  }
}