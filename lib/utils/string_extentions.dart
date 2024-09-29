import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String?> itemStages =['Saved','Draft',null];

extension ValidatorX on String {
 String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
  
    
    
    }

    String getDayDateAndYear(String? dateString) {
  final DateTime dateTime = DateTime.parse(dateString!);

  final String formattedDate = DateFormat('d MMMM yyyy, EEEE').format(dateTime);

  return formattedDate.capitalize();
}

Color stageColor(String? stage)
{
  switch(stage){
    case 'Draft':
      return Colors.purpleAccent;
    case 'Pending Posting':
     return Colors.yellow;
   default:
     return  Colors.green;

  }
}

// Function to format date
String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return '';
  }
  DateTime date = DateTime.parse(dateString);
  return DateFormat('dd MMM yyyy, hh:mm a').format(date);
}

String formatNumberInKs(int? number) {
  if(number==null) return '0';
  if (number < 1000) {
    return number.toString();  // Show numbers less than 1000 as they are
  } else if (number >= 1000 && number < 1000000) {
    int thousands = number ~/ 1000;  // Get the number of thousands
    if (number % 1000 == 0) {
      return '${thousands}k';  // Exact thousands, e.g. 1k, 2k
    } else {
      return '${thousands}k+';  // Thousands with extra digits, e.g. 1k+, 2k+
    }
  } else if (number >= 1000000) {
    int millions = number ~/ 1000000;  // Get the number of millions
    if (number % 1000000 == 0) {
      return '${millions}m';  // Exact millions, e.g. 1m, 2m
    } else {
      return '${millions}m+';  // Millions with extra digits, e.g. 1m+, 2m+
    }
  }
  else if (number >= 1000000000) {
    int billions = number ~/ 1000000000;  // Get the number of millions
    if (number % 1000000000 == 0) {
      return '${billions}m';  // Exact millions, e.g. 1b, 2b
    } else {
      return '${billions}m+';  // Millions with extra digits, e.g. 1b+, 2b+
    }
  }
  return number.toString();  // Fallback, should never hit this line
}
DateTime? stringToDate(String? dateString, {String format = 'yyyy-MM-dd'}) {
  if (dateString==null|| dateString.isEmpty) return null;
  try {
    return DateTime.parse(dateString!);
  } catch (e) {
    // If standard ISO 8601 format fails, try custom format
    try {
      return DateFormat(format).parse(dateString!);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }
}