import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart';

// Base screen template
class BaseFormScreen extends StatelessWidget {
  final String title;
  final Widget? child;
  final Function()? onTapEdit;
  final Function()? onTapSectionMenu;
  final Map<String, dynamic> data;

  const BaseFormScreen({Key? key, required this.title, required this.data,this.child,this.onTapEdit,this.onTapSectionMenu }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(onPressed: onTapSectionMenu, icon: Icon(Icons.menu,color:ZxplorePrimaryColor ,)),
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
      body:  child
          
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
      floatingActionButton: FloatingActionButton(
        onPressed: onTapEdit,
        child: const Icon(Icons.edit),
      ),
    );
  }
}

 
