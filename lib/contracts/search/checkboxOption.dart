class CheckboxOption {
  String title;
  bool value = false;

  CheckboxOption(
    this.title, {
    bool? value,
  }) {
    this.value = value ?? false;
  }
}
