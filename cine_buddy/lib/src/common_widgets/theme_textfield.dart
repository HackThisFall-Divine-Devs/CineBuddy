import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';

class ThemeTextField extends StatelessWidget {
  const ThemeTextField({
    super.key,
    this.controllerName,
    required this.fieldName,
    this.textFieldEvent,
    this.isEnabled = true,
    this.passwordField = false,
  });

  final TextEditingController? controllerName;
  final void Function(dynamic)? textFieldEvent;
  final String fieldName;
  final bool passwordField;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: TextField(
        controller: controllerName,
        onChanged: textFieldEvent,
        keyboardType: TextInputType.text,
        obscureText: passwordField,
        enableSuggestions: !passwordField,
        autocorrect: !passwordField,
        enabled: isEnabled,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18.0,
            ),
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorSys.kgrey,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorSys.kgrey, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: fieldName,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18.0,
                color: ColorSys.kblack,
              ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorSys.ksecondary, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
