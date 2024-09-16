import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/backdrop.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/category.dart';
import 'package:zxplore_app/category_tile.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
/// this is a list of all the editable sections
/// of the user data
class SectionScreen extends ConsumerStatefulWidget {
  SectionScreen();

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends ConsumerState<SectionScreen> {
  Category? _defaultCategory;
  Category? _currentCategory;
  String? accountReferenceId;
  AccountFormBloc? accountFormBloc;
  bool? _isEditAccount;
  // Widgets are supposed to be deeply immutable objects. We can update and edit
  // _categories as we build our app, and when we pass it into a widget's
  // `children` property, we call .toList() on it.
  // For more details, see https://github.com/dart-lang/sdk/issues/27755
  final _categories = <Category>[];

  @override
  void initState() {
    super.initState();
    // accountFormBloc = new AccountFormBloc();

    // _setDefaults();
  }

  // void _setDefaults() {
  //   setState(() {
  //     accountReferenceId = widget.accountReferenceId;
  //     _isEditAccount = widget.isEditAccount;
  //     accountFormBloc!.setFormStatus(_isEditAccount);
  //   });
  // }

  _getCategories() {
    var categoryIndex = 0;

    setState(() {
      _categories.add(Category(id: 0, name: 'Account Information'));
      _categories.add(Category(id: 1, name: 'Personal Information'));
      _categories.add(Category(id: 2, name: 'Contact Details'));
      _categories.add(Category(id: 3, name: 'Means of Identification'));
      _categories.add(Category(id: 4, name: 'E-Product List'));
      _categories.add(Category(id: 5, name: 'ID Card Upload'));
      _categories.add(Category(id: 6, name: 'Passport Picture Upload'));
      _categories.add(Category(id: 7, name: 'Utility Bill Upload'));
      _categories.add(Category(id: 8, name: 'Signatory'));

      if (categoryIndex == 0) {
        _defaultCategory = _categories[0];
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

  /// Function to call when a [Category] is tapped.
  void _onCategoryTap(Category category) {
    accountFormBloc!.setCurrentFormCategory(category);
    setState(() {
      _currentCategory = category;
    });
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
      currentCategory:Category(name: 'name', id: 0),
           
      frontPanel:Container(
        color: ZxplorePrimaryColor,
        child: Column(children: [
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
        ],),
      ),
 
      backPanel: listView,
      frontTitle: Text('Select section'),
      backTitle: Text('Select section',style: TextStyle(fontSize: 20),),
    );
  }
}
