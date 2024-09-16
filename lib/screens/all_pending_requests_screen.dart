import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/selected_request_provider.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/pending_requests_all_controller.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class AllPendingRequestsScreen extends ConsumerStatefulWidget {
  const AllPendingRequestsScreen({super.key});

  @override
  ConsumerState<AllPendingRequestsScreen> createState() =>
      _AllPendingRequestsScreenState();
}

class _AllPendingRequestsScreenState
    extends ConsumerState<AllPendingRequestsScreen> {
  final TextEditingController _filterController = TextEditingController();
  List<PendingRequestsDatum>? _filteredItems;

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  void _filterBillers(String query, List<PendingRequestsDatum> requestItems) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = requestItems;
      } else {
        _filteredItems = requestItems
            .where((category) =>
                category.branch?.toLowerCase().contains(query.toLowerCase()) ==
                    true ||
                category.fullName
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ==
                    true)
            .toList();
      }
    });
  }

 

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      getPendingRequestsAllDatumProvider,
      (_, state) => state.showAlertDialogOnError(context,okAction: (){

      }),
    );
    ref.listen<AsyncValue>(
      getPendingRequestsAllDatumProvider,
      (_, state) {
        if (state.value == AsyncLoading) {
          // showMaterialModalBottomSheet(
          //   context: context,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   backgroundColor: AppColors.white,
          //   builder: (context) {
          //     return const Center(
          //       child: CustomProgressIndicator(),
          //     );
          //   },
          // );
        }
      },
    );

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(getPendingRequestsAllDatumProvider),
      child: ZxploreProgress(
        inAsyncCall: ref.watch(getPendingRequestsAllDatumProvider).isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ZxplorePrimaryColor,
            automaticallyImplyLeading: true,
            // Don't show the leading button
            centerTitle: true,
            // leading: Container(),
            title: const Text(
              'Zxplore Ghana',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
            child: ListView(
              children: [
              
                Text(
                  'All Requests',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
               
                CustomTextFormField(
                  fillColor: Colors.transparent,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ZxplorePrimaryColor,
                  ),
                  title: '',
                  hint: 'Search',
                  inputType: TextInputType.text,
                  controller: _filterController,
                  useDefaultErrorText: false,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (query) {
                    final requestItemsAsyncValue =
                        ref.watch(getPendingRequestsAllDatumProvider);
                    requestItemsAsyncValue.whenData((requestItems) {
                      _filterBillers(query, requestItems ?? []);
                    });
                  },
                ),
                gapH16,
                Consumer(
                  builder: (context, watch, child) {
                    final requestItemsAsyncValue = ref.watch(
                      getPendingRequestsAllDatumProvider,
                    );
                    return requestItemsAsyncValue.when(
                      data: (requestItems) {
                        if (requestItems == null || requestItems.isEmpty) {
                          return const Center(child: Text('No items available.'));
                        }
                        final requestsToShow = _filteredItems ?? requestItems;
                        return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox.shrink(),
                          physics: const BouncingScrollPhysics(),
                          itemCount: requestsToShow.length,
                          itemBuilder: (context, index) {
                            final item = requestsToShow[index];
            
                            return AccountRequestItem(
                              onPressed: () {},
                                   onTapEdit: (){
                                ref.read(combinedFormStateProvider.notifier ).updateState(RequestState.EDITING, SelectedFormSection.initial);
                                ref.read(latestSelectAccountRequestProvider.notifier).update((val)=>item);
                                /// navigate to the edit initial data page
                              },
                              onTapView: (){
                                /// navigate to the view initial data page
                                /// set state to viewing
                                ref.read(combinedFormStateProvider.notifier ).updateState(RequestState.VIEWING, SelectedFormSection.initial);
                                ref.read(latestSelectAccountRequestProvider.notifier).update((val)=>item);
                              },
                              request: item,
                            );
                          },
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (error, stackTrace) =>
                          Center(child: Text('Error: $error')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountRequestItem extends StatelessWidget {
  const AccountRequestItem({super.key, this.request,  this.onPressed,required this.onTapEdit,required this.onTapView});
  final PendingRequestsDatum? request;
  final Function()? onPressed;
  final Function()? onTapEdit;
  final Function()? onTapView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 4,
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request?.fullName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: request?.stage?.toLowerCase()=='draft'?Colors.purpleAccent:request?.stage?.toLowerCase()=='pending posting'?Colors.yellow:Colors.green
                      ),
                      PopupMenuButton<int>(itemBuilder: (BuildContext context){
                        return <PopupMenuEntry<int>>[
                          PopupMenuItem<int>(
                            value: 0,
                            child: GestureDetector(
                              onTap: onTapView,
                              child: Text('View'))),
                              PopupMenuItem<int>(
                            value: 1,
                            child: GestureDetector(
                              onTap: onTapEdit,
                              child: Text('Edit')))

                        ];
                      })
                    ],
                  ),
                )
              ],
            ),
            gapH4,
            Row(
              children: [
                Text(
                  'Branch: ${request?.branch ?? ''}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Started on:${getDayDateAndYear(request?.createDate.toIso8601String() ?? '')}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
