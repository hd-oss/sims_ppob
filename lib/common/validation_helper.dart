String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Format email tidak valid';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password tidak boleh kosong';
  }
  if (value.length < 8) {
    return 'Password minimal 8 karakter';
  }
  return null;
}

String? requiredField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Tidak boleh kosong';
  }
  return null;
}
