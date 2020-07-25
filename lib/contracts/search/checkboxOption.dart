class CheckboxOption {
  String title;
  bool value;

  CheckboxOption(this.title, {bool value}) {
    this.value = value ?? false;
  }
}
