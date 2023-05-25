import 'package:flutter/material.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class PrimaryButton extends StatelessWidget {
  /// Constructor for [PrimaryButton].
  const PrimaryButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    required this.text,
  });

  /// Text to display on the button.
  final String text;

  /// If true, a loading indicator will be displayed instead of the text.
  final bool isLoading;

  /// Callback to be called when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
