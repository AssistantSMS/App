import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final TextStyle style;
  final String numberString;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const CurrencyText(
    this.numberString, {
    Key? key,
    required this.style,
    required this.textAlign,
    required this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = '';
    String tempResult = '';

    String tempDecimalNumberString = '.0';
    String tempNumberString = numberString;
    int decimalIndex = numberString.indexOf('.');
    if (decimalIndex > 0) {
      tempNumberString = numberString.substring(0, decimalIndex);
      tempDecimalNumberString =
          numberString.substring(decimalIndex, numberString.length);
    }

    for (int index = 0; index < tempNumberString.length; index++) {
      if (index % 3 == 0 && index > 0) {
        // tempResult = tempResult + ',';
        tempResult = tempResult + ' ';
      }
      tempResult =
          tempResult + tempNumberString[tempNumberString.length - (index + 1)];
    }
    for (int index = 0; index < tempResult.length; index++) {
      result = result + tempResult[tempResult.length - (index + 1)];
    }
    result += tempDecimalNumberString;
    return Text(result, textAlign: textAlign, style: style, overflow: overflow);
  }
}
