import 'package:flutter/material.dart';
import 'package:zxplore_app/apis/zenithbank_api.dart';
import 'package:zxplore_app/blocs/account_class_bloc.dart';
import 'package:zxplore_app/blocs/all_accounts_bloc.dart';
import 'package:zxplore_app/blocs/cities_bloc.dart';
import 'package:zxplore_app/blocs/countries_bloc.dart';
import 'package:zxplore_app/blocs/states_bloc.dart';
import 'package:zxplore_app/data/database.dart';
import 'package:zxplore_app/screens/category_screen.dart';
// import 'package:zxplore_app/screens/offline_home.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';
import 'package:zxplore_app/utils/helper_functions.dart';
import 'package:zxplore_app/utils/secure_storage.dart';

import '../blocs/occupations_bloc.dart';
import '../colors.dart';
import 'login_screen.dart';
import '../models/accounts_response.dart';
import '../utils/zxplore_crypto_helper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? accounts;
  late AccountsBloc _accountsBloc;
  String? token = "";

  Future<List<String>>? occupations;
  late OccupationsBloc _occupationsBloc;
  late CountriesBloc _countriesBloc;
  late StatesBloc statesBloc;
  late CitiesBloc _citiesBloc;
  late AccountClassBloc _accountClassBloc;

  @override
  void initState() {
    super.initState();
    // _occupationsBloc = OccupationsBloc();
    // _countriesBloc = CountriesBloc();
    // statesBloc = StatesBloc();
    // _citiesBloc = CitiesBloc();
    // _accountClassBloc = AccountClassBloc();

    // SecureStorage.getEmployeeToken().then((data) {
    //   if (data != null) {
    //     _fetchAccountClasses(data);
    //     _fetchStates(data);
    //     _fetchOccupations(data);
    //     _fetchCities(data);
    //     _fetchCountries(data);
    //     _fetchCardTypes(data);

    //     //  _fetchEmploymentTypes(data);
    //     //  _fetchMonthlyAllowanceUrl(data);
    //     //  _fetchPurposeOfAcctUrl(data);
    //     //  _fetchSourceOfFundUrl(data);

    //     //   _fetchTransactionTypeUrl(data);
    //     //   _fetchNoOfTransactionUrl(data);
    //   }
    // });
    // refreshAccounts();
  }

  // Future<void> refreshAccounts() async {
  //   _accountsBloc = AccountsBloc();

  //   await _accountsBloc.getAccounts();
  // }

  // Widget _buildLoadingWidget() {
  //   return Center(
  //       child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("Please wait while we get accounts you have created..."),
  //       SizedBox(height: 20),
  //       CircularProgressIndicator()
  //     ],
  //   ));
  // }

  // Widget _actionChipError(String error) {
  //   if (error.contains('expired')) {
  //    new Future.delayed(const Duration(milliseconds: 200), ()
  //    {

  //      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  //          builder: ( BuildContext context) => LoginPage()
  //      ), ModalRoute.withName('/'));

  //    });

  //     return ActionChip(
  //         backgroundColor: ZxploreGrey,
  //         padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
  //         avatar: CircleAvatar(
  //           backgroundColor: ZxploreGrey,
  //           child: const Icon(
  //             Icons.call_missed_outgoing,
  //             color: ZxploreRedColor,
  //           ),
  //         ),
  //         label: Text('Sign out',
  //             style: TextStyle(
  //                 fontStyle: FontStyle.normal, color: ZxploreRedColor)),
  //         onPressed: () {
  //           Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (BuildContext context) => LoginPage()),
  //               ModalRoute.withName('/'));
  //         });
  //   } else {
  //     return ActionChip(
  //         backgroundColor: ZxploreGrey,
  //         padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
  //         avatar: CircleAvatar(
  //           backgroundColor: ZxploreGrey,
  //           child: const Icon(
  //             Icons.refresh,
  //             color: ZxplorePrimaryColor,
  //           ),
  //         ),
  //         label: Text('Try again',
  //             style: TextStyle(
  //                 fontStyle: FontStyle.normal, color: ZxplorePrimaryColor)),
  //         onPressed: () async {
  //           if (token!.isEmpty) {
  //             token = await SecureStorage.getEmployeeToken();
  //           } else if (token!.isNotEmpty) {
  //             _fetchAccountClasses(token);
  //             _fetchStates(token);
  //             _fetchOccupations(token);
  //             _fetchCities(token);
  //             _fetchCountries(token);
  //             _accountsBloc.getAccounts();
  //           }
  //         });
  //   }
  // }


  // Widget _buildErrorWidget(String error) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             Icons.cloud_off,
  //             color: Colors.black54,
  //             size: 60,
  //           ),
  //           SizedBox(height: 20),
  //           Text("$error",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14.0)),
  //           SizedBox(height: 20),
  //           Transform.scale(
  //             scale: 1.2,
  //             child: _actionChipError(error),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _accountsBloc.dispose();
    super.dispose();
  }

