// used to remove everything like +, (), spaces etc & only keep the number
import 'package:intl/intl.dart';

RegExp numberRegEx = RegExp(r"\D+");

String normalizeDate(DateTime? date) {
  if (date != null) {
    return DateFormat('d MMM y - H:m').format(date);
  }
  return "Error";
}

const String numbersCollection = "fraud_numbers";
