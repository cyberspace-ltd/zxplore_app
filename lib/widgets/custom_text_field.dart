import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxplore_app/colors.dart';

// import 'package:responsive_builder/responsive_builder.dart';

final textfieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: const BorderSide(
    color: ZxplorePrimaryColor,
    width: 0.4,
  ),
);
const textfieldFocusedOutline = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
  borderSide: BorderSide(
    color: ZxplorePrimaryColor,
    width: 0.8,
  ),
);
final appHintStyle = TextStyle(fontSize: 16,color: ZxplorePrimaryColor);
//  OutlineInputBorder(
//   borderRadius: BorderRadius.circular(8.0), // Set border radius
//   borderSide: const BorderSide(color: AppColors.blueMain, width: 0.4),
// );
final textfieldFocusedErrorOutline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: const BorderSide(
    color: ZxploreRedColor,
    width: 0.3,
  ),
);

final textfieldEnabledOutline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0), // Set border radius
  borderSide: const BorderSide(color: ZxplorePrimaryColor, width: 0.4),
);
final textfieldErrorBorderOutline = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0), // Set border radius
  borderSide: const BorderSide(color: ZxploreRedColor, width: 0.4),
);
final  errorfontSize=14.0;
/// StatelessWidget  CustomTextField
class CustomTextFormField extends StatelessWidget {
  /// Creates instance of Custom TextFormField
  const CustomTextFormField(
      {Key? key,
      required this.title,
      this.hint,
      this.isPassword = false,
      this.isRefrenceSearch = false,
      required this.controller,
      this.onChanged,
      this.fillColor,
      this.inputType,
      this.inputFormatters,
      this.validator,
      this.cursorColor,
      this.counterText,
      this.maxLenght,
      this.isEyeIconHidden = false,
      this.isPhoneNumberField = false,
      this.isFilterField = false,
      this.readOnly = false,
      this.onTapFilter,
      this.showPasswordSuffixIcon = false,
      this.showDropDownSuffixIcon = false,
      this.showCursor = true,
      this.useDefaultErrorText = true,
      this.autoFocus = false,
      this.isSendMoneyFeild = false,
      this.isAmountField = false,
      this.isDollarAmountField = false,
      this.maxLines = 1,
      this.textInputAction,
      this.filled = false,
      this.onTap,
      this.onSaved,
      this.onFieldSubmitted,
      this.onClearHistoryByReference,
      this.autovalidateMode,
      this.isSendMoneyFeildOnTapContact,
      this.togglePasswordVisibility,
      this.onEditingComplete,
      this.onTapOutside,
      this.focusNode,
      this.suffixIcon,
      this.prefixIcon,
      this.initialValue,
      this.hintStyle,
      this.showTitleTip = false,
      this.titleTip = '',
      this.titleTipStyle,
      this.maxLengthEnforcement})
      : super(key: key);

  /// String Label of field
  final String title;
  final Widget? prefixIcon;
  final bool showTitleTip;
  final String titleTip;
  final TextStyle? titleTipStyle;
  final FocusNode? focusNode;
  final int? maxLenght;
  final bool readOnly;
  final String? hint;
  final String? initialValue;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final void Function()? onClearHistoryByReference;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;

  ///bool if true shows Text form field with a  clickable contact box adjacent for Amount
  final bool isAmountField;
  final bool isRefrenceSearch;
  final bool isDollarAmountField;
  final TextStyle? hintStyle;

  //bool if true shows the country code/flag
  final bool isPhoneNumberField;

  ///bool if true shows Text form field with a  clickable contact box adjacent
  final bool isSendMoneyFeild;
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// VoidCallback action on clickable contact box adjacent isPhoneNumberField
  final void Function()? isSendMoneyFeildOnTapContact;

  /// TextInputAction
  final TextInputAction? textInputAction;

  /// bool if true will show filter field
  final bool isFilterField;

  /// bool  if true field can autofocus
  final bool autoFocus;

  /// bool  if true field can show cusor
  final bool showCursor;

  /// bool if  true the defaault error text height   will
  /// be > 0 if false height  =0
  final bool useDefaultErrorText;

  /// TextEditingController
  final TextEditingController controller;

  /// Bool if true field will have obscure text
  final bool isPassword;

  ///Bool if [showPasswordSuffixIcon] is true used to toggle the state of suffix icon
  final bool isEyeIconHidden;

  ///Bool if true shows suffice hide/unhidden icon
  final bool showPasswordSuffixIcon;

  ///Bool if [showDropDownSuffixIcon] is true used to show chevron suffix icon

  final bool showDropDownSuffixIcon;
  final bool filled;
  final Widget? suffixIcon;

  /// Function handles the toggling of hide/unhidden icon
  final void Function()? togglePasswordVisibility;

  /// Void Function when changes occur
  final Function(String)? onChanged;
  final void Function()? onTap;

  /// Input Type
  final TextInputType? inputType;

  final int? maxLines;

  ///
  final List<TextInputFormatter>? inputFormatters;
  final String? counterText;
  final Color? cursorColor;
  // final VoidCallback? onTapFilter;
  final void Function()? onTapFilter;
  final AutovalidateMode? autovalidateMode;

  ///
  final String? Function(String?)? validator;

  ///Fill color of the input field
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
             SizedBox(height: 4,),
            if (showTitleTip)
              Text(
                titleTip,
                style: titleTipStyle,
              )
            else
              const SizedBox.shrink()
          ],
        ),
          TextFormField(
            textCapitalization: showPasswordSuffixIcon
                ? TextCapitalization.none
                : TextCapitalization.sentences,
            onTap: onTap,
            autofocus: autoFocus,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            onEditingComplete: onEditingComplete,
            onTapOutside: onTapOutside,
            focusNode: focusNode,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
            maxLength: maxLenght,
            cursorColor: cursorColor,
            validator: validator,
            obscureText: isPassword,
            showCursor: showCursor,
            textInputAction: textInputAction,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              prefixIcon: prefixIcon??const SizedBox(width: 12),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              prefixIconConstraints:prefixIcon==null? BoxConstraints.tight(const Size(10, 10)):BoxConstraints.tight(const Size(38, 50)),
              filled: filled,
              counterText: counterText ?? '',
              hintStyle:hintStyle??  appHintStyle,
              fillColor: fillColor ?? ZxploreGrey.withOpacity(0.2),
              hintText: hint,
              border: textfieldBorder,
              focusedBorder: textfieldFocusedOutline,
              errorBorder: textfieldErrorBorderOutline,
              enabledBorder: textfieldEnabledOutline,
              focusedErrorBorder: textfieldFocusedErrorOutline,
              errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    overflow: TextOverflow.clip,
                    fontWeight: FontWeight.normal,
                    color: ZxploreRedColor,
                    fontSize: errorfontSize,
                    height: useDefaultErrorText ? 1 : 0,
                  ),
              errorMaxLines: 2,

              /// Eye icon
              suffixIcon: showPasswordSuffixIcon
                  ? IconButton(
                      color: ZxploreGrey,
                      icon: Icon(isEyeIconHidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: togglePasswordVisibility,
                    )
                  : showDropDownSuffixIcon
                      ? suffixIcon ??
                          IconButton(
                            icon: const Icon(
                              CupertinoIcons.chevron_down,
                              size: 14,
                              color: ZxplorePrimaryColor,
                            ),
                            onPressed: onTap,
                          )
                      : const SizedBox.shrink(),
            ),
            controller: controller,
            onChanged: onChanged,
            // cursorColor: Colors.black12,
            keyboardType: inputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
      ],
    );
  }
}
