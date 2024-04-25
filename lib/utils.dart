import 'package:intl/intl.dart';

DateTime? getDateFromString(String dateTime) {
  try {
    final formatter = DateFormat("dd/MM/yyyy");
    final out = formatter.parse(dateTime);
    return out;
  } catch (e) {
    print(e);
  }
  return null;
}

DateTime? getDateFromNumber(int serializedValue) {
  // Convert serialized value to DateTime
  DateTime dateTime =
      DateTime(1899, 12, 30).add(Duration(days: serializedValue));

  return dateTime;
}

DateTime? getTimeFromString(String dateTime) {
  if (dateTime.isEmpty) return null;
  List<String> formats = const [
    'hh:mm a',
    'hh:mm',
  ];
  for (String format in formats) {
    try {
      final formatter = DateFormat(format);
      final out = formatter.parse(dateTime);
      return out;
    } catch (e) {}
  }
  throw const FormatException('Input did not match any supported format');
}

String getStringFromTime(DateTime dateTime) {
  final formatter = DateFormat("hh:mm a");
  final out = formatter.format(dateTime);
  return out;
}

String getStringFromDate(DateTime dateTime) {
  final formatter = DateFormat("dd/MM/yyyy");
  final out = formatter.format(dateTime);
  return out;
}
