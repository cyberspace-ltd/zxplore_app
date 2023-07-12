import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String pageTitle = _getPageTitle(navigationShell.currentIndex);
    return BackdropScaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      backLayerBackgroundColor: Theme.of(context).colorScheme.surface,
      appBar: BackdropAppBar(
        title: Text(pageTitle),
        actions: const <Widget>[
          BackdropToggleButton(
              icon: AnimatedIcons.list_view, color: Colors.grey)
        ],
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
      frontLayer: navigationShell,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                // final int index = navigationShell.currentIndex;
                if (navigationShell.currentIndex > 0) {
                  // _onItemTapped(index - 1, context);
                  navigationShell.goBranch(navigationShell.currentIndex - 1);
                }
              },
              icon: const Icon(Icons.navigate_before),
            ),
            Row(
              children: [
                for (int i = 0; i < 8; i++)
                  Container(
                    // margin: const EdgeInsets.all(4),
                    margin: i == navigationShell.currentIndex
                        ? const EdgeInsets.symmetric(horizontal: 6)
                        : const EdgeInsets.all(2),
                    width: i == navigationShell.currentIndex ? 12 : 4,
                    height: i == navigationShell.currentIndex ? 12 : 4,
                    decoration: BoxDecoration(
                      color: i == navigationShell.currentIndex
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
                if (navigationShell.currentIndex < 7) {
                  // _onItemTapped(index + 1, context);
                  navigationShell.goBranch(navigationShell.currentIndex + 1);
                }
              },
              icon: const Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }

  static String _getPageTitle(int index) {
    if (index == 0) {
      return 'Account Information';
    }
    if (index == 1) {
      return 'Contact Details';
    }
    if (index == 2) {
      return 'Means Of Identification';
    }
    if (index == 3) {
      return 'Personal Information';
    }
    if (index == 4) {
      return 'Signatory';
    }
    if (index == 5) {
      return 'Upload ID';
    }
    if (index == 6) {
      return 'Upload Passport';
    }
    if (index == 7) {
      return 'Upload Utility Bill';
    }
    return 'Account Information';
  }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
