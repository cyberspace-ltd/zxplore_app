import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_duedelligience_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';

class ViewDueDilligience extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewDueDilligience(
      {Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewDueDilligience> createState() =>
      _ViewDueDilligienceState();
}

class _ViewDueDilligienceState
    extends ConsumerState<ViewDueDilligience> {
  @override
  Widget build(BuildContext context) {
       final ViewAccountRequestResponse? requestData =  ref.watch(activelyViewedRequestProvider);
final sectionData = requestData?.data?.dueDiligences ?? [];

    return BaseFormScreen(
        title: 'Due Diligence(s)',
        data: _flattenData(widget.formIndividualData),
        onTapEdit: () {
             // to navigate to edit this section
         ref.read(editDueDilligienceControllerProvider.notifier).getEditData(context,
          RequestId: requestData?.data?.reqId??'');
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: sectionData.length,
              itemBuilder: (BuildContext context, index) {
                return Item(data:sectionData[index] ,);
              }),
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
  final DueDiligence? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    ViewItem(title: 'Fatca Status', value: data?.fatcaStatus??''),
   ]);
}

 
  
}