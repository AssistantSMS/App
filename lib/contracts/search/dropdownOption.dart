import 'package:flutter/material.dart';

class DropdownOption {
  String title;
  String value;

  DropdownOption(this.title, {String value}) {
    this.value = value ?? this.title;
  }

  DropdownMenuItem<String> toDropdownMenuItem() {
    return DropdownMenuItem<String>(
      child: Text(this.title),
      value: this.value,
    );
  }
}
