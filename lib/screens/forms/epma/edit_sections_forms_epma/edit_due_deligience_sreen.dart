import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/edit_duedeligience.dart';
import 'package:zxplore_app/models/epma_models/get_due_delligience_to_edit.dart';
import 'package:zxplore_app/models/epma_models/meta/fatca_status_response.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/edit_duedelligience_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/meta/fatca_status.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_due_deligience_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditDueDilligienceScreen extends ConsumerStatefulWidget {
  const EditDueDilligienceScreen({super.key,this.data});
  final GetDueDiligenceToEdit?  data;

  @override
  ConsumerState<EditDueDilligienceScreen> createState() => _EditDueDilligienceScreenState();
}

class _EditDueDilligienceScreenState extends ConsumerState<EditDueDilligienceScreen> {
  FatcaStatusDatum? selectedFatcaStatusItem;
 String? fatcaStatusValue;
    String? fatcaStatusName;
  
 Future <void> _submitForm(BuildContext context) async {
  final userData  = widget.data?.data;
    ref.read(editDueDilligienceControllerProvider.notifier).editDueDilligience(data: EditDueDiligence(
      actionFlag: userData?.actionFlag??'',
      dueDiligenceId:userData?.dueDiligenceId??-1 ,
      fatcaStatus:fatcaStatusName??'' ,
      requestId: userData?.reqId??'',
      rowVersion:userData?.rowVersion??-1 ,

    ), context: context);
  }

  @override
  Widget build(BuildContext context) {

         ref.listen<AsyncValue>(
      getFatcaStatusProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(getFatcaStatusProvider).isLoading||
      ref.watch(viewRequestControllerProvider).isLoading||
      ref.watch(editDueDilligienceControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Editing Due Dilligience',
        widgetToGoOnCancel: ViewDueDilligience(formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap(),),

        onCancel: (){},
        data: {},
        child:  SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: Column(children: [
                  gapH16,
                      Text(
                      'Fatca Status',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    div,
                    Text(
                      '',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Consumer(
                      builder: (context, ref, child) {
                        return ref.watch(getFatcaStatusProvider).when(
                              data: (data) => (data != null &&
                                      data.isNotEmpty == true)
                                  ? DropdownButtonHideUnderline(
                                      child: DropdownButton2<
                                          FatcaStatusDatum>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select status',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                            color: ZxplorePrimaryColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: data
                                            .map<
                                                    DropdownMenuItem<
                                                        FatcaStatusDatum>>(
                                                (item) => DropdownMenuItem<
                                                        FatcaStatusDatum>(
                                                      value: item,
                                                      child: Text(
                                                        '${item.fatcaStatusName}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              ZxplorePrimaryColor,
                                                        ),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ))
                                            .toList(),
                                        value: selectedFatcaStatusItem,
                                        onChanged:
                                            (FatcaStatusDatum? newValue) {
                                          setState(() {
                                            /// Set selected item params
                                            selectedFatcaStatusItem = newValue;
                                            fatcaStatusName =
                                                newValue?.fatcaStatusName;
                                            fatcaStatusValue =
                                                newValue?.fatcaStatusValue;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 60,
                                          // width: 160,
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: ZxplorePrimaryColor,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            CupertinoIcons.chevron_down,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor: ZxplorePrimaryColor,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          // offset: const Offset(0, 0),
                                          scrollbarTheme:
                                              const ScrollbarThemeData(
                                            radius: Radius.circular(40),
                                            thickness:
                                                WidgetStatePropertyAll<double>(6),
                                            thumbVisibility:
                                                WidgetStatePropertyAll<bool>(
                                                    true),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 40,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14),
                                        ),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () => ref.invalidate(
                                          getFatcaStatusProvider),
                                      child: Text('Empty data, Tap to retry')),
                              error: (e, s) => GestureDetector(
                                  onTap: () => ref
                                      .invalidate(getFatcaStatusProvider),
                                  child: const Text(
                                    'An error occured',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              loading: () => SizedBox(height: 16.0),
                            );
                      },
                    ),
                        const SizedBox(height: 24),
                  PrimaryButton(
                      onPressed: () {
                       
                        if (selectedFatcaStatusItem == null) {return;};

                        /// perform trn if all is well
                        _submitForm(context);
                      },
                      title: 'Save')
          ],),),
        ) 
      ),
    );
  }
}
