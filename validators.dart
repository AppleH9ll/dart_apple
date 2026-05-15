bool isNotEmptyString(String? value) {
  return value != null && value.trim().isNotEmpty;
}

bool isPositiveInt(int value) {
  return value > 0;
}

bool isValidDateTime(String value) {
  try {
    DateTime.parse(value);
    return true;
  } catch (_) {
    return false;
  }
}