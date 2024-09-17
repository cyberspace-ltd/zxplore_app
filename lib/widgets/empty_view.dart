import 'package:flutter/material.dart';

class EmptyViewWidget extends StatelessWidget {
  const EmptyViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Center(child: Column(children: [
          Text('No Data added')
        ],),),
      ],
    );
  }
}