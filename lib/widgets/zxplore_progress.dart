 
import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart'; 
import 'package:zxplore_app/widgets/blur_modal_progress.dart';

/// Custom Adapative circular progress indicator
class ZxploreProgress extends StatelessWidget {
  const ZxploreProgress(
      {super.key,
      required this.child,
      required this.inAsyncCall,
      this.title = 'Loading...'});
  final Widget child;
  final bool? inAsyncCall;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      blurEffectIntensity: 7,
      color: Colors.white,
      inAsyncCall: inAsyncCall,
      progressIndicator: CircularProgressIndicator(color: ZxplorePrimaryColor,),
    child: child,
    );
  }
}
