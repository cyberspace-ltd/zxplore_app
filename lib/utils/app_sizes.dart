/// App config class for sizes used for spacing and other
/// settings eg. font

import 'package:flutter/material.dart';
/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.)
class Sizes {
  /// 2pixels of padding

  static const p2 = 2.0;
  ///4 pixels of padding

  static const p4 = 4.0;
  static const p6 = 6.0;
  /// 8 pixels of padding

  static const p8 = 8.0;

  static const p10 = 10.0;

  /// 12 pixels of padding
  static const p12 = 12.0;

  /// 16 pixels of padding
  static const p16 = 16.0;

  /// 20 pixels of padding
  static const p20 = 20.0;

  /// 24 pixels of padding
  static const p24 = 24.0;

  /// 28 pixels of padding
  static const p32 = 32.0;

  /// 36 pixels of padding
  static const p48 = 48.0;

  /// 56 pixels of padding
  static const p64 = 64.0;

}

/// Media Screen Size
 Size screenSize(BuildContext context) => MediaQuery.of(context).size;
 double bottomInsets(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;
 bool isKeyboardOpen(BuildContext context) => bottomInsets(context) != 0;  


double ratioToHeight(double requiredHeight, double deviceHeight)=>(requiredHeight/deviceHeight)*deviceHeight;

/// 4 pixels of horizontal padding
const gapW4 = SizedBox(width: Sizes.p4);

/// 8 pixels of horizontal padding
const gapW8 = SizedBox(width: Sizes.p8);

/// 12 pixels of horizontal padding
const gapW12 = SizedBox(width: Sizes.p12);

/// 16 pixels of horizontal padding
const gapW16 = SizedBox(width: Sizes.p16);

/// 20 pixels of horizontal padding
const gapW20 = SizedBox(width: Sizes.p20);

/// 24 pixels of horizontal padding
const gapW24 = SizedBox(width: Sizes.p24);

/// 32 pixels of horizontal padding
const gapW32 = SizedBox(width: Sizes.p32);

/// 48 pixels of horizontal padding
const gapW48 = SizedBox(width: Sizes.p48);

/// 64 pixels of horizontal padding
const gapW64 = SizedBox(width: Sizes.p64);

/// 4 pixels of vertical padding
const gapH4 = SizedBox(height: Sizes.p4);
const gapH6 = SizedBox(height: Sizes.p6);
/// 2 pixels of vertical padding
const gapH2= SizedBox(height: Sizes.p2);

/// 8 pixels of vertical padding
const gapH8 = SizedBox(height: Sizes.p8);

const gapH10 = SizedBox(height: Sizes.p10);

/// 12 pixels of vertical padding
const gapH12 = SizedBox(height: Sizes.p12);

/// 16 pixels of vertical padding
const gapH16 = SizedBox(height: Sizes.p16);

/// 20 pixels of vertical padding
const gapH20 = SizedBox(height: Sizes.p20);

/// 24 pixels of vertical padding
const gapH24 = SizedBox(height: Sizes.p24);

/// 32 pixels of vertical padding
const gapH32 = SizedBox(height: Sizes.p32);

/// 48 pixels of vertical padding
const gapH48 = SizedBox(height: Sizes.p48);

/// 64 pixels of vertical padding
const gapH64 = SizedBox(height: Sizes.p64);
