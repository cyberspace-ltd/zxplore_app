import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/selected_request_provider.dart';
import 'package:zxplore_app/screens/controllers/pending_requests/pending_requests_draft_controller.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class PendingDraftsRequestsScreen extends ConsumerStatefulWidget {
  const PendingDraftsRequestsScreen({super.key});

  @override
  ConsumerState<PendingDraftsRequestsScreen> createState() =>
      _PendingDraftsRequestsScreenState();
}

class _PendingDraftsRequestsScreenState
    extends ConsumerState<PendingDraftsRequestsScreen> {
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
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(getPendingRequestsDraftDatumProvider),
      child: ZxploreProgress(
        inAsyncCall: ref.watch(getPendingRequestsDraftDatumProvider).isLoading,
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
          body:   Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
            child: ListView(
              children: [
                Text(
                  'Drafts',
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
                  showCursor: true,
                  inputType: TextInputType.text,
                  controller: _filterController,
                  useDefaultErrorText: false,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (query) {
                    final requestItemsAsyncValue =
                        ref.watch(getPendingRequestsDraftDatumProvider);
                    requestItemsAsyncValue.whenData((requestItems) {
                      _filterBillers(query, requestItems ?? []);
                    });
                  },
                ),
                gapH16,
                Consumer(
                  builder: (context, watch, child) {
                    final requestItemsAsyncValue = ref.watch(
                      getPendingRequestsDraftDatumProvider,
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
                              onPressed: () {
                      

                              },
                              onTapEdit: (){
                                /// navigate to the edit initial data page
                              },
                              onTapView: (){
                                          /// navigate to the view initial data page
                                /// set state to viewing
                                ref.read(combinedFormStateProvider.notifier ).updateState(RequestState.VIEWING, SelectedFormSection.initial);
                                ref.read(latestSelectAccountRequestProvider.notifier).update((val)=>null);
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
