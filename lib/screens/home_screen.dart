import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/models/epma_models/user_pending_statistics_ressponse.dart';
import 'package:zxplore_app/screens/all_pending_requests_screen.dart';
import 'package:zxplore_app/screens/category_screen.dart';
import 'package:zxplore_app/screens/controllers/home/user_pending_statistics_controller.dart';
import 'package:zxplore_app/screens/controllers/meta/anticiapted_amount.dart';
import 'package:zxplore_app/screens/pending_drafts_requests_screen.dart';
import 'package:zxplore_app/utils/app_strings.dart';
import 'package:zxplore_app/utils/helper_functions.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';
import '../colors.dart';
import 'login_screen.dart';

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  List<String> keys = StatisticsData.keys;

  @override
  void initState() {
    super.initState();
    ref.read(getUserStatisticsDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async =>ref.invalidate(getUserStatisticsDataProvider),
      child: ZxploreProgress(
        inAsyncCall: ref.watch(getUserStatisticsDataProvider).isLoading,
        child: new Scaffold(
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
          ),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 4.0,
            backgroundColor: ZxploreRedColor,
            icon: const Icon(Icons.add, color: ZxploreGrey),
            label: const Text(
              'Create Account',
              style: TextStyle(color: ZxploreGrey),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CategoryPage()),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                  child: Consumer(builder: (ct, ref, ch) {
                    return ref.watch(getUserStatisticsDataProvider).when(
                        data: (data) {
                          return data != null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
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
                                  child: Column(
                                    children: [
                                      StatisItem(
                                        title: '${keys[0]}',
                                        value: data.draft,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    PendingDraftsRequestsScreen()),
                                          );
                                        },
                                      ),
                                      StatisItem(
                                          title: '${keys[1]}',
                                          value: data.otherStages,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      AllPendingRequestsScreen()),
                                            );
                                          }),
                                      StatisItem(
                                          title: '${keys[2]}',
                                          value: data.pendingPostingInstant,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      AllPendingRequestsScreen()),
                                            );
                                          }),
                                    ],
                                  ),
                                )
                              : Text(AppStrings.errorInProccessing);
                        },
                        error: (error, stk) => Center(
                              child: GestureDetector(
                                  onTap: () => ref
                                      .invalidate(getUserStatisticsDataProvider),
                                  child: Text(AppStrings.errorInProccessing)),
                            ),
                        loading: () => const SizedBox.shrink());
                  }))
            ],
          ),
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
}

class StatisItem extends StatelessWidget {
  const StatisItem({super.key, this.title, this.value, this.onPressed});
  final String? title;
  final int? value;
  final Function()? onPressed;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? ''),
            Chip(
              label: Text(
                '${value ?? 0}',
              ),
              backgroundColor: ZxploreRedColor,
            )
          ],
        ),
      ),
    );
  }
}
