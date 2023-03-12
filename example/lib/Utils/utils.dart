import 'package:incento_demo/Const/colors.dart';
import 'package:flutter/material.dart';

class UiUtils {
  static inputDecoration(
      BuildContext context, String hintText, IconData prefix) {
    return InputDecoration(
      prefixIcon: Icon(prefix),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xff282828)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: accentColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).errorColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).errorColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: accentColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  // static pushScreen(BuildContext ctx, )
}