//   void _showModal() {
//     showModalBottomSheet<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return ListView(
//             children: <Widget>[
//               new ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                   ),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
//                   child: new Text(
//                     'COLOR KEY',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 onTap: () {
// //                _controller.animateTo(0);
// //                Navigator.pop(context);
//                 },
//               ),
//               Container(
//                 height: 1,
//                 color: Colors.grey,
//               ),
//               SizedBox(height: 24.0),
//               new ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     color: Colors.amber,
//                     type: MaterialType.circle,
//                     child: new Container(
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
//                   child: new Text(
//                     'Saved',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 subtitle: new Text(
//                     'This is for accounts that have been saved on the server, but not completed.'),
//                 onTap: () {
// //                _controller.animateTo(0);
// //                Navigator.pop(context);
//                 },
//               ),
//               new ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     color: Colors.blueAccent,
//                     type: MaterialType.circle,
//                     child: new Container(
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
//                   child: new Text(
//                     'Pending',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 subtitle:
//                     new Text('This is for accounts that are still pending.'),
//                 onTap: () {
// //                _controller.animateTo(0);
// //                Navigator.pop(context);
//                 },
//               ),
//               new ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     color: ZxploreCompletedGreen,
//                     type: MaterialType.circle,
//                     child: new Container(
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
//                   child: new Text(
//                     'Completed',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 subtitle: new Text(
//                     'This is a status to show users that have completed their account creation.'),
//                 onTap: () {
// //                _controller.animateTo(0);
// //                Navigator.pop(context);
//                 },
//               ),
//               new ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     color: ZxploreRejectedPink,
//                     type: MaterialType.circle,
//                     child: new Container(
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
//                   child: new Text(
//                     'Rejected',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 subtitle: new Text(
//                     'These are accounts that have been rejected due to processing errors.'),
//                 onTap: () {
// //                _controller.animateTo(0);
// //                Navigator.pop(context);
//                 },
//               ),
//               new ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     color: Colors.purpleAccent,
//                     type: MaterialType.circle,
//                     child: new Container(
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
//                   child: new Text(
//                     'Saved on device',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 subtitle: new Text(
//                     'This is for an un-completed accounts details, saved on the mobile device to be completed at a later time.'),
//                 onTap: () {
// //                _controller.animateTo(0);
// //                Navigator.pop(context);
//                 },
//               ),
//               SizedBox(
//                 height: 15.0,
//               )
//             ],
//           );
//         });
//   }

//   Color getColor(String? selector) {
//     if (selector == 'Completed') {
//       return ZxploreCompletedGreen;
//     } else if (selector == 'Saved') {
//       return Colors.amber;
//     } else if (selector == 'SavedToDevice') {
//       return Colors.purpleAccent;
//     } else if (selector == 'Pending') {
//       return Colors.blueAccent;
//     } else {
//       return ZxploreRejectedPink;
//     }
//   }

