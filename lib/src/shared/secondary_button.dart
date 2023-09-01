import 'package:flutter/material.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class SecondaryButton extends StatelessWidget {
  /// Constructor for [SecondaryButton].
  const SecondaryButton({
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
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(
            BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary)
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
      ),
    );
  }
}
