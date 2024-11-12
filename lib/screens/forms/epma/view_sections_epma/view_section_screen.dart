import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/backdrop.dart';
import 'package:zxplore_app/category.dart';
import 'package:zxplore_app/category_tile.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_account_purposes_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_acount_type_monthly_activity_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_assigned_type_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_children_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_document_attached_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_foreign_accounts_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_funding_sources_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_next_of_kin_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_other_accounts_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_other_information_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_product_services_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_refrees_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_related_business_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_stake_holder_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_tax_jurisdiction_sreen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_validate_complete_process.dart';

// import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
/// this is a list of all the readonly sections
/// of the user data
class SectionScreen extends ConsumerStatefulWidget {
  SectionScreen();

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends ConsumerState<SectionScreen> {
  Category? defaultCategory;
  final _categories = <Category>[];

  _getCategories() {
    var categoryIndex = 0;
    setState(() {
      _categories.add(Category(id: 0, name: 'Personal Information')); //Initial
      _categories.add(Category(id: 1, name: 'Funding Sources'));

      _categories.add(Category(id: 2, name: 'Account Purposes'));
      _categories.add(Category(id: 3, name: 'Products Services'));
      // _categories.add(Category(id: 4, name: 'Other Information'));
      _categories.add(Category(id: 5, name: 'Other Accounts'));
      _categories.add(Category(id: 6, name: 'Foreign Accounts'));
      _categories.add(Category(id: 7, name: 'Upload Documents'));
      _categories.add(Category(id: 8, name: 'Account Type'));
      _categories.add(Category(id: 9, name: 'Next Of Kin'));
      _categories.add(Category(id: 10, name: 'Referees'));
      _categories.add(Category(id: 11, name: 'Assigned Accounts'));
      _categories.add(Category(id: 12, name: 'Children'));
      _categories.add(Category(id: 13, name: 'Stake Holders'));
      _categories.add(Category(id: 14, name: 'Related Business'));
      _categories.add(Category(id: 15, name: 'Tax Jurisdiction'));
      _categories.add(Category(id: 16, name: 'Validate and Complete'));

      if (categoryIndex == 0) {
        defaultCategory = _categories[0];
      }
    });
    categoryIndex += 1;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      _getCategories();
    }
  }

  void goToSelected(Widget widgetToGo) {
    Navigator.push(
      context,
      MaterialPageRoute(  builder: (BuildContext context) => widgetToGo),
    );
  }

  /// Function to call when a [Category] is tapped.
  void _onCategoryTap(Category category) {
    Navigator.pop(context);
    if (category.id == 0) {
      goToSelected(ViewInitialCreationInfoScreen(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 1) {
      goToSelected(FundingSourcesScreen (
          requestData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 2) {
      goToSelected(AccountPurposeScreen (
          requestData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 3) {
      goToSelected(ViewProductServicesScreen  (
          requestData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } 
    // else if (category.id == 4) {
    //   goToSelected(ViewOtherInformationSreen (
    //       requestData: ref.read(activelyViewedRequestProvider)!.toMap()));
    // }
     else if (category.id == 5) {
      goToSelected(ViewOtherAccounts (
          requestData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 6) {
      goToSelected(ViewForeignAccount (
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 7) {
      goToSelected(ViewDocumentsAttachedScreen (
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 8) {
      goToSelected(AccountTypeMonthlyActivityScreen (
          requestData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 9) {
      goToSelected(ViewNextOfKinScreen (
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 10) {
      //ViewRefreesScreen
      goToSelected(ViewRefreesScreen (
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 11) {
      goToSelected(ViewAssignedAccountScreen (
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 12) {
      goToSelected(ViewChildrenScreen (
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 13) {
      goToSelected( StackHolderdersScreen(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } else if (category.id == 14) {
      goToSelected(  ViewRelatedBusiness(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    } 
    else if (category.id == 15) {
      goToSelected(ViewTazJurisdictionScreen(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    }
     else if (category.id == 16) {
      goToSelected(ProcessFlowWidget(
          formIndividualData: ref.read(activelyViewedRequestProvider)!.toMap()));
    }
  }

  /// Makes the correct number of rows for the list view, based on whether the
  /// device is portrait or landscape.
  ///
  /// For portrait, we use a [ListView]. For landscape, we use a [GridView].
  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var _category = _categories[index];
          return CategoryTile(
            category: _category,
            onTap: _onCategoryTap,
          );
        },
        itemCount: _categories.length,
      );
    } else {
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 3.0,
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      _getCategories();
    }
    // Based on the device size, figure out how to best lay out the list
    // You can also use MediaQuery.of(context).size to calculate the orientation
    assert(debugCheckHasMediaQuery(context));
    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
    );

    return Backdrop(
      // accountFormBloc: accountFormBloc!,
      currentCategory: Category(name: 'name', id: 0),

      frontPanel: Container(
        color: ZxplorePrimaryColor,
        child: Column(
          children: [
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
          ],
        ),
      ),

      backPanel: listView,
      frontTitle: Text('Select section'),
      backTitle: Text(
        'Select section',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}