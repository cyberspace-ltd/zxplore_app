import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zxplore_app/src/router/router.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (index: selectedIndex, title: pageTitle) =
        _calculateSelectedIndexandTitle(context);
    return BackdropScaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      backLayerBackgroundColor: Theme.of(context).colorScheme.surface,
      appBar: BackdropAppBar(
        title: Text(pageTitle),
        // actions: const <Widget>[
        //   BackdropToggleButton(icon: AnimatedIcons.list_view)
        // ],
      ),
      backLayer: BackdropNavigationBackLayer(
        separatorBuilder: (context, index) => const Divider(indent: 48),
        itemPadding: const EdgeInsets.all(24),
        items: const [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Account Information"),
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("Contact Details"),
          ),
          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text("Means of Identification"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Personal Information"),
          ),
          ListTile(
            leading: Icon(Icons.edit_document),
            title: Text("Signatory"),
          ),
          ListTile(
            leading: Icon(Icons.upload_file),
            title: Text("Upload ID"),
          ),
          ListTile(
            leading: Icon(Icons.upload_sharp),
            title: Text("Upload Passport"),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text("Upload Bill"),
          ),
        ],
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
      frontLayer: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                final int index = selectedIndex;
                if (index > 0) {
                  _onItemTapped(index - 1, context);
                }
              },
              icon: const Icon(Icons.navigate_before),
            ),
            Row(
              children: [
                for (int i = 0; i < 8; i++)
                  Container(
                    // margin: const EdgeInsets.all(4),
                    margin: i == selectedIndex
                        ? const EdgeInsets.symmetric(horizontal: 6)
                        : const EdgeInsets.all(2),
                    width: i == selectedIndex ? 12 : 4,
                    height: i == selectedIndex ? 12 : 4,
                    decoration: BoxDecoration(
                      color: i == selectedIndex
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            IconButton(
              onPressed: () {
                final int index = selectedIndex;
                if (index < 7) {
                  _onItemTapped(index + 1, context);
                }
              },
              icon: const Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }

  static ({int index, String title}) _calculateSelectedIndexandTitle(
      BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/accountInformation')) {
      return (index: 0, title: 'Account Information');
    }
    if (location.startsWith('/contactDetails')) {
      return (index: 1, title: 'Contact Details');
    }
    if (location.startsWith('/meansOfIdentification')) {
      return (index: 2, title: 'Means Of Identification');
    }
    if (location.startsWith('/personalInformation')) {
      return (index: 3, title: 'Personal Information');
    }
    if (location.startsWith('/signatory')) {
      return (index: 4, title: 'Signatory');
    }
    if (location.startsWith('/uploadId')) {
      return (index: 5, title: 'Upload ID');
    }
    if (location.startsWith('/uploadPassport')) {
      return (index: 6, title: 'Upload Passport');
    }
    if (location.startsWith('/uploadUtilityBill')) {
      return (index: 7, title: 'Upload Utility Bill');
    }
    return (index: 0, title: 'Account Information');
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        const AccountInformationRoute().go(context);
        break;
      case 1:
        const ContactDetailsRoute().go(context);
        break;
      case 2:
        const MeansOfIdentificationRoute().go(context);
        break;
      case 3:
        const PersonalInformationRoute().go(context);
        break;
      case 4:
        const SignatoryRoute().go(context);
        break;
      case 5:
        const UploadIdRoute().go(context);
        break;
      case 6:
        const UploadPassportRoute().go(context);
        break;
      case 7:
        const UploadUtilityBillRoute().go(context);
        break;
    }
  }
}
