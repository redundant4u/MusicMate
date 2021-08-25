bool passwordValidation(String? value) {
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);

  return !regExp.hasMatch(value!);
}

bool idValidation(String? value) {
  RegExp regExp = RegExp("[a-zA-Z -]");
  return !regExp.hasMatch(value!);
}