//   ListTile makeListTile(Datum form, BuildContext _context) {
//     // debugPrint("DATA::${form.accountNumber}");
//     // String? accName  = CryptoHelper.decrypt(form.accountName!);
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
//       leading: Container(
//         padding: EdgeInsets.only(left: 16.0),
//         child: new Material(
//           color: getColor(form.status),
//           type: MaterialType.circle,
//           child: new Container(
//             width: 24,
//             height: 24,
//           ),
//         ),
//       ),
//       title: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: new Text.rich(
//           TextSpan(
//             text: saferDetail(form.accountName),
//             // (form.accountName != null)
//             //     ? "Name: ${CryptoHelper.decrypt(form.accountName ?? '')}"
//             //     : 'Name: N/A',
//             style: TextStyle(
//               color: Colors.black,
//               background: Paint()
//                 ..color = Colors.transparent
//                 ..strokeWidth = 16.5
//                 ..style = PaintingStyle.stroke,
//             ),
//             children: <TextSpan>[
//               TextSpan(
//                   text: '\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
//               TextSpan(
//                   text: form.phoneNumber != null
//                       ? "Phone:+233${CryptoHelper.decrypt(form.phoneNumber!)}"
//                       : "Phone: N/A",
//                   style: TextStyle(
//                       fontStyle: FontStyle.normal,
//                       color: Colors.black54,
//                       fontSize: 14.0)),
//             ],
//           ),
//         ),
//       ),
//       subtitle: Row(
//         children: <Widget>[
//           ActionChip(
//               backgroundColor: ZxploreGrey,
//               padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
//               avatar: CircleAvatar(
//                 backgroundColor: Colors.transparent,
//                 child: const Icon(
//                   Icons.refresh,
//                   color: Colors.black,
//                 ),
//               ),
//               label: Text('Verify Account'),
//               onPressed: () {
//                 var loadingBar = FlushbarHelper.createLoading(
//                     message:
//                         "'Verifying account status for ${CryptoHelper.decrypt(form.accountName!)}....",
//                     linearProgressIndicator: null);
//                 loadingBar..show(context);
//                 _accountsBloc.verifyAccountByReferenceId(form.refId);
//                 _accountsBloc.subjectVerifyAccountsResponse.listen((response) {
//                   loadingBar.dismiss();

//                   if (response.status!) {
//                     if (response.data!.accountNumber != null) {
//                       FlushbarHelper.createSuccess(
//                           message:
//                               '${response.message} . Account number is: ${response.data!.accountNumber}')
//                         ..show(context);
//                     } else {
//                       FlushbarHelper.createInformation(
//                               message: '${response.message}')
//                           .show(context);
//                       loadingBar.dismiss();
//                     }
//                   } else {
//                     FlushbarHelper.createInformation(
//                             message: '${response.message}')
//                         .show(context);
//                     loadingBar.dismiss();
//                   }
//                 }).onError((error) {
//                   loadingBar.dismiss();
//                   FlushbarHelper.createError(message: "'${error.toString()}'.")
//                       .show(context);
//                   loadingBar.dismiss();
//                 });
//               }),
//           Expanded(
//               flex: 1,
//               child: Container(
//                 child: _statusWidget(form),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _statusWidget(Datum form) {
//     if (form.status?.toLowerCase() == 'completed') {
//       return Chip(
//           backgroundColor: Colors.transparent,
//           labelPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
//           padding: EdgeInsets.fromLTRB(4, 0, 8, 0),
//           avatar: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             child: const Icon(
//               Icons.check,
//               color: Colors.green,
//             ),
//           ),
//           label: Text(
//             'Acc: ${form.accountNumber == null ? CryptoHelper.decrypt(form.accountNumber!) : 'N/A'}',
//           ));
// //          onPressed: () {});
//     } else {
//       return ActionChip(
//           backgroundColor: Colors.transparent,
//           labelPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
//           padding: EdgeInsets.fromLTRB(4, 0, 8, 0),
//           avatar: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             child: const Icon(
//               Icons.call_made,
//               color: Colors.black,
//             ),
//           ),
//           label: Text(
//             'Edit Account',
//           ),
//           onPressed: () {
//                         Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (BuildContext context) => CategoryPage(
//                       accountReferenceId: form.refId,
//                       isEditAccount: (form.status == ("Saved") ||form.status == ("SavedToDevice")),
//                       recordSavedInDevice: form.status == ("SavedToDevice")
//                           ? "SavedToDevice"
//                           : null),
//                 ));
//           });
//     }
//   }

