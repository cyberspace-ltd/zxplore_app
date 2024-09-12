import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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