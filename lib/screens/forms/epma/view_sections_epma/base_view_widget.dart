import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_section_screen.dart';

// Base screen template
class BaseFormScreen extends ConsumerWidget {
  final String title;
  final Widget? child;
  final Function()? onTapEdit;
  final Function()? onTapAdd;
  final Function()? onTapSectionMenu;
  final Map<String, dynamic> data;
  final bool showEdit;

  const BaseFormScreen(
      {Key? key,this.showEdit=true,
      required this.title,
      required this.data,
      this.child,
      this.onTapEdit,
      this.onTapAdd,
      this.onTapSectionMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: onTapSectionMenu ??
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SectionScreen()),
                    );
                  },
              icon: Icon(
                Icons.menu,
                color: ZxplorePrimaryColor,
              )),
          // Padding(
          //   padding: const EdgeInsets.only(right: 8.0),
          //   child: TextButton(
          //     onPressed: () {
          //       // Implement edit functionality
          //       print('Edit button pressed for $title');
          //     },
          //     child: const Text('Edit', style: TextStyle(color: ZxplorePrimaryColor)),
          //   ),
          // ),
        ],
      ),
      body: child

      //  Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: data.entries.map((entry) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           entry.key,
      //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //         ),
      //         const SizedBox(height: 4),
      //         Text(
      //           entry.value.toString(),
      //           style: const TextStyle(fontSize: 16),
      //         ),
      //         const SizedBox(height: 16),
      //       ],
      //     );
      //   }).toList(),
      // ),
      ,
      floatingActionButton: showEdit? FloatingActionButton(
        onPressed: onTapEdit,
        child: const Icon(Icons.edit),
      ):FloatingActionButton(
        onPressed: onTapEdit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
