import 'package:flutter/services.dart';

class TelInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = _getFormattedTelStr(newValue.text);
    
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _getFormattedTelStr(String value) {
    value = _cleanTelStr(value);

    if(value.length > 3 && value.length < 8) {
      value = "${value.substring(0, 3)}-${value.substring(3)}";
    } else if(value.length >= 8 && value.length < 12) {
      value = "${value.substring(0, 3)}-${value.substring(3, 7)}-${value.substring(7)}";
    }

    return value;
  }

  String _cleanTelStr(String value) {
    return value.replaceAll(RegExp(r'[-\s]'), '');
  }
}