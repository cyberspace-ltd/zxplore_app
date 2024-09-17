import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/pending_requests_all_response.dart';
import 'package:zxplore_app/models/epma_models/view_account_request.dart';


enum RequestState {
  EDITING, VIEWING, DEFAULT
}

enum SelectedFormSection {
  initial,
  fundingSources,
  accountPurposes,
  productsServices,
 otherInformations,
  otherAccounts,
  foreignAccounts,
  dueDiligences,
  documentsObtainedIndividuals,
  acctReqWkfHistory,
  accountType,
  nextOfKin,
  referees,
  assignedAccts,
  children,
  stakeHolders,
  relatedBusiness,
  taxJurisdiction,
}

class CombinedFormState {
  final RequestState requestState;
  final SelectedFormSection selectedSection;

  CombinedFormState({
    required this.requestState,
    required this.selectedSection,
  });

  CombinedFormState copyWith({
    RequestState? requestState,
    SelectedFormSection? selectedSection,
  }) {
    return CombinedFormState(
      requestState: requestState ?? this.requestState,
      selectedSection: selectedSection ?? this.selectedSection,
    );
  }
}

class CombinedFormStateNotifier extends StateNotifier<CombinedFormState> {
  CombinedFormStateNotifier() 
    : super(CombinedFormState(
        requestState: RequestState.DEFAULT,
        selectedSection: SelectedFormSection.initial,
      ));

  void updateState(RequestState requestState, SelectedFormSection selectedSection) {
    state = CombinedFormState(
      requestState: requestState,
      selectedSection: selectedSection,
    );
  }

  void updateRequestState(RequestState requestState) {
    state = state.copyWith(requestState: requestState);
  }

  void updateSelectedSection(SelectedFormSection selectedSection) {
    state = state.copyWith(selectedSection: selectedSection);
  }
}
///[combinedFormStateProvider] this holds the stat and form section which the user is either [VIEWING] OR[EDITING]
/// and the section as shown in the enum [SelectedFormSection]
final combinedFormStateProvider = StateNotifierProvider<CombinedFormStateNotifier, CombinedFormState>((ref) {
  return CombinedFormStateNotifier();
});
 

///[latestSelectRequestProvider] this holds the last selected request Draft/Pending post
/// this provides the request id for calling the view request
final latestSelectRequestProvider = StateProvider<PendingRequestsDatum?>((ref)=>null);

///[latestViewAccountRequestProvider] this holds the last acquired request a user choses to [VIEW]
final latestViewAccountRequestProvider = StateProvider<ViewAccountRequestResponse?>((ref)=>null);