//   Card makeCard(Datum form, BuildContext _context) => Card(
//         elevation: 0.0,
//         color: Colors.white,
//         margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
//         child: Container(
//           child: makeListTile(form, _context),
//         ),
//       );

//   Widget makeBody(AccountsResponse accountsResponse, BuildContext _context) =>
//       Container(
//         // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
//         child: ListView.builder(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemCount: accountsResponse.data!.length,
//           itemBuilder: (BuildContext context, int index) {
//             //  debugPrint("DT:${CryptoHelper.decrypt(accountsResponse.data![1].accountName!)}");
//             return
//                 //

//                 makeCard(accountsResponse.data![index], _context);
//           },
//         ),
//       );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: ZxplorePrimaryColor,
        automaticallyImplyLeading: false,
        // Don't show the leading button
        centerTitle: true,
        leading: Container(),
        title: const Text(
          'Zxplore Ghana',
          style: TextStyle(color: Colors.white),
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.refresh, color: Colors.white),
        //       onPressed: () {
        //         var loading = FlushbarHelper.createLoading(
        //             message: 'Getting latest accounts...')
        //           ..show(context);
        //         _accountsBloc.getAccounts();
        //         _accountsBloc.fetchAccountClasses();

        //         Future.delayed(
        //             new Duration(seconds: 10), () => loading.dismiss(context));

        //         setState(() {});
        //       }),
        //   // IconButton(
        //   //     icon: Icon(Icons.cloud_off, color: Colors.white),
        //   //     onPressed: () {
        //   //       Navigator.push(
        //   //         context,
        //   //         MaterialPageRoute(
        //   //             builder: (BuildContext context) => OfflineHomePage()),
        //   //       );
        //   //     }),
        //   SizedBox(
        //     width: 16,
        //   )
        // ],
     
     
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: ZxploreRedColor,
        icon: const Icon(Icons.add,color: ZxploreGrey),
        label: const Text('Create Account',style: TextStyle(color: ZxploreGrey),),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CategoryPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(children: [
        Padding(
                   padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 40),

          child: Row(
            children: [
              Text(
                    'Account Details',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
          child: Container(
                height: MediaQuery.of(context).size.height*0.5,
                padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
             
              color: Color(0xfff0eeee),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 4,
                ),
              ]),
              child: Column(children: [
                StatisItem(),
                StatisItem(),
                StatisItem(),
              ],),
          
          
          ),
        )

      ],),
      //  StreamBuilder<AccountsResponse>(
      //   stream: _accountsBloc.subjectAccountsResponse.stream,
      //   builder: (context, AsyncSnapshot<AccountsResponse> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return _buildLoadingWidget();
      //     } else if (snapshot.hasError) {
      //       return _buildErrorWidget(snapshot.data!.message!);
      //     } else if (snapshot.hasData) {
      //       return makeBody(snapshot.data!, context);
      //     } else {
      //       return Center(child: Text('No data available'));
      //     }
      //   },
      // ),
    
      bottomNavigationBar: BottomAppBar(
        color: ZxplorePrimaryColor,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.info_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _showModal();
                }),
            IconButton(
                icon: Icon(Icons.power_settings_new, color: Colors.white),
                onPressed: () {
                  _showLogoutDialog();
                }),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Logging Out"),
          content: new Text(
              "Are you sure you want to logout. You might lose offline data. Proceed?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: Text('Yes Logout'),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  Colors.red.shade900,
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.white,
                ),
                side: WidgetStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.red.shade900),
                ),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(16),
                ),
              ),
              onPressed: () async {
                await Helper.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    ModalRoute.withName('/'));

