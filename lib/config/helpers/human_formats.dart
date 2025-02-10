import 'package:intl/intl.dart';


class HumanFormats {

  static String number( double number, [ int decimals = 1 ] ) {

    return NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);
  }

  static String shortDate( DateTime date ) {    
    final format = DateFormat('yyyy-MM-dd');
    return format.format(date);
  }

}