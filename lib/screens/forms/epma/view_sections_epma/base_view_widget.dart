import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_initial_creation_info_screen.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_section_screen.dart';
import 'package:zxplore_app/screens/home_screen.dart';

// Base screen template
class BaseFormScreen extends ConsumerWidget {
  final String title;
  final Widget? child;
  final Function()? onTapEdit;
  final Function()? onTapAdd;
  final Function()? onTapSectionMenu;
  final Map<String, dynamic> data;
  final bool showEdit;
  final bool showAdd;
  final bool showHomeIcon;

  const BaseFormScreen(
      {Key? key,
      this.showEdit=true,
      this.showHomeIcon=true,
      this.showAdd=true,
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
           if(showHomeIcon)... [IconButton(
              onPressed: 
                  () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage(),
                          ),
                            (Route<dynamic> route) => false,

                    );
                  },
              icon: Icon(
                Icons.home_filled,
                color: ZxplorePrimaryColor,
              )),],
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
      ):
      showAdd?
      FloatingActionButton(
        onPressed: onTapAdd,
        child: const Icon(Icons.add),
      ):const SizedBox.shrink(),
    );
  }
}