//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (BuildContext context) => LoginPage()),
//                );
              },
            ),
          ],
        );
      },
    );
  }

  Future _fetchStates(String? token) async {
    await DBProvider.db.getStates().then((result) async {
      if (result.isEmpty) {
        await ZenithBankApi().fetchStates(token).then((result) {
          statesBloc.inAddStates.add(result.menu);
        }).catchError((error) {
          throw Exception(error.toString());
        });
      } else {
        //data exists continue
        return;
      }
    });
  }

  // Future _fetchOccupations(String? token) async {
  //   await DBProvider.db.getOccupations().then((result) async {
  //     if (result.isEmpty) {
  //       await ZenithBankApi().fetchOccupations(token).then((result) async {
  //         _occupationsBloc.inAddOccupations.add(result.menu);
  //       }).catchError((error) {
  //         throw Exception(error.toString());
  //       });
  //     } else {
  //       //data exists continue
  //       return;
  //     }
  //   });
  // }

  // Future _fetchCountries(String? token) async {
  //   try {
  //     await DBProvider.db.getCountries().then((result) async {
  //       if (result.isEmpty) {
  //         await ZenithBankApi().fetchCountries(token).then((result) {
  //           _countriesBloc.inAddCountries.add(result.menu);
  //         }).catchError((error) {
  //           throw Exception(error.toString());
  //         });
  //       } else {
  //         return;
  //       }
  //     });
  //   } catch (e) {}
  // }

  // Future _fetchCities(String? token) async {
  //   await DBProvider.db.getCities().then((result) async {
  //     if (result.isEmpty) {
  //       await ZenithBankApi().fetchCities(token).then((result) {
  //         _citiesBloc.inAddCities.add(result.menu);
  //       }).catchError((error) {
  //         throw Exception(error.toString());
  //       });
  //     } else {
  //       return;
  //     }
  //   });
  // }

  // Future _fetchAccountClasses(String? token) async {
  //   DBProvider.db.getAccountClasses().then((result) async {
  //     if (result.isEmpty) {
  //       await ZenithBankApi().fetchAccountClasses(token).then((result) {
  //         _accountClassBloc.inAddAccountClasses.add(result.accountClassCodes);
  //       }).catchError((error) {
  //         throw Exception(error.toString());
  //       });
  //     } else {
  //       //data exists continue
  //       return;
  //     }
  //   });
  // }

  // Future _fetchCardTypes(String? token) async {
  //   await ZenithBankApi().fetchCardTypes(token);
  // }

/*

  Future _fetchEmploymentTypes(String? token) async {
    await ZenithBankApi().fetchEmploymentTypes(token);
  }

  Future _fetchMonthlyAllowanceUrl(String? token) async {
    await ZenithBankApi().fetchMonthlyAllowanceUrl(token);
  }

  Future _fetchPurposeOfAcctUrl(String? token) async {
    await ZenithBankApi().fetchPurposeOfAcctUrl(token);
  }

  

  Future _fetchSourceOfFundUrl(String? token) async {
    await ZenithBankApi().fetchSourceOfFundUrl(token);
  }

  Future _fetchTransactionTypeUrl(String? token) async {
    await ZenithBankApi().fetchTransactionTypeUrl(token);
  }

  Future _fetchNoOfTransactionUrl(String? token) async {
    await ZenithBankApi().fetchNoOfTransactionUrl(token);
  }
*/
}

class StatisItem extends StatelessWidget {
  const StatisItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.12,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical:10 ),
      decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
    //               border: Border.all(
    // width: 0.5,
    //               ),
                  color: Colors.white,
                  boxShadow: [
    BoxShadow(
      offset: const Offset(0, 4),
      color: Colors.grey.withOpacity(0.25),
      blurRadius: 4,
    ),
                  ]),
                  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('Drafts'),
    Chip(label:Text('100',),backgroundColor: ZxploreRedColor, )
                  ],),
    );
  }
}

// String saferDetail(String? value) {
//   if (value != null) {
//     String? saferString = CryptoHelper.decrypt(value);
   
//     // ignore: unnecessary_null_comparison
//     if (saferString==null){
//       return 'N/A';
//     } else {
//       if (saferString.toString().replaceAll(RegExp(r'\s+'), '') == 'nullnull') {
//         return 'N/A';
//       }
//       return saferString;
//     }
//   }
//   return 'N/A';
// }
