import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.loading = false,
    this.hasBorder = false,
  });

  final String title;

  final void Function()? onPressed;

  final bool loading;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: loading ? () {} : onPressed,
      color: hasBorder
          ? Colors.transparent
          : Theme.of(context).colorScheme.primary,
      minWidth: double.infinity,
      height: 43,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: hasBorder
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
      ),
      child: loading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}
