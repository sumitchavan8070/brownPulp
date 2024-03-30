import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_regex.dart';

class NumberOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (MyRegex.numericRegexWithoutDecimal.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}

class NameTitleCaseInputFormatter extends TextInputFormatter {
  final RegExp namePattern = MyRegex.alphabetRegex;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final unformattedText = newValue.text;
    final formattedText = _formatToTitleCase(unformattedText);

    if (namePattern.hasMatch(formattedText)) {
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      // If the input does not match the pattern, return the old value
      return oldValue;
    }
  }

  String _formatToTitleCase(String input) {
    final words = input.split(' ');
    final formattedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return '';
      }
    });

    return formattedWords.join(' ');
  }
}

class AlphabetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (MyRegex.alphabetRegex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      // If the input doesn't match the pattern, return the old value
      return oldValue;
    }
  }
}

class AlphanumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (MyRegex.alphaNumeric.hasMatch(newValue.text)) {
      return newValue;
    } else {
      // If the input doesn't match the pattern, return the old value
      return oldValue;
    }
  }
}

class NumberWithDecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    debugPrint("------------- ${MyRegex.numericRegex.hasMatch(newValue.text)}");
    if (MyRegex.numericRegex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      // If the input doesn't match the pattern, return the old value
      return oldValue;
    }
  }
}
