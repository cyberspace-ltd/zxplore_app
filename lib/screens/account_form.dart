import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/screens/forms/e_products_form.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';

import '../category.dart';
import '../colors.dart';
import 'forms/account_information_form.dart';
import 'forms/contact_details_form.dart';
import 'forms/means_of_identification_form.dart';
import 'forms/personal_information_form.dart';
import 'forms/signatory_fom.dart';
import 'forms/upload_id_form.dart';
import 'forms/upload_passport_form.dart';
import 'forms/upload_utility_bill.form.dart';

class AccountFormPage extends StatefulWidget {
  final Category category;
  String? recordSavedInDevice;
  final String? accountReferenceId;
  final AccountFormBloc? accountFormBloc;
  final bool? isEditAccount;
  final List<Category> categories;
  AccountFormPage(
      {required this.category,
      required this.accountFormBloc,
      required this.categories,
      this.accountReferenceId,
      this.isEditAccount = false,
      this.recordSavedInDevice});

  @override
  _AccountFormPageState createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage>
    with AutomaticKeepAliveClientMixin<AccountFormPage> {
  PageController _controller = PageController();

  Category? category;
  String? accountReferenceId;
  AccountFormBloc? accountFormBloc;
  bool? _isEditAccount;
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final List<Widget> _pages = <Widget>[
    Container(child: AccountInformationStep()),
    Container(child: PersonalInformationStep()),
    Container(child: ContactDetailsStep()),
    Container(child: MeansOfIdentificationStep()),
    Container(child: EProductsStep()),
    Container(child: UploadIdStep()),
    Container(child: UploadPassportStep()),
    Container(child: UploadUtilityBillStep()),
    Container(child: SignatoryStep()),
  ];

  @override
  void initState() {
    super.initState();

    _setDefaults();

    if (accountReferenceId != null && widget.recordSavedInDevice == null) {
      _getAccountDetailsByReferenceId(accountReferenceId);
    } else {
      _getAccountDetailsFromDatabase(accountReferenceId);
    }
  }

  void _setDefaults() {
    setState(() {
      accountFormBloc = widget.accountFormBloc;
      category = widget.category;
      accountFormBloc!.setCurrentFormCategory(widget.category);
      accountReferenceId = widget.accountReferenceId;
      _isEditAccount = widget.isEditAccount;
    });
  }

  _getAccountDetailsFromDatabase(String? referenceId) {
    var backButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "GO BACK",
        style: TextStyle(color: Colors.red),
      ),
    );
    if (referenceId != null) {
      accountFormBloc!.getSavedAccountFormDetailsByRefId(referenceId);
    }
    accountFormBloc!.subjectOfflineDetailsResponse
        .listen((message) {})
        .onError((error) {
      var errorSnackBar = FlushbarHelper.createErrorAction(
          message: error.toString(), button: backButton);

      errorSnackBar..show(context);
    });
  }

  _getAccountDetailsByReferenceId(String? referenceId) {
    Future.delayed(const Duration(milliseconds: 500), () {
      var backButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "GO BACK",
          style: TextStyle(color: Colors.red),
        ),
      );

      var loadingBar = FlushbarHelper.createLoading(
        message: "Retrieving Account. Please wait...",
        linearProgressIndicator: null,
      );

      accountFormBloc!.getAccountsDetailsByReferenceId(referenceId);

      loadingBar..show(context);

      accountFormBloc!.subjectAccountsDetailsResponse.listen((response) {
        if (response.status!) {
          loadingBar.dismiss();
          FlushbarHelper.createSuccess(
              message: 'Account retreived successfully.')
            ..show(context);
        } else {
          loadingBar..dismiss(context);

          var errorButton = FlushbarHelper.createErrorAction(
              message: 'Retreival of account details failed, try again later.',
              button: backButton);

          errorButton..show(context);
        }
      }).onError((error) {
        loadingBar..dismiss(context);

        var errorSnackBar = FlushbarHelper.createErrorAction(
            message: error.toString(), button: backButton);

        errorSnackBar..show(context);
      });
    });
  }

  @override
  void didUpdateWidget(AccountFormPage old) {
    super.didUpdateWidget(old);
    // We update our [DropdownMenuItem] units when we switch [Categories].
    if (old.category != widget.category) {
      _setDefaults();

      accountFormBloc!.setCurrentFormCategory(widget.category);

      _controller.animateToPage(widget.category.id,
          duration: _kDuration, curve: _kCurve);

//      _createDropdownMenuItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<AccountFormBloc>(
      child: Form(
        key: this._formKey,
        child: Scaffold(
          body: IconTheme(
            data: IconThemeData(color: _kArrowColor),
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  itemCount: _pages.length,
                  //remove if you want infinite scrolling.
//                  physics: NeverScrollableScrollPhysics(),
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index % _pages.length];
                  },
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
//                    color: Colors.grey[800].withOpacity(0.5),
                    color: ZxplorePrimaryColor,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.navigate_before,
                                color: Colors.white),
                            onPressed: () {
                              _controller.previousPage(
                                  duration: _kDuration, curve: _kCurve);

                              if (_controller.page!.toInt() != 0) {
                                widget.accountFormBloc!.setCurrentFormCategory(
                                    widget.categories[
                                        _controller.page!.toInt() - 1]);
                              }
                            }),
                        Center(
                          child: DotsIndicator(
                            controller: _controller,
                            itemCount: _pages.length,
                            onPageSelected: (int page) {
                              _controller.animateToPage(
                                page,
                                duration: _kDuration,
                                curve: _kCurve,
                              );
                            },
                          ),
                        ),
                        IconButton(
                            icon:
                                Icon(Icons.navigate_next, color: Colors.white),
                            onPressed: () {
                              print("Prev_Index::${_controller.page!.toInt()}");
                               performEachFormValidaation(pageNumer: _controller.page!.toInt());

                              // _controller.nextPage(
                              //     duration: _kDuration, curve: _kCurve);

                              // if (_controller.page!.toInt() < 8) {
                              //   widget.accountFormBloc!.setCurrentFormCategory(
                              //       widget.categories[
                              //           _controller.page!.toInt() + 1]);
                              // }
                              // if (_controller.page!.toInt() == 7) {
                              //   accountFormBloc!.setFormValidation();
                              // }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bloc: accountFormBloc!,
    );
  }

  void performEachFormValidaation({required int pageNumer}) {
    switch (pageNumer) {
      //*validaate required fields on first form
      case 0:
        if (validateFirstForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
      case 1:
        if (validateSecondForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
      case 2:
        if (validateThirdForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
      case 3:
        if (validateFourthForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
      case 4:
        if (validateFiftForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
      case 5:
        if (validateSixthForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
      case 6:
        if (validateSeventhForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;

      case 7:
        if (validateEigthForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
          //*Validate all forms
          accountFormBloc!.setFormValidation();
        } else {
          showErroPrompt(context);
        }
        break;

      case 8:
        if (validateninthForm()) {
          _controller.nextPage(duration: _kDuration, curve: _kCurve);
          widget.accountFormBloc!.setCurrentFormCategory(
              widget.categories[_controller.page!.toInt() + 1]);
        } else {
          showErroPrompt(context);
        }
        break;
    }
  }

  bool validateFirstForm() {
    if (
      (accountFormBloc?.validAccountType() != null && accountFormBloc?.validAccountType()!.length != 0) &&
        (accountFormBloc?.validAccountCategory() != null&& accountFormBloc?.validAccountCategory()!.length != 0) &&
      //  (accountFormBloc?.validAccountHolderType() != null&& accountFormBloc?.validAccountHolderType()!.length != 0) && //loaded bby default
        (accountFormBloc?.validAccountAntAmt() != null&& accountFormBloc?.validAccountAntAmt()!.length != 0) &&
        (accountFormBloc?.validAccountAntTrxn() != null&& accountFormBloc?.validAccountAntTrxn()!.length != 0) &&
        (accountFormBloc?.validAccountAntWTrxn() != null&& accountFormBloc?.validAccountAntWTrxn()!.length != 0) &&
        (accountFormBloc?.validAccountAntWAmt() != null&& accountFormBloc?.validAccountAntWAmt()!.length != 0)) {
      return true;
    }
    return false;
  }

  bool validateSecondForm() {

    if ((accountFormBloc?.validTin() != null && accountFormBloc?.validTin()!.length != 0) &&
        (accountFormBloc?.validTitle() != null && accountFormBloc?.validTitle()!.length != 0) &&
        (accountFormBloc?.validSurN() != null && accountFormBloc?.validSurN()!.length != 0) &&
        (accountFormBloc?.validFirstN() != null && accountFormBloc?.validFirstN()!.length != 0) &&
        // (accountFormBloc?.validOtherN() != null && accountFormBloc?.validOtherN()!.length != 0)&&
        (accountFormBloc?.validDob() != null && accountFormBloc?.validDob()!.length != 0)&&
        (accountFormBloc?.validPlaceOfBirth() != null && accountFormBloc?.validPlaceOfBirth()!.length != 0)&&
         (accountFormBloc?.validCountryOfOrigin() != null && accountFormBloc?.validCountryOfOrigin()!.length != 0)&&
        (accountFormBloc?.validHomeTown() != null && accountFormBloc?.validHomeTown()!.length != 0)&&
        (accountFormBloc?.validEmploymentType() != null && accountFormBloc?.validEmploymentType()!.length != 0)) {
      return true;
    }
    return false;
  }

  bool validateThirdForm() {
    if ((accountFormBloc?.validEmail() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validPhone() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validAddress() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validGPSAddress() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validCityOfRes() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validRegion() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validCityOfRes() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validGender() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validOccGrp() != null)&& accountFormBloc?.validEmploymentType()!.length != 0 &&
        (accountFormBloc?.validOccupation() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validMaritalStat() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validNok() != null && accountFormBloc?.validEmploymentType()!.length != 0)&&
       ( accountFormBloc?.validGender() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validOccGrp() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validNokAddress() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validNokGender() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
       ( accountFormBloc?.validNokPhone() != null&& accountFormBloc?.validEmploymentType()!.length != 0) &&
        (accountFormBloc?.validNokRelationship() != null&& accountFormBloc?.validEmploymentType()!.length != 0)) {
      return true;
    }
    return false;
  }

  bool validateFourthForm() {
    if (
      (accountFormBloc?.validIdType() != null && accountFormBloc?.validIdType()!.length != 0) &&
        (accountFormBloc?.validIdIssueer() != null&& accountFormBloc?.validIdIssueer()!.length != 0) &&
        (accountFormBloc?.validIdNumber() != null&& accountFormBloc?.validIdNumber()!.length != 0) &&
        (accountFormBloc?.validIdCiuntryOfIssue() != null&& accountFormBloc?.validIdCiuntryOfIssue()!.length != 0) &&
        // (accountFormBloc?.validIdDateOfIssue() != null&& accountFormBloc?.validIdDateOfIssue()!.length != 0) &&
        (accountFormBloc?.validIdPlaceOfIssue() != null&& accountFormBloc?.validIdPlaceOfIssue()!.length != 0)
        // (accountFormBloc?.validIdExp() != null&& accountFormBloc?.validIdExp()!.length != 0)
        ) {
      return true;
    }
    return false;
  }

  bool validateFiftForm() {
    if (accountFormBloc?.validEProduct() == true) {
      return true;
    }
    return false;
  }

  bool validateSixthForm() {
    if (accountFormBloc?.validIdUploads() == true) {
      return true;
    }
    return false;
  }

  bool validateSeventhForm() {
    if (accountFormBloc?.validIdPassport() != null && accountFormBloc?.validIdPassport()!.length != 0) {
      return true;
    }
    return false;
  }

  bool validateEigthForm() {
    if (accountFormBloc?.validUtilityBill() != null&& accountFormBloc?.validUtilityBill()!.length != 0) {
      return true;
    }
    return false;
  }

  bool validateninthForm() {
    if (accountFormBloc?.validIdSignature() != null) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    accountFormBloc?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

void showErroPrompt(BuildContext context) {
  var errorSnackBar = FlushbarHelper.createErrorAction(
      message: 'Some required field(s) are missing',duration: Duration(seconds: 2),
      button: TextButton(onPressed: () {}, child: Text(' ')));

  errorSnackBar..show(context);
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 4.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      child: Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}
