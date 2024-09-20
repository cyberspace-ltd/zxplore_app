import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/base_view_widget.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/widgets/empty_view.dart';

class ViewRefreesScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formIndividualData;

  const ViewRefreesScreen({Key? key, required this.formIndividualData})
      : super(key: key);

  @override
  ConsumerState<ViewRefreesScreen> createState() => _ViewRefreesScreenState();
}

class _ViewRefreesScreenState extends ConsumerState<ViewRefreesScreen> {
  @override
  Widget build(BuildContext context) {
    final ViewAccountRequestResponse? requestData =
        ViewAccountRequestResponse.fromMap(widget.formIndividualData);
    final sectionData = requestData?.data?.referees ?? [];

    return BaseFormScreen(
        title: 'Referees',
        data: _flattenData(widget.formIndividualData),
        showEdit: sectionData.isNotEmpty,
        onTapEdit: () {
          // to navigate to edit this section
        },
        onTapAdd: () {
          // rroute to add new item page
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: sectionData.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: sectionData.length,
                  itemBuilder: (BuildContext context, index) {
                    return Item(
                      data: sectionData[index],
                      subRequestId: sectionData[index].refereeId,
                      requestId: requestData?.data?.reqId,
                    );
                  })
              : EmptyViewWidget(),
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

class Item extends StatelessWidget {
  const Item(
      {super.key,
      this.data,
      required this.requestId,
      required this.subRequestId});
  final Referee? data;
  final String? requestId;
  final int? subRequestId;

  @override
  Widget build(BuildContext context) {
    return FoldableItem(
      name: 'Name: ${data?.accountName ?? ''}',
      number: 'Account No ${data?.accountNo??''}',
      requestId: requestId,
      subRequestId: subRequestId,
      onPressed: () {},
      onTapEdit: () {
        /// navigate to the edit initial data page
      },
      onTapView: () {
        /// navigate to the view initial data page
        /// set state to viewing
      },
      request: data,
    );

    //   Column(
    //     children: [
    //   // ViewItem(title: 'Name', value: data?.name??''),
    //   // ViewItem(title: 'Address', value: data?.address??''),
    //   // ViewItem(title: 'Account Name', value: data?.accountName??''),
    //   // ViewItem(title: 'Bankers', value: data?.bankers??''),
    //   // ViewItem(title: 'Account No', value: data?.accountNo??''),
    //  ]);
  }
}
