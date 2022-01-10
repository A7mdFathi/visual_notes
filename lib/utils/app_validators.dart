import 'package:flutter/material.dart';

class AppValidator {
  static String? validatorRequired(value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Required ';
    }

    return null;
  }
}
