bool passwordValidation(String? value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,30}$';
  RegExp regExp = RegExp(pattern);

  return !regExp.hasMatch(value!);
}

bool nickIDValidation(String? value) {
  String pattern = r'^[A-Za-z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,3}$';
  RegExp regExp = RegExp(pattern);

  return !regExp.hasMatch(value!);
}

bool idValidation(String? value) {
  String pattern = r'^[A-Za-z0-9]{5,20}$';

  RegExp numExp = RegExp("[0-9]");
  RegExp regExp = RegExp(pattern);

  if(numExp.hasMatch(value![0]))
    return true;
  else
    return !regExp.hasMatch(value);
}