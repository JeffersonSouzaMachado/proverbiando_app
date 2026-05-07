import 'package:intl/intl.dart';

String dateFormatter(String date) {
  final parsedDate = DateTime.parse(date);

  final dateFormatted = DateFormat(
    'dd MMM yy',
    'pt_BR',
  ).format(parsedDate).toUpperCase();

  return dateFormatted;
}
