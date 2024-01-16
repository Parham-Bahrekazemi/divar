import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.disibled = false,
    this.textEditingController,
    this.validator,
    this.onTap,
    this.onChanged,
    this.maxlines,
    this.fillColor,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();

  final String hintText;

  final IconData? icon;

  final TextInputType? keyboardType;

  final bool disibled;

  final TextEditingController? textEditingController;

  final String? Function(String? value)? validator;

  final VoidCallback? onTap;
  final void Function(String)? onChanged;

  final int? maxlines;

  final Color? fillColor;
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscure = true;

  bool get ispassword => widget.keyboardType == TextInputType.visiblePassword;

  IconData get passwordIcon => obscure ? Iconsax.eye_slash : Iconsax.eye;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        maxLines: widget.maxlines ?? 1,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        validator: widget.validator,
        controller: widget.textEditingController,
        obscureText: ispassword ? obscure : false,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        readOnly: widget.disibled,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xffECECEC),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Vazir',
            color: Color(0xff959595),
          ),
          suffixIcon: widget.icon != null || ispassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Icon(ispassword ? passwordIcon : widget.icon),
                )
              : null,
        ),
      ),
    );
  }
}
