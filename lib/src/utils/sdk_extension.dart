import 'dart:convert';

extension TypesConversionExtension on dynamic {
  bool? get valueTypeToBool {
    var value = toString();
    bool? newValue;

    if (value.isNotEmpty && isNumeric) {
      newValue = (value == '1' ? true : false);
    }

    if (value.isNotEmpty) {
      if (value.trim().toLowerCase() == 'false') {
        return false;
      }

      if (value.trim().toLowerCase() == 'ok' ||
          value.trim().toLowerCase() == 'true') {
        return true;
      }
    }

    return newValue;
  }

  bool get isNumeric {
    if (this == null) {
      return false;
    }
    return double.tryParse(toString().trim()) != null;
  }

  int? get valueTypeToInt {
    if (this is String && this.trim().isNotEmpty && isNumeric) {
      return int.parse(this.trim());
    }

    if (this is int) {
      return this.toInt();
    }

    return null;
  }

  double? get valueTypeToDouble {
    double? result;

    if (this is double) {
      return this;
    }

    if (this is String && this.isNotEmpty && isNumeric) {
      result = double.parse(this.trim());
    }

    if (this is int) {
      result = this.toDouble();
    }

    return result;
  }
}
extension StringsExtension on String? {

  bool get isNullOrEmpty => this == null || this!.trim().isEmpty == true;

  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;

  bool get isJsonString {
    try {
      if (isNullOrEmpty) {
        return false;
      }
      var data = json.decode(this ?? '');
      if (data is Map) {
        return true;
      }
      return false;
    } on FormatException catch (_) {
      // logger.e(error.message);
      return false;
    }
  }
}