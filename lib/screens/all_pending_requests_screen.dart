import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/selected_request_provider.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/pending_requests_all_controller.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/view_request_controller.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
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

  Future<void> getSelectedRequestDetails(String? requestId) async {
    final requestResponse = await ref
        .read(viewRequestControllerProvider.notifier)
        .getRequestDetailAsync(requestId!);

    if (requestResponse != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ViewInitialCreationInfoScreen(
                  formIndividualData: requestResponse.toMap(),
                )),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      getPendingRequestsAllDatumProvider,
      (_, state) => state.showAlertDialogOnError(context, okAction: () {}),
    );
    ref.listen<AsyncValue>(
        viewRequestControllerProvider,
        (_, state) => state.showAlertDialogOnError(
              context,
              errorMsg: state.error,
              okAction: () {
                getSelectedRequestDetails(
                    ref.read(latestSelectRequestProvider)?.reqId!);
              },
              cancelAction: () => Navigator.pop(context),
            ));
    // ref.listen<AsyncValue>(
    //   getPendingRequestsAllDatumProvider,
    //   (_, state) {
    //     if (state.value == AsyncLoading) {
    //       // showMaterialModalBottomSheet(
    //       //   context: context,
    //       //   shape: RoundedRectangleBorder(
    //       //     borderRadius: BorderRadius.circular(30),
    //       //   ),
    //       //   backgroundColor: AppColors.white,
    //       //   builder: (context) {
    //       //     return const Center(
    //       //       child: CustomProgressIndicator(),
    //       //     );
    //       //   },
    //       // );
    //     }
    //   },
    // );

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(getPendingRequestsAllDatumProvider),
      child: ZxploreProgress(
        inAsyncCall: ref.watch(getPendingRequestsAllDatumProvider).isLoading ||
            ref.watch(viewRequestControllerProvider).isLoading,
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
                gapH24,
                Consumer(
                  builder: (context, watch, child) {
                    final requestItemsAsyncValue = ref.watch(
                      getPendingRequestsAllDatumProvider,
                    );
                    return requestItemsAsyncValue.when(
                      data: (requestItems) {
                        if (requestItems == null || requestItems.isEmpty) {
                          return const Center(
                              child: Text('No items available.'));
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
                              onTapEdit: () {
                                ref
                                    .read(combinedFormStateProvider.notifier)
                                    .updateState(RequestState.EDITING,
                                        SelectedFormSection.initial);
                                ref
                                    .read(latestSelectRequestProvider.notifier)
                                    .update((val) => item);

                                /// navigate to the edit initial data page
                              },
                              onTapView: () {
                                /// navigate to the view initial data page
                                /// set state to viewing
                                ref
                                    .read(combinedFormStateProvider.notifier)
                                    .updateState(RequestState.VIEWING,
                                        SelectedFormSection.initial);
                                ref
                                    .read(latestSelectRequestProvider.notifier)
                                    .update((val) => item);
                                getSelectedRequestDetails(item.reqId);
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
  const AccountRequestItem(
      {super.key,
      this.request,
      this.onTapDelete,
      this.onPressed,
      required this.onTapEdit,
      required this.onTapView});
  final PendingRequestsDatum? request;
  final Function()? onPressed;
  final Function()? onTapEdit;
  final Function()? onTapDelete;
  final Function()? onTapView;

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: brightness == Brightness.light
                ? Color(0xfff0eeee)
                : ZxplorePrimaryColor,
            boxShadow: brightness == Brightness.light
                ? [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.grey.withOpacity(0.25),
                      blurRadius: 4,
                    ),
                  ]
                : []),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request?.fullName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  // width: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              request?.stage?.toLowerCase() == 'draft'
                                  ? Colors.purpleAccent
                                  : request?.stage?.toLowerCase() ==
                                          'pending posting'
                                      ? Colors.yellow
                                      : Colors.green),
                      PopupMenuButton<int>(onSelected: (value) {
                        if (value == 0) {
                          onTapView!();
                        } else {
                          onTapEdit!();
                        }
                      }, itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<int>>[
                          PopupMenuItem<int>(
                              value: 0,
                              child: GestureDetector(
                                  onTap: onTapView, child: Text('View'))),
                          //   PopupMenuItem<int>(
                          // value: 1,
                          // child: GestureDetector(
                          //   onTap: onTapEdit,
                          //   child: Text('Edit')))
                          PopupMenuItem<int>(
                              value: 1,
                              child: GestureDetector(
                                  onTap: onTapDelete, child: Text('Delete'))),
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
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    'Started on:${getDayDateAndYear(request?.createDate.toIso8601String() ?? '')}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoldableItem extends StatelessWidget {
  const FoldableItem(
      {super.key,
      this.request,
      this.onTapDelete,
      this.onPressed,
      required this.onTapEdit,
      required this.onTapView,
      this.userWrapper = false,
      required this.name,
      required this.number,
      required this.requestId,
      required this.subRequestId});
  final dynamic request;
  final String? name;
  final String? requestId;
  final int? subRequestId;
  final String? number;
  final Function()? onPressed;
  final Function()? onTapEdit;
  final Function()? onTapDelete;
  final Function()? onTapView;
  final bool userWrapper;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.15,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.withOpacity(0.25) ,width: 0.5),
            boxShadow:Theme.of(context).brightness== ThemeMode.light? [
              BoxShadow(
                offset: const Offset(0, 4),
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 4,
              ),
            ]:[]),
        child: userWrapper
            ? Column(
                children: [
                  Wrap(
                    children: [Text(name ?? '')],
                  ),
                  Wrap(
                    children: [Text(number ?? '')],
                  )
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        // width: 70,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PopupMenuButton<int>(onSelected: (value) {
                              // if (value == 0) {
                              //   onTapView!();
                              // } else
                               if (value == 1) {
                                onTapEdit!();
                              } else {
                                onTapDelete!();
                              }
                            }, itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<int>>[
                                // PopupMenuItem<int>(
                                //     height: 24,
                                //     value: 0,
                                //     child: GestureDetector(
                                //         onTap: onTapView, child: Text('View'))),
                                PopupMenuItem<int>(
                                    height: 34,
                                    value: 1,
                                    child: GestureDetector(
                                        onTap: onTapEdit, child: Text('Edit'))),
                                PopupMenuItem<int>(
                                    height: 34,
                                    value: 2,
                                    child: GestureDetector(
                                        onTap: onTapDelete,
                                        child: Text('Delete'))),
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
                        number ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
